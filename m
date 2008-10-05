From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Files with colons under Cygwin
Date: Sun, 5 Oct 2008 11:04:25 +0200
Message-ID: <81b0412b0810050204y6bd91ddbn250ddf9051738969@mail.gmail.com>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com>
	 <20081004233945.GM21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Giovanni Funchal" <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 11:06:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmPYt-0002OK-ET
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 11:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbYJEJE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 05:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbYJEJE1
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 05:04:27 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:53038 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbYJEJE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 05:04:26 -0400
Received: by yx-out-2324.google.com with SMTP id 8so357088yxm.1
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0ivk5Lm5Rw6DeQCHo+B9Pi8lYYxIjvnxJPT662Gniv4=;
        b=xb61ZrLT8+i1TARuRfxaRa+c8qGr+UQHz7+Ptil9Ab18NraisPNwq636H1lLw8VUnE
         MxyXTRo1fgFFfnmJVa2IV0gAXtF30B+O3vLmGO16X9EtageUq7rL2q15l0LTg4vQSWHP
         zRSHamzNURocEnXC6higgyjBOF7kicOqDlPG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=E6kpnafdsFk+baqlTY8Yd8Vh3G9id4VF5Xb9J2kjpBgkCat/evb9U7pPmSY8Oh9Fm+
         QsxZkXOP+XhPD6FuYBtsIc6DQw5Zhfb0ljnMhuPkDt7SjTYys0muy7+2Kuw7vYt9cALw
         FNpoKzWTkR+gg0ZLQj/A09Xbzs9es6bzZ6gqo=
Received: by 10.100.111.11 with SMTP id j11mr3471082anc.55.1223197465141;
        Sun, 05 Oct 2008 02:04:25 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Sun, 5 Oct 2008 02:04:25 -0700 (PDT)
In-Reply-To: <20081004233945.GM21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97501>

2008/10/5 Dmitry Potapov <dpotapov@gmail.com>:
> On Thu, Oct 02, 2008 at 04:02:23PM +0200, Giovanni Funchal wrote:
>>
>> Cygwin does not allow files with colons, I think this is Windows stuff
>> one just can't avoid.
>
> At least, you cannot use colon in Win32 API. They say Windows "native"
> API has less restrictions over what symbols are not allowed in file
> names, but I guess it is still not allowed.

The part after colon in the file name specifies the identifier of an
alternative data stream (so there can be multiple data sets under one name).
Just another microsoft stupidity no one uses and knows about.

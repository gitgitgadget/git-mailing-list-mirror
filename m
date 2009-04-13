From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Error Building 1.6.2.2 on Cygwin
Date: Mon, 13 Apr 2009 08:16:46 -0400
Message-ID: <c115fd3c0904130516y3bef1ff3x44d99e7b1dd72a45@mail.gmail.com>
References: <c115fd3c0904091210u398ea4bag62eac3a6deaffa5f@mail.gmail.com>
	 <be6fef0d0904092015o10457ca7u844fe868aae4de6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 14:18:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtL7G-0007QI-0r
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 14:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbZDMMQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 08:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbZDMMQs
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 08:16:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:2617 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbZDMMQr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 08:16:47 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2154531ywb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 05:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LsS6F+DXnevG7vzY6ubtfRz849Lrm+1xomlGyHB0HTU=;
        b=oYEbH6FOfG743x68eRnPyukrZXyPZ+nKe+mDchDPLaiKYGLCUyWQ0Crjaz2DvSCDQL
         sYtc4sAwgF7cSrEHskd+j5QurdbjXMlLYwMapzgWUfOL6NS7TuuIHpY4FtpiVshsJtuM
         b96x7byGJMSvzfOoHzb5ZWf6bcZw4oDH4PBfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uWopsULaS31RVg/l5MguvyJtojmFPqBkeYRyE7gK4qcB/7XPNaPGPtw5kVEpDmD0i4
         fj6DvcG5X8WkD3u9IlWntrfU27DIWmF6N3tXFSxX/01+XJ7C7DfVfBpMsmRuixmTmlYs
         WpQYsXxxbN/JXkryE/Ao/6ddhhw4sBuWEj8Vo=
Received: by 10.100.165.13 with SMTP id n13mr2073550ane.112.1239625006234; 
	Mon, 13 Apr 2009 05:16:46 -0700 (PDT)
In-Reply-To: <be6fef0d0904092015o10457ca7u844fe868aae4de6b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116434>

On Thu, Apr 9, 2009 at 11:15 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Fri, Apr 10, 2009 at 3:10 AM, Tim Visher <tim.visher@gmail.com> wrote:
>> cannot find -liconv
>
> you need to get the libiconv package using the cygwin installer.

Thanks, Ray.  That fixed it.  I had libiconv2 but I guess it's not
backwards compatible.

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail

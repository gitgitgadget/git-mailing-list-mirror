From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: auto commit merge using the default merge message
Date: Thu, 23 Apr 2009 21:31:10 -0400
Message-ID: <81bfc67a0904231831y31bfb057pa5eaa86d0e153824@mail.gmail.com>
References: <81bfc67a0904230046j48ed06b7s5693406332ee52dc@mail.gmail.com>
	 <81b0412b0904230057k1653d039vfc3962e6affda584@mail.gmail.com>
	 <49F025E7.7090404@drmicha.warpmail.net>
	 <7vocunwz1n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 03:32:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxAHY-0005Jk-Rv
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 03:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbZDXBbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 21:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbZDXBbM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 21:31:12 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:12930 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbZDXBbL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 21:31:11 -0400
Received: by an-out-0708.google.com with SMTP id d40so542964and.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 18:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eHuXkjiboPdntnQeQ35HvTTsJvRR0w4OP/fEt7dGLgw=;
        b=im/R/Vzfwu0kb5lZwHm+IZL4H9Lg1w8cotNAI43nRqe/y8CW0rherbzZeDIEhLNHF6
         NcQXlov1Q5irRMOGa6tZM2iErzEDR88In8akLqeqId7Ts73huysvx4tivvZVTP52zhCY
         0ZkrJRoZBbp5sEiVKqHpjXfFzyl/fCmnQ+Q14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qj1CIJDEU/dVa8yrLPY/NjumQsGX0DMXaO2Ugarob5P7sseAbwIKXZdAX937hz21PG
         o7YSHgJsxVDFwrnkcD9fgyrHOokOC/pE4IJHqMznuSiP0iLK9j6VsY8mjkjfYbjclLM7
         BPdaPuqw4u36iHNj9QTvF0gfGVH1Gxqkw+Ax8=
Received: by 10.100.216.10 with SMTP id o10mr2208881ang.159.1240536670311; 
	Thu, 23 Apr 2009 18:31:10 -0700 (PDT)
In-Reply-To: <7vocunwz1n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117401>

On Thu, Apr 23, 2009 at 4:32 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Use "GIT_EDITOR=3D:" instead. =C2=A0It also is *true* just like /bin/=
true, but
> git knows a simple magic about this and avoids an extra fork+exec.
>

So I could put

GIT_EDITOR=3D:

at the top of my shell script, and then whenever I need to do a
commit, just git commit and it'll work (assuming the commit has a
default message).

--=20
Caleb Cushing

http://xenoterracide.blogspot.com

From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] grep: color search patterns
Date: Tue, 10 Mar 2009 17:01:24 +1100
Message-ID: <fcaeb9bf0903092301i7bc6322dtbd37f662fe4b224b@mail.gmail.com>
References: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thiago Alves <thiago.salves@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Mar 10 07:02:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgv3I-0008GL-2l
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 07:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbZCJGB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 02:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbZCJGB1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 02:01:27 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:2961 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbZCJGB0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 02:01:26 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2409661wfa.4
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 23:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GXQkYECezK83C6BgqIW7LJaWvC9V5C4WahZCbE/plmM=;
        b=hASgujziMgxCefu/2vHtjaI2br7ypt4zay4vJgZKAx7GbnONFRC8/ZWfXHnvSamnAc
         ZhoQhFuZFCrgyRGyNAu99iu36XlnEIZuPZ38WxeHO7ep3G4DhV0ajKx7tRuU+3eo4fg1
         m2oW1VhWBHWFlFdm7oNHmafM1z+m7Ioq0pDWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=A4VOtpwgynxG6oE1tltD6cihaH6TfbNTp7vEso2D+GPGCUX6bqg0CMGJpAqW9CwO95
         eIpx7OiAzaf0oypM247B9XBbGOBiAxTR/Hh5H6hI4iy6QpE3YFa8ZWG/3CSanprGOqU3
         9EUpBHNSwRIILOwDGraZMdOLs21rzvvWoZxaY=
Received: by 10.142.241.10 with SMTP id o10mr2921563wfh.119.1236664884975; 
	Mon, 09 Mar 2009 23:01:24 -0700 (PDT)
In-Reply-To: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112780>

On 3/7/09, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> Match coloring is a major missing feature of git grep.  It makes read=
ing
>  the output much easier and brings grep onto the same visual level as=
 the
>  other colorized git commands.

"git --color test" did not colorize the result for me. "git --color
--no-ext-grep test" did. Maybe you should ignore external grep unless
it is explicitly requested, like in the last patch. I have very
limited net access these days. Let's see if I can work out something
for tomorrow, unless you beat me to it.
--=20
Duy

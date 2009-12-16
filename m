From: Frank Li <lznuaa@gmail.com>
Subject: Re: TortoiseGIT
Date: Wed, 16 Dec 2009 14:26:22 +0800
Message-ID: <1976ea660912152226r63f549d0oc64f93eaf0d4abe2@mail.gmail.com>
References: <a362e8010912150741x2c39c01bh1f64e669726dafab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Wed Dec 16 07:26:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKnLD-0005Dv-9O
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 07:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761628AbZLPG0Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2009 01:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761602AbZLPG0Y
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 01:26:24 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:61369 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662AbZLPG0X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2009 01:26:23 -0500
Received: by ywh12 with SMTP id 12so792620ywh.21
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 22:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vucPyb21SWsNu29hm00SGcp0Zcsx4rIq/uZRHrbL4OQ=;
        b=s6TSI6dYpov9NyQ0H7U7VFWWHLUeoEcLcwIiL03vIW3SKh6oi5oFoYYV6qmOBylvbQ
         Bv1UKhrl6DWXPYz1biuyr9nmEM4zOMbq6c03oXRD0bmehCxuuvmxFMyEm4x7FOREYCsh
         2NhZwpWnR8dTtFCaKYCYBVye1D1wA/9lM+m3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B7aeWR286weN5y/iXGw6TzXm50qY+l28lAWQJ8x5+YAAUN+iScwFdr7/ApTkMd8H89
         KRx0tWgVQWR6f1UDMduTlQJy8vrLOWfk79Nhb1Ygk0ELJ+1d6Dz7Mb2ab8snVy1XSl9o
         ShdvIK/x4N5kfln4TZoxNFG2k+8sHWY5L8+Hk=
Received: by 10.150.89.17 with SMTP id m17mr1082003ybb.91.1260944782482; Tue, 
	15 Dec 2009 22:26:22 -0800 (PST)
In-Reply-To: <a362e8010912150741x2c39c01bh1f64e669726dafab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135322>

You keep cr+lf on/off on whole develop cycle.  Avoid change it during
developing.
After change cr+lf setting, I perfer you remove all work copy and
recheckout all.

best regards
=46rank Li


2009/12/15 Laszlo Papp <djszapi@archlinux.us>:
> Hello,
>
> I had got a problem in the past with cr + lf between windows and linu=
x
> client(maybe now too).
> I heard that from more experienced users I need to set autocrlf +
> safecrlf on windows, and core.autocrlf false on linux (which is the
> default), but If I set core.autocrlf true on linux too, it worked
> normally, after a git pull on windows I don't see any modified file
> that should be committed, not the case in core.autocrlf false.
>
> Could someone explain this habbit of git, please ?
>
> Everybody said I need to set autocrlf for false, but it doesn't work
> so, just with true on linux client, what do I do wrong ?
> It's okay now for me, because it works without any problem, I just
> don't understand the behaviour of it, and I don't know whether it wil=
l
> cause further problems.
>
> Thanks in advance!
>
> Best Regards,
> Laszlo Papp
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

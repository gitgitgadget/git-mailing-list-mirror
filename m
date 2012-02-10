From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: fatal: Unable to find remote helper for 'https'
Date: Fri, 10 Feb 2012 08:25:01 +0800
Message-ID: <CALUzUxq=5iJJNcXH-Xg1htZzGFVT4f5WQS=dy4k7Y_mRemXMSw@mail.gmail.com>
References: <loom.20120209T224147-400@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nickolai Leschov <nleschov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 01:25:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RveIY-0004sT-DA
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682Ab2BJAZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 19:25:04 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40184 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758658Ab2BJAZD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 19:25:03 -0500
Received: by wgbgn7 with SMTP id gn7so6826997wgb.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 16:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GmQf425WNgzMb7N8xEq9TW6Z7fej689s+TcPgE/2pXo=;
        b=rtck9oXK95N2OdhwpRQobKNWOEPWrBEbXWwNdf92wHr/nqcwXrhlnCWqfQemzSBI+M
         VUFFDpImwP4S4L2TnUe2LkW1sH8sPhAp8E5+d0CrRAOEQLcYPvaXklqmCUuTipM1eUmx
         x7qYNsLU5afRbV0bwez5tzfwDAzItfsSv+rV0=
Received: by 10.181.13.113 with SMTP id ex17mr5964588wid.15.1328833501610;
 Thu, 09 Feb 2012 16:25:01 -0800 (PST)
Received: by 10.223.108.11 with HTTP; Thu, 9 Feb 2012 16:25:01 -0800 (PST)
In-Reply-To: <loom.20120209T224147-400@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190354>

Have you installed libcurl4-(gnutls|openssl)-dev? You'll need to
choose between gnutls and openssl for the underlying ssl
implementation.

--=20
Cheers,
Ray Chuan


On Fri, Feb 10, 2012 at 5:51 AM, Nickolai Leschov <nleschov@gmail.com> =
wrote:
> Hello,
>
> I have compiled git 1.7.9 from source on Ubuntu 9.04 and I get the fo=
llowing
> message when cloning a git repo:
>
> fatal: Unable to find remote helper for 'https'
>
> I get this message when I try to use https; or similar one for http. =
Only
> cloning via git:// protocol works. My system is Ubuntu 9.04 i386. git=
 1.7.9 and
> two previous versions I tried all exhibit this problem. I have uninst=
alled the
> git that comes in Ubuntu repositories and build from source instead b=
ecause I
> need a newer version.
>
> How can I make git work on that system?
>
> I have another system with Ubuntu 11.04 i386 and it there git 1.7.4.1=
 (from
> repositories) doesn't exhibit such problem.
>
> Best regards,
>
> Nickolai Leschov
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

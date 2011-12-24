From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Gitk: shortcut to jump to the current HEAD (yellow spot)?
Date: Fri, 23 Dec 2011 20:22:59 -0800
Message-ID: <CAOeW2eGCKxYW1TT-HPoSCO0_PsQPX5C-bcHLUy73MTd7=CsqRA@mail.gmail.com>
References: <4EF3517A.8030108@dirk.my1.cc>
	<874nwslayi.fsf@fox.patthoyts.tk>
	<4EF4CE80.8090502@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Dirk_S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat Dec 24 05:23:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReJ8o-00076f-Oi
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 05:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048Ab1LXEXB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Dec 2011 23:23:01 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35123 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab1LXEW7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Dec 2011 23:22:59 -0500
Received: by iaeh11 with SMTP id h11so16039409iae.19
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 20:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bgJB3DKmSDhwrb7BhL03+t0+MqS6bkiuUAf49FMCl9Y=;
        b=gAm8T936bvG3AFSHCitY0ZpVK4ltVXwloLJxTd9pfDvYn/XpV29Prmd0gpqhK0ng7+
         moIPdPsm1dbqqn7XtxWI7xYDhcTWt0SGk1XN2p+zoYaUYCH9tXtrL/TSLGQimzC4L5ae
         /1dHVVvxLNoo7cmU0QMs7ni4L+llqi3ISJgYA=
Received: by 10.50.181.136 with SMTP id dw8mr16502514igc.6.1324700579136; Fri,
 23 Dec 2011 20:22:59 -0800 (PST)
Received: by 10.231.185.32 with HTTP; Fri, 23 Dec 2011 20:22:59 -0800 (PST)
In-Reply-To: <4EF4CE80.8090502@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187650>

2011/12/23 Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>:
>
> That's because gitk behaves odd (at least to me) when not run from th=
e
> top-level directory. E.g. the "touching paths" box won't find files i=
n
> the top dir if you don't prefix them with a slash.

This should be fixed in c332f44 (gitk: Fix file highlight when run in
subdirectory, 2011-04-04), which is in the current master and thus, I
believe, to be released in Git 1.7.9.

Martin

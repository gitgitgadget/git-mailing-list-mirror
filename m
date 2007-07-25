From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Windows support
Date: Wed, 25 Jul 2007 03:35:26 -0700
Message-ID: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 12:35:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDeDM-0004jH-4M
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 12:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929AbXGYKf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 06:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbXGYKf2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 06:35:28 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:38753 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbXGYKf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 06:35:27 -0400
Received: by nz-out-0506.google.com with SMTP id s18so132506nze
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 03:35:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VhSLDoQMKK8hQtxpEGqX+p/Z39zGSHBLBGvHT8z9lq/jn2Me4YspZ3YWNfiBIpZxYWFZtRTRqabJ24xcxwsG/XYs0rNPwKpq76ftvjeFVIBGgQDX79T1kaNA28rThmYsNxNDDfM3Wcx6ZVssmEUxuwp0sglTNy+xFk8Ez1TDNUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=U51Ys0kAFxgQY5mavkphhU2IpeGkN2Tsa2O+oLP6YpS9Xdz94equdKZ5g3oT+9BNoOcLCI+DI0h1l9kxw3za610lkyGRUx/RdUAjnoehJZAPH3YzhipBj5F6xnEYqf68+ENEtdpFlheh00RrXmv6LX4o82UUt8k5lRed7IqES+4=
Received: by 10.141.19.16 with SMTP id w16mr149367rvi.1185359726606;
        Wed, 25 Jul 2007 03:35:26 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Wed, 25 Jul 2007 03:35:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53680>

How serious are you guys about Windows support?
I'm talking fully-functional port, not Cygwin.
I did a lot of searching for a new SCM to switch to (from Perforce).
And Git is my #1 choice. I love it's internals design and it's
expressive power. I've also tested git-p4 and it has worked like a
charm with my depot (with few tweaks that I may contribute later).
But I do all my work on Windows so I need Git-For-Windows-Done-Right :-).
The current mingw port is not there yet.

Transition to the new SCM must happen now, so basically I have 2 choices:
1. Survive for a few months with the current CygWin port of Git
knowing that Windows support is coming
2. Use another SCM (#2 is Mercurial, #3 is Monotone)

I'd realy love to do #1, but I need to know how long do I have to wait.

- Dmitry

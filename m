From: Christian Couder <christian.couder@gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 13
Date: Wed, 16 Mar 2016 15:48:20 +0100
Message-ID: <CAP8UFD22qp0jdOW7g=95U_ZzaB6ReUO4WqCgUsiQgGwgin=wvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	lwn@lwn.net, Josh Triplett <josh@joshtriplett.org>,
	Kevin Wern <kevin.m.wern@gmail.com>,
	Sarah Sharp <sarah@thesharps.us>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Bhavik Bavishi <bhavikdbavishi@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Blake Burkhart <bburky@bburky.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?c2hpcmlzaCDgpLbgpL/gpLDgpYD
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:48:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agCkN-00036M-TD
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 15:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935071AbcCPOsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 10:48:23 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33785 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933471AbcCPOsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 10:48:22 -0400
Received: by mail-lb0-f181.google.com with SMTP id oe12so49685433lbc.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=fVe/FmnQar7U0nzLOh2mda1G3MfGtk2aMhca5BvqDfc=;
        b=atnLEWZ1j3J727+MWnYCgiPYs/JdvRCLGLrYnXnBBEInxJ3cJJurJh8S7gsRRZPKU4
         ePBRZ2BzfXPBDD0xZNSTXEyjlcmHkSnKziAP2Yfgl0RZYjGBKuJVfBixkTptcMcpM3mA
         l8+gUgbLtbBBMRdjJUvr7UrR3WM6t+QtxuPqTpTwn3rumItpScrvDUhSFqZ6G5UIPiCq
         bo1lBoC7OsrMH98yOynER4zs5AmGUEMYvK9WtgROHG0P1d/2dSfa50+8G+PReJ1So2QA
         TBGkxcaz3DZ0ROirItaeqafGYSfhpwhPwMCgDIB9c0cLywQ5Lc6783Ifbkw7/RZPqEmM
         r2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=fVe/FmnQar7U0nzLOh2mda1G3MfGtk2aMhca5BvqDfc=;
        b=SWuzudlr0i+po0yyMdp5rLXcP2DC/uTKW8JoOhoaSwoqoO81IFJozZYb0tW80DDjZl
         mkRKtoBa6MSQAPHlLB0sYeaMlERGz5K56V6QNHGbMA0KjfdjKgmqCBnwqoNlYsQVI+TG
         fo0pU9aCIq9qSTkPIxOyGRCvUzDyvzjNlRIvyDuF52DkTIjjoO64pBe9EjDTyZsSsdqG
         5cWu2w+3EC5RGzss3kxzR1K9/Nb5vf55kVrOFj4Ny06xFtbZiIlaUhSWws7hgFC5FJZo
         Qsv7aEoN0A0l40z1atxYasYPPvRtqy10xSZ48+hBZ4crwIg8bMPmb2LdW0SLFFdzjxGY
         fYcQ==
X-Gm-Message-State: AD7BkJKGliMoyVVpeNua0ZiTsZ9DaP9Iz7PlxSm822bqNzmp2iu8+BdkAS6164iDrUwRgB++rJgnDWS5VbOv6w==
X-Received: by 10.112.97.162 with SMTP id eb2mr1563395lbb.132.1458139700294;
 Wed, 16 Mar 2016 07:48:20 -0700 (PDT)
Received: by 10.25.137.130 with HTTP; Wed, 16 Mar 2016 07:48:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288978>

Hi everyone,

I'm happy announce that the 13th edition of Git Rev News is now published:

http://git.github.io/rev_news/2016/03/16/edition-13/

Thanks a lot to all the contributors and helpers, especially Lars
Schneider and Sebastian Schuberth!

Enjoy,
Christian, Thomas and Nicola.

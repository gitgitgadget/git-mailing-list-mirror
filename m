From: Shilong Wang <wangshilong1991@gmail.com>
Subject: [Question] Git recovery with HEAD commit broken
Date: Wed, 11 Dec 2013 22:38:37 +0800
Message-ID: <CAP9B-Q=ARp00Bj5zJ0J=3qv9R16YGu5AZgLpqoO0y+cY1at1Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wang Shilong <wangsl.fnst@cn.fujitsu.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 15:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqkw0-0004OE-2T
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 15:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922Ab3LKOik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 09:38:40 -0500
Received: from mail-qe0-f45.google.com ([209.85.128.45]:60801 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab3LKOij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 09:38:39 -0500
Received: by mail-qe0-f45.google.com with SMTP id 6so5483295qea.32
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 06:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=pFtRun/YwmwLg+S2SOO+Ve9oJqX55dy5VnLXVEsZTuw=;
        b=yPxpQNtB5/axi7VKLuZdE/gowzAY2jroXXsupy6wnuIcBId0uXGqWMjimbo0TDteiO
         16ZT4fnKLKcI2OwTyls8IS2HILvdDk6iUuxTuavTflENKUnnORudhe06SKIAORlB9CnH
         Cx16G7tK853/zB/Qd/0QOKSV8wMrpsbSud8scSVvyCanOOvv51+A7NrYQR0QqDPzQPVI
         woAGcyn3hO+/gbi79MF/k8piQlH7Et86X0RttpkB31iMHjY1NcvmuOYXtiLKyBBC+KPl
         7MJTTf0aXBnR2QrxJy2PJxv+uV85ym8i6WYFAEtGMeCi9XDIjE24ZMK7UDxVzc99yh2+
         zHYw==
X-Received: by 10.224.7.10 with SMTP id b10mr3396258qab.12.1386772717450; Wed,
 11 Dec 2013 06:38:37 -0800 (PST)
Received: by 10.229.144.195 with HTTP; Wed, 11 Dec 2013 06:38:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239202>

I am not a developer for git, but i am a regular user with git, i came
the following problem:

A power off cause my top commit broken, and then git
branch/log/reflog..etc won't work.
I do a hack that i change the HEAD commit to the one that i can make
sure is right, and then
i do:

# git reset --hard HEAD

In fact, i hope git fsck can fix up such problems(maybe can backup top
commit for example)...
Someone has faced such problems or have some suggestion for this?

Thanks,
Wang

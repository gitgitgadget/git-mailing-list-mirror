From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.7.7
Date: Thu, 26 Apr 2012 12:50:27 -0700
Message-ID: <xmqq1una8dmm.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 22:03:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNUuU-0000Fp-5u
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113Ab2DZUDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:03:17 -0400
Received: from mail-lpp01m010-f74.google.com ([209.85.215.74]:38960 "EHLO
	mail-lpp01m010-f74.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754362Ab2DZUDQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 16:03:16 -0400
Received: by laai8 with SMTP id i8so76735laa.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 13:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-type:x-gm-message-state;
        bh=OLpgFbdCZW4jDUOV0xJy1gMKNQbq3emYLL7NkBjZY4M=;
        b=BywzMp+l9Y3C3qQAIcDFMZdyKTQtQV+2VImXpK9MgCOf3GnQkkM3R/jv37GNDQlmc3
         WFrLtNBWM2LA4wYKkvUgqAsqqcEgLHLjePmN5AtU2huFLh8lbSjqgmTq9/QHqSMo6Zeh
         FmQt1JGp72vBEq04jGJT96B8RmLCd95maZ8tqHcz7AP4G/+M9y28lJ7sB2eKk08mhF4n
         uRgxo+mkJ1bhWTk+/lNtXDG2ZjK22YpjQrVuMAJ/8zuZeza/r0TYGq3Z1nXzYU5hulED
         6H74xTl1gYR6KtTkf50u7v8lQfW5/STbu/gnGpkIbsvehmBn6arMvrdbH4jZe7H1dHgg
         FU3w==
Received: by 10.14.47.80 with SMTP id s56mr2460897eeb.6.1335470595056;
        Thu, 26 Apr 2012 13:03:15 -0700 (PDT)
Received: by 10.14.47.80 with SMTP id s56mr2460889eeb.6.1335470594949;
        Thu, 26 Apr 2012 13:03:14 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si3781425eef.1.2012.04.26.13.03.14
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 13:03:14 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id BB30220004E;
	Thu, 26 Apr 2012 13:03:14 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 050BCE125C; Thu, 26 Apr 2012 13:03:13 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmEaP9ujlAhO5bEMypiXDiAjooohURv2bO+6g0SyAbgoaTdm3QVty/VGXjCMQ7NbiLpLwbmYlZEDUmRL2d9uN4kUGjbYvygk13jybJRIHGIL+sf/S/BB4vDyWnaBKDDBgxJ48jwU1LZpmrLE35wvM/HAa5DvNpQIlSRSzoR0bp3ElZyr68=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196399>

A maintenance release Git 1.7.7.7 is now available at the usual
places.

This contains only minor documentation fixes.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

6fbb215ab20afaf4cca6b1e5a7e4ff4b3b62303c  git-1.7.7.7.tar.gz
bb4552ccde7d8b7fdb98c113ce4373dbfb9672b6  git-htmldocs-1.7.7.7.tar.gz
a8341f8887abef23aacb3c56d75b8f87d73b22ff  git-manpages-1.7.7.7.tar.gz

Also the following public repositories all have a copy of the v1.7.7.7
tag and the maint-1.7.7 branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.7.7.7 Release Notes
==========================

Fixes since v1.7.7.6
--------------------

 * An error message from 'git bundle' had an unmatched single quote pair in it.

 * 'git diff --histogram' option was not described.

 * 'git imap-send' carried an unused dead code.

Also contains minor fixes and documentation updates.

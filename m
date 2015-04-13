From: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
Subject: git commit --date format
Date: Mon, 13 Apr 2015 23:42:18 +0800
Message-ID: <CAHtLG6SPqoZJ+bc6eaHEAkEN9VAwuq+hh4OUG8opOETRQKfUyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 13 17:44:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhgXg-0003rB-QG
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 17:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbbDMPm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 11:42:28 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36325 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932733AbbDMPmV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 11:42:21 -0400
Received: by lbbqq2 with SMTP id qq2so62511473lbb.3
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+GKtEvXE/Xnpf8EP62BGCb5OaAZqNY6pTNkFdJHHwME=;
        b=QewgRTfXdEufqBY+M3NrOjCFbFt3AuTgDlUZUBPiC/84g4HIfcWflh+MUeFgveMm4P
         Krj4/i86ic01ez4sIFDdSAU6Vu2dBrJ0T/EuwQBPjVs2U9GG0X4cfyKXlpi4VlfBS+07
         LN2Um9t7timjlhJYxYjH3sGV/GL5aVXCldgf4FeZhckuLHm8zLvhscroXw+xRg2kCqsC
         RrbxwFCa4TBWeJDclkFj8T6pvY7UdCPaQGt+wMle3FgfZGrmJiJl+Ix98pOEKsG7/5Fb
         p6ePGk5Xf2QjJBS3vdI9rEk1h1C8pXMQu3XcR5zk+dNh8zqE2HamBWoU5vf2RC/nbN/A
         MOjQ==
X-Received: by 10.112.167.36 with SMTP id zl4mr13573584lbb.22.1428939739037;
 Mon, 13 Apr 2015 08:42:19 -0700 (PDT)
Received: by 10.152.23.2 with HTTP; Mon, 13 Apr 2015 08:42:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267092>

Hi,

In git < 2.0, git commit --amend --date="" can amend commit with
current time as author time.
But since git 2.0, this does not work, dying with "invalid date format".
I have to instead type git commit --amend --date="now".
Is empty string date format no longer supported? Or will be fixed?

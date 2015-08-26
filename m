From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 0/4] per-worktree bisection refs
Date: Wed, 26 Aug 2015 15:46:01 -0400
Message-ID: <1440618365-20628-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Aug 26 21:46:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUgeI-00041t-2H
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 21:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbbHZTqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 15:46:13 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33792 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbbHZTqM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 15:46:12 -0400
Received: by qkfh127 with SMTP id h127so126452613qkf.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 12:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=UBspkzNMJ/GRyZg+e+PrJlj+WnxvofMlHXK1geouAts=;
        b=PeooYZQkU96gdbYWCbsFJ+oxg8MP7KW/tIzgWgORgYrzT0Ayr4RNgvWRHt+8L6EjB4
         UFpNc/PTHYAgt/NKzBiRMyq15o9dsE7Uw+EenQnT3ZGufvfdXDwCXyP1nJHdbeme6SHi
         bH0cZrz/wM/0E30o7n9n0o6GY/cWiic8WofeBJNFHI6MQYDOu0ExIibgoeURo6gmbZJ5
         sgVAFQswDBnfKU4rKYwSS/7lqUks5AW8jOSastTOvdZ4qMKCHd8Oq1Ha+3X4py6R0dCD
         4xHEF5CDhmStbwCmv5Xp+uDs0CO4XYyHp5J5u4iiQMfAI5scMyjzqsebzpmgoXYCP3nl
         1irg==
X-Gm-Message-State: ALoCoQmYBitjnSQxesOgmTTyzXAbfcTb/i6gNvO/l0OnrI/wgsahktXYdIIP3mqTvXLy0IVkx53j
X-Received: by 10.55.197.84 with SMTP id p81mr293719qki.90.1440618371505;
        Wed, 26 Aug 2015 12:46:11 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id t23sm8049326qkt.18.2015.08.26.12.46.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Aug 2015 12:46:10 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.622.gac67c30-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276628>

This reroll includes changes suggested by Duy Nguyen:

A. Path normalization (partial).
B. Rearrangement of common_list struct to make formatting prettier.

It also includes a test style fix suggested by Eric Sunshine and
others: a bogus test_must_fail on a non-git command has been replaced
by a two-step check.

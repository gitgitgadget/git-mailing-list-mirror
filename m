From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/3] git-p4: support python3 in the tests
Date: Tue, 26 Apr 2016 08:50:58 +0100
Message-ID: <1461657061-7984-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Sam Hocevar <sam@hocevar.net>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 09:48:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auxjU-0006Lm-CM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 09:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbcDZHsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 03:48:21 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38118 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcDZHsU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 03:48:20 -0400
Received: by mail-wm0-f51.google.com with SMTP id u206so20728008wme.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 00:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Sx9acD/tbyaC6bjMf5vqOWzb2bYrUaqeDWR3vDXHUNI=;
        b=XnhjQkxX5A8v4yT7yT+lZcnB8CtRKZ0ZuqtLTBNkAbEU2UTuyHtWQNTBySedIj8F0Z
         Dx4SfzGizgffgNxiJtuInc7bged42hqcWwmJpk9/qie9GxBOCQVjVOg9/JKp4GM3Z242
         bxbrnJfYEJcA/rOOQt7WhXPv5OthC7y0flA5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sx9acD/tbyaC6bjMf5vqOWzb2bYrUaqeDWR3vDXHUNI=;
        b=Sv2qfJf0V5TsoG85kwr7kStngJUfNOfzociY7NxfI7f6Ou4Bovn//EsuvEDV4MN3rX
         Lw7LCKRNT3t0gOW+cP6XEh5ZnA8VL2llVytpYut/MZ28wIviPX/LhdoSNYZrJNcDSoxl
         k+NgWo99R5yVbEvQgeZCCQeWQVOmdFm/E8Lxa9QLJyoE1lc8xlf5wFuq9rIJ7+FStKU7
         xYdBgK0mJ8XTKKp8Z54DB7bsbdfBNBy3NL9duWGPlIj6oS0vtQ5kA3dSzopFLyjnZUne
         /RnPozo8pM88wkZSrxzG9VkuCZq9OOFS6Yj1sTvE/tCB2YTigFySjJW/ZeYM79JpBI5U
         PVZw==
X-Gm-Message-State: AOPr4FVgtXXq3ljdBiW5dGubtTBOxAy6WSVjo6edc8RpyE4nO2dJuLtRUFO+dqBHG9fm1g==
X-Received: by 10.194.38.67 with SMTP id e3mr1335427wjk.127.1461656899023;
        Tue, 26 Apr 2016 00:48:19 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id h8sm1734520wmd.2.2016.04.26.00.48.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 00:48:18 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.218.gd2cea43.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292591>

Updates to my patches to allow the git-p4 tests to work with python3.

Incorporates suggestions from Junio to just switch to "/" and to
use $PYTHON_PATH.

Luke Diamand (3):
  git-p4 tests: cd to / before running python
  git-p4 tests: work with python3 as well as python2
  git-p4 tests: time_in_seconds should use $PYTHON_PATH

 t/lib-git-p4.sh            | 7 ++++---
 t/t9802-git-p4-filetype.sh | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.8.1.218.gd2cea43.dirty

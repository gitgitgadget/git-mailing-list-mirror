From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 0/3] Improvements to githooks.txt documentation
Date: Mon, 25 Apr 2016 14:14:22 +0000
Message-ID: <1461593665-31395-1-git-send-email-avarab@gmail.com>
References: <CAPig+cRYBChNVT2cixdzMCvO36Np-RdvTuccFshRoUDWnJv1Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 16:14:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auhHm-000804-8h
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 16:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbcDYOOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 10:14:46 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38731 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbcDYOOp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 10:14:45 -0400
Received: by mail-wm0-f50.google.com with SMTP id u206so129742391wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/u/ZxnszZGqYVi1PLfWrz/Ym+oem1AC9ljbZbc9skI4=;
        b=uKyXMBVE09X8vEy2QyWKoE8cOwaY1ttxcgJado1a2ZeyXvjjh15sT40kqI+D8D7Hzj
         Ph6G2ie6E+rs1Mz9QrY+8qpCu2G16HsAOMj4tfOnm0KFdO446RkdzOgz/7wUHFua9+ct
         PK6OXIaaJfekDzuX+Zeio3wus9Z3eMKX7kvLLjzJbCOB0cW+gKUQJ90H0B077PlfVh2e
         KEfl4nqA9zEk9BGE8F60d6fu3O3p5qIVEgunFyxG9JHdefiKbwYsH/biPvZKGBClPpgR
         l2NJbCd4W1LS3ObabqW3ZuJ0brrrXeM6evvZVWkCcsdDRFz1ssUZB7BXsTLjfqiY+S2U
         DxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/u/ZxnszZGqYVi1PLfWrz/Ym+oem1AC9ljbZbc9skI4=;
        b=mBmt0D5L8UADmydaWx/JrAs3ioU6rm1DQbn0v1Pc4QnEp3ncD2wG/zNYg9PWk6SCJH
         B5gZbkopzUlp7Y7RUHBfke0Z1hhEEzGFVc6OBkZ6zA+5f+0nqS1/iZqzq2ezNH8lTBHf
         VXRgbRchiwJrKYkiKsAHWClV99jUa0hkXk/0ykc37IBAP/wydAUEHHfwHW7kKOL871Py
         5eEMk3MTw+x5BjYuobGcdW9hCL4eoxKfUsgwZ6H/e51NOCZ5eM9j1KBkuRz/mHJrB3k7
         8Me0P6WF05iA6QcFf3jDN6roQv13pxHq1F9ZXVYlDzBz2h9L4R/Pt3slgfZ9zABGD9Aq
         xYAQ==
X-Gm-Message-State: AOPr4FUbFAj7Go0MAnCV4O1EcXcxCjD1c6BIWayxVa1whfuU0zf2+tqE9pFzb5sCVrXT7w==
X-Received: by 10.28.102.6 with SMTP id a6mr13115396wmc.75.1461593683471;
        Mon, 25 Apr 2016 07:14:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d1sm23768565wjb.47.2016.04.25.07.14.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2016 07:14:42 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <CAPig+cRYBChNVT2cixdzMCvO36Np-RdvTuccFshRoUDWnJv1Rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292481>

This includes minor grammar edits pointed out by Eric Sunshine + the
one v2 patch I sent out in response to comments by Jacob Keller.

I thought it was less confusing to just send out a whole v3 series
than ask Junio to piece together v1..v3 of various patches.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  githooks.txt: Improve the intro section
  githooks.txt: Amend dangerous advice about 'update' hook ACL
  githooks.txt: Minor improvements to the grammar & phrasing

 Documentation/git-init.txt |  6 +++-
 Documentation/githooks.txt | 72 +++++++++++++++++++++++++++-----------=
--------
 2 files changed, 47 insertions(+), 31 deletions(-)

--=20
2.1.3

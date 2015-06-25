From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 00/11] add options to for-each-ref
Date: Thu, 25 Jun 2015 14:16:59 +0530
Message-ID: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 10:47:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z82ov-0000aK-2Y
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 10:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbbFYIrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 04:47:36 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:32889 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbbFYIr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 04:47:29 -0400
Received: by oiyy130 with SMTP id y130so47684603oiy.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=vzdWECPP9mCEMXFbxlJMEN/Dp8MAcLZzW+CoCLyxraA=;
        b=NBfvGrvWS9CCoWZwsy+we2bCtAlZFr3xEL133NmiX7Jg7N0Ri0URtbnMI3EoCWspgo
         6IOlr/8yQLxxdXVPlNo0N9obC1EfjQ5iFH4nC0nqY/8pxzOJDJXuXqUF0d/C04+1Ds1M
         We5nYlVorD5vdOMlgmsZA2KnClKx4QeJHC8bLyKu2sfjjyagPoUbRRgGjBs3jIoNUOED
         I+L6XsOMITxqDkwDTmHnT4U49ZXszOpON9cFhIxnQWfXigMM7mmJZkRC/Knh1rA+0UdO
         aqPPfeMlLx5OU8fJHC28Mc3seGyoSFT4r3/SinKnZw1eN8+i9Y5wUbpa79/MGZjTfdvg
         1I/Q==
X-Received: by 10.202.200.11 with SMTP id y11mr1665430oif.111.1435222048588;
 Thu, 25 Jun 2015 01:47:28 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Thu, 25 Jun 2015 01:46:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272641>

v5 of this patch series can be found here :
http://article.gmane.org/gmane.comp.version-control.git/272590

This is a continuation of my GSoC project to unify git tag -l, git
branch -l and for-each-ref. Continued from this patch series :
http://thread.gmane.org/gmane.comp.version-control.git/271563

Changes in v5:
03/11: grammatical changes.
04/11: grammatical changes.
05/11: remove unnecessary if statement and remove caps used in commit message.
06/11: use xcalloc instead of using a commit_list as we know the size
of the array.
07/11: s/<object>/[<object>]/ as the object is optional.
08/11: rename parse_opt_commit_object_name() to parse_opt_commits().
09/11: make branch.c also to use the macros.
11/11: s/<object>/[<object>]/ as the object is optional.

Changes in v6:
Renamed the test file from t6301 to t6302 to avoid conflicts.

Thanks to Matthieu, Christian, Junio and Eric for the input on the
last iteration.

--
Regards,
Karthik Nayak

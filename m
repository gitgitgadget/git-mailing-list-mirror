From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] cherry-pick: a fix and a new option
Date: Mon, 27 May 2013 11:52:17 -0500
Message-ID: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 27 18:54:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh0gU-0005T6-4g
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 18:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab3E0QyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 12:54:04 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:38080 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab3E0QyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 12:54:03 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so737317obq.35
        for <git@vger.kernel.org>; Mon, 27 May 2013 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=v7rGYFiZmv768a5bQ8ZoCP0eZaWN0LMAgylnnPs+dpY=;
        b=i2vZuIayyTWkeUs+f1pOBhKYqCNfb7ETqOecXlL9hzqXN4kZ8K+jVr+uzKVLelR8xR
         a8bgQrQ0yiXVipt6Wn/aV7Fn9X/UyHtA5CajE0ETTiAwaB77BWwLm7U+lhSmWdQQM12l
         pQO2UWIZxLLWnRMXklaRWYBmKr2V9T9XRkPXZDUaHMMOkcWQIUQyFCIAIeGEP5BTGD+4
         E86n1efKPfTXX0SlIlX9SnelW5AsqemDIy1tIvS4E7ApfLviXAHOt+gTCeDgoqEhPW1d
         ebYrxpjgp7q7jqwLp5MY2fJbE8pKF7YHQRRwGSe4H2vs7Jz7Xp2LxpwfZj5xEuGhG6Z9
         kQCQ==
X-Received: by 10.182.105.6 with SMTP id gi6mr18498107obb.18.1369673642232;
        Mon, 27 May 2013 09:54:02 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt1sm31540789oeb.5.2013.05.27.09.53.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 May 2013 09:54:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225609>

Hi,

It doesn't make sense for the user to be interrupted constantly.

Felipe Contreras (2):
  sequencer: trivial fix
  cherry-pick: add --skip-commits option

 Documentation/git-cherry-pick.txt   |  3 +++
 builtin/revert.c                    |  2 ++
 sequencer.c                         | 12 +++++++++---
 sequencer.h                         |  1 +
 t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
 5 files changed, 28 insertions(+), 3 deletions(-)

-- 
1.8.3.rc3.312.g47657de

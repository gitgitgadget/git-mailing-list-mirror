From: larsxschneider@gmail.com
Subject: [PATCH v2 0/2] git-p4: fix AsciiDoc formatting
Date: Sun, 20 Mar 2016 19:39:19 +0100
Message-ID: <1458499161-61642-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 19:39:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahiGA-0005gP-JI
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 19:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbcCTSjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 14:39:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34062 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbcCTSjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 14:39:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id p65so17726716wmp.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9sT3zdL+8QUn1oL82f9bUT7Q94OAoAd6soc8FF1Ru+g=;
        b=Z0hrqE15a2HwjUkikotGZct9TsoyQ0cJeK9FceEUbNWJ9mZLpZtM0HBFJ6D01p+7hk
         RfGWEMEXB+HnF5Aw7Uf97/QXZMg00b0IEeNnuPLldAYBl/k+TJ96irIpa7Z4obOnTjrE
         z33s7HdQxyYDnXSOeSaAyQYfr3y5moEnH6SWbbwMT7YiIsWqIinDLeAj/EmJcCNCDUkO
         nIj8ZbIGj0V3KSO/h8hWqQmH+MK5WM5DBbqe8DamVSxLAxJhSCZczZxN0wketoLz9qmL
         vTjhPQ2AdXJjOGCn8Q3UEy2peDh49+us4Xb8M0jLwD8zoBq80QyStY9tK9bmqq4t+6jb
         vEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9sT3zdL+8QUn1oL82f9bUT7Q94OAoAd6soc8FF1Ru+g=;
        b=I6fw3mLl419Lcy0sKhBjdKnASWClhh0W2XH1puwLSfwCpWA9png6eA6LT2ztQyFDeA
         5iC2AQKNMmzpDknRwZcSaNh8xkM0xyCB73VZj/OT0cwMQFlwj8RBM9oaccJWBrMFAHPS
         TL37oAnRycKaQwl6qBm9/Q5NXNCo7EgyiMMnbjSUWoRxJeFip8VgjPd0fhkdN5nuQYy2
         r+Q1sXCqqXYyilwmMC3N1ZlqRrWsXYnCAD87a46ZrJ4qx+wonP32y/UTJIwwgUV+Ti0c
         2cczXHcr7qa2udpey15wfpindQOYoefotaVzd5Azn9cSmWBfqNj7fpI6r2HFRDHpD0Mk
         mBFQ==
X-Gm-Message-State: AD7BkJLDwSmcS3mdhxKkKH8oR4jlHmgA/P+hnb3p+3trHDhgOlIIY19kBva4GPKvtzha/w==
X-Received: by 10.28.101.5 with SMTP id z5mr9173993wmb.59.1458499163131;
        Sun, 20 Mar 2016 11:39:23 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB416B.dip0.t-ipconnect.de. [93.219.65.107])
        by smtp.gmail.com with ESMTPSA id et11sm21829064wjc.30.2016.03.20.11.39.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 20 Mar 2016 11:39:22 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289374>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v1:
* reference external pages similar to git-bisect-lk2009 (thanks Luke)
* fix quotation marks (you can see the error here:
  https://git-scm.com/docs/git-p4/2.7.4 ... search for cp1252 )

Thanks,
Lars


Lars Schneider (2):
  Documentation: fix git-p4 AsciiDoc formatting
  Documentation: use ASCII quotation marks in git-p4

 Documentation/git-p4.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--
2.5.1

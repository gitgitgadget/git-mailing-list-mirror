From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] .mailmap: Map email addresses to names
Date: Fri, 12 Jul 2013 21:21:20 +0200
Message-ID: <1373656881-5187-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 12 21:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxiuJ-0000BZ-1a
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 21:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757370Ab3GLTV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 15:21:27 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:58329 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757318Ab3GLTV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 15:21:26 -0400
Received: by mail-we0-f177.google.com with SMTP id m19so8370874wev.36
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fUaC10zc11oBHBS8KzImUByX8HjPBfgTUbBc3B1BH3k=;
        b=uff0LPEFOF+j6fRNnNWhB+YCNL9TjGaClbV1hwAUwzxlo9HdpF6yPke39FWZPBzUnR
         JFaSORZbQ/x3I3DM9GlSotTUto+sqf2sVq6IvyW0a4+aUGWu7IKbF88PkcDWmZI+3ia0
         9Q61nYHKSaQB03snvY6tNcfHdsQIducu0OPq7h37gHd2lFxtlLjJNR9M0nIISiti+3pN
         ER4jHFqBQQzDMAdhybG18hkQfX7wONl0LGX0arGlaYoNQEUsILXs/XHnxUDg3zEIltO8
         HoWa8kFfxZy33lBbGfk8SWZqTfyOeknHv903WYR/qcpHpqRhYyU0mi8ak9427IuLwKdx
         0GDQ==
X-Received: by 10.194.238.199 with SMTP id vm7mr24359056wjc.37.1373656882494;
        Fri, 12 Jul 2013 12:21:22 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a6sm5106375wib.10.2013.07.12.12.21.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 12:21:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.790.g9192b0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230242>

Ok I am sending all confirmed changes now again
in one big patch, as the sorting was wrong.

Stefan Beller (1):
  .mailmap: Map email addresses to names

 .mailmap | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 110 insertions(+), 25 deletions(-)

-- 
1.8.3.2.790.g9192b0b

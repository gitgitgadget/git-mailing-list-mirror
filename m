From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 0/3] Fix MSVC compile errors and cleanup stat definitions
Date: Wed, 11 Sep 2013 01:20:57 +0200
Message-ID: <522FA959.80108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 01:21:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJXF1-0006h3-Mc
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 01:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab3IJXU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 19:20:59 -0400
Received: from mail-ea0-f179.google.com ([209.85.215.179]:63582 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab3IJXU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 19:20:58 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so4197462eae.38
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 16:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=MQfWLdSrOSJkAHNP2NQd+KbDmQRCm7hJnEJzpLP7Vv8=;
        b=Rf4UQ4UTUvhlam+S+9SaiiljebHus3s3igdcGZRtkgEctMc95d+1Ho09bXVrKk4apQ
         VZJM/0o8Twy3bUZYSY3qm0wVy717kJ2Aa6G3pgj0DvMuk2UiK3xviiHF3aJSZeaEO6z4
         Z9QKwmgCoh8SgS04bfI9a95mfutOJq/eQ3sOZO9Wl/VUYHpafvqzeMwBOUHVD3g2kgWS
         igf9Drh7fc6WJNjEqaaLDhH+2A8OTZpADvCHZY+le9AWyHHP3yBU+xoDw1y3FaY1eUeU
         uhUGWJPi4ZJQ7B7I2p9ngWH7r38wt2yjzsNWPTdL9taJmy9T6lT590PXaKg6UMiyxw/s
         34UQ==
X-Received: by 10.14.108.9 with SMTP id p9mr42632148eeg.8.1378855257429;
        Tue, 10 Sep 2013 16:20:57 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id j7sm35405946eeo.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 16:20:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234504>

A few minor fixes for the MSVC build.

Also here: https://github.com/kblees/git/tree/kb/fix-msvc-stat-definitions

Karsten Blees (3):
  MSVC: fix compile errors due to missing libintl.h
  MSVC: fix compile errors due to macro redefinitions
  MSVC: fix stat definition hell

 compat/mingw.h   | 21 +++++++++++++++++----
 compat/msvc.h    | 15 ---------------
 config.mak.uname |  1 +
 3 files changed, 18 insertions(+), 19 deletions(-)

-- 
1.8.4.8243.gbcbdefd

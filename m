From: Jonh Wendell <jonh.wendell@gmail.com>
Subject: [PATCH 0/2] describe: support the syntax "--abbrev=+"
Date: Sat, 23 Aug 2014 14:13:20 -0300
Message-ID: <1408814002-6553-1-git-send-email-jonh.wendell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 19:13:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLEse-0006IJ-6B
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 19:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbaHWRN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 13:13:28 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:48679 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbaHWRN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 13:13:27 -0400
Received: by mail-yk0-f173.google.com with SMTP id 131so9446896ykp.32
        for <git@vger.kernel.org>; Sat, 23 Aug 2014 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=9uUA+sau1ttiYzZINZ+TqK/ikXxTAG1tyXzs8BanE54=;
        b=esOj5poC4+C9SU4PESrk+CzD7xtFlFbMmLpe0xG8R7q+2/AhnzPYV9m9NFa/KLFEWm
         vBvo2Qqix2ikUmNFwLYoJkzK7Y5vtB1hCH2bFWGQ52YlbohWwhofU0mYZMFv7RWJQDxh
         0/SyEuQrvfQJm137hvnXCEXSFxtjn9OpWx1KRaWCDIZaptKvZsYTYkHXAP04cHb/Hi1s
         oSIigOqx1Y1avvK304st2egzwwejJZix4q+xBQUjO8hstUA6F8SRqIV56Y3xMYXSyW3M
         nfl11rcaf1UVCqk4F/Z/tfLsnA5fptU8yliGhd/qgq291P3j+jdqO2jEM2o2QCdo+kzf
         WZNg==
X-Received: by 10.236.14.230 with SMTP id d66mr73939yhd.175.1408814006861;
        Sat, 23 Aug 2014 10:13:26 -0700 (PDT)
Received: from jwendell-mobl1.amr.corp.intel.com ([187.37.207.144])
        by mx.google.com with ESMTPSA id s9sm1485471yhp.39.2014.08.23.10.13.25
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Aug 2014 10:13:26 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255757>

Sometimes it's interesting to have a simple output that answers the question:
Are there commits after the latest tag?

One possible solution is to just print a "+" (plus) signal after the tag. Example:

> git describe --abbrev=1 5261ec5d5
v2.1.0-rc1-2-g5261ec

> git describe --abbrev=+ 5261ec5d5
v2.1.0-rc1+


Jonh Wendell (2):
  describe: support the syntax "--abbrev=+"
  describe: Add documentation for "--abbrev=+"

 Documentation/git-describe.txt |  6 ++++++
 builtin/describe.c             | 26 +++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

-- 
1.9.3

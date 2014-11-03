From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 0/2] add some new autoconf macros for searching the possible warning flags allowed by the current version of the gcc compiler
Date: Mon,  3 Nov 2014 06:57:19 -0800
Message-ID: <1415026641-24767-1-git-send-email-gitter.spiros@gmail.com>
Cc: jnareb@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 15:57:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlJ4i-00049Z-BO
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 15:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbaKCO5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 09:57:39 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46300 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbaKCO5g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 09:57:36 -0500
Received: by mail-pa0-f42.google.com with SMTP id bj1so12357717pad.29
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 06:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2SQ1hV3iVN7gZi+qkOCdZ52WjgDNrfBBD+yBHqlw+2Y=;
        b=hj/mZAzSvl7MljsJQbtilD7x93TI1TZm0tjiyN0I9Wks9MPRR3nAZCZf36x/8xwkf3
         ATWCOOoJutg8ImfkcLK0Z7qV2PqJki1O6nv/tSph4sZhpUYvkepsamyCKwEl1ZOYJkm4
         mvcTDW94rEGO92LjJ1FoGYMMilf/5Tq75d70aDjS2XQUcv6eFeiI2IVEJmDmg2NmqFHO
         IlJORZRumevRYfIb/ba2NJ8dfqWg6fA37iFJnAdNlAcfYnhPZft1m5VvfFR2v1wRthCv
         cgADrScd61jxOUzemkkZTQvdd/hSGDaJ/Q2GdPloWOW3ZLyecm6VTvM1KNJUqFrFortW
         LotA==
X-Received: by 10.66.124.130 with SMTP id mi2mr4388829pab.104.1415026655671;
        Mon, 03 Nov 2014 06:57:35 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id ri9sm17409373pbc.5.2014.11.03.06.57.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 06:57:34 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces some new autoconf macros for searching the possible warning flags allowed by the current version of the gcc compiler. 
Using these macros it adds a new option --enable-gcc-warnings (default off). There are several possible gcc warnings flags, 
i have included some of the most useful in my opinion but certainly there are several other perhaps more useful for git, so comments are welcome. 
Naturally the new macro are not limited only to the portable search of the gcc warning flags or to gcc in first place in any way

Elia Pinto (2):
  configure.ac: add new autoconf macro for checking valid compiler
    flags
  configure.ac: use GIT_CC_CHECK_FLAG_APPEND for adding
    --with-gcc-warnings configure option

 Makefile     |   12 ++++-
 configure.ac |  141 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 149 insertions(+), 4 deletions(-)

-- 
1.7.10.4

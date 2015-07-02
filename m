From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 00/11] add options to for-each-ref
Date: Thu, 2 Jul 2015 20:50:44 +0530
Message-ID: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 02 17:21:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAgIh-0008J4-QX
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 17:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbbGBPVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 11:21:16 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36809 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbbGBPVO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 11:21:14 -0400
Received: by obdbs4 with SMTP id bs4so51821529obd.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=oVzkmkYygzPgsW5JZXRR4jOCR0bwjdj1jEtYm5fO1OE=;
        b=DMaal1xRjXO2wjSxyQLF5SgD8Vznhl8zjwb/TOKBgMoDg0KDSJcNToncw49RoVAitP
         osNtOmRZGIEMS+FA78ac7Vh1qbaTG/DRLy0xTqY69T59Y8YMIxEAPhOYsTPNgvfnjNZQ
         3H+z+Vin/brGjt+40McO7QKP+nrLxu+wyDSQozoN4L22IaUXj+h6/QM/OdCkFYVoxq8w
         Lv2k4niRt6wPnPLn8aE8eq2gDZqsvLQtekYlsAkt9V/zX9QFbYZQIkChpo5KDMDcL4Z3
         puVLUE0g13g7C2c4XH3s2K6uni0ep4norcGtsAV/4RvtapHw3mZGbimc3ZEueVjl2ZFy
         3JBg==
X-Received: by 10.202.92.68 with SMTP id q65mr2572483oib.11.1435850473646;
 Thu, 02 Jul 2015 08:21:13 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Thu, 2 Jul 2015 08:20:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273233>

v6 of this patch series can be found here :
http://article.gmane.org/gmane.comp.version-control.git/272641

This is a continuation of my GSoC project to unify git tag -l, git
branch -l and for-each-ref. Continued from this patch series :
http://thread.gmane.org/gmane.comp.version-control.git/271563

Changes since v6:
01/11: changed the file to be executable and include a double
annotated tag in the tests.
03/11: removed changed made while copying code.
04/11: made the tests clearer to read and also changed the explanation
of for "--points-at" option.
06/11: added a comment in builtin/branch.c about the code being copied
over to ref-filter.
* Also removed included spaces before and after a colon, wherever necessary.

-- 
Regards,
Karthik Nayak

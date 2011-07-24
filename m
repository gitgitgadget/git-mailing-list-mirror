From: Mathew Benson <mathew.benson@gmail.com>
Subject: Help using git I'm review process
Date: Sun, 24 Jul 2011 07:12:38 -0500
Message-ID: <245B4B40-CA0A-43F6-A3F0-85E50D75CB93@gmail.com>
Mime-Version: 1.0 (iPad Mail 8J2)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 24 14:12:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkxY6-0004cL-Uv
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 14:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab1GXMMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 08:12:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38072 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab1GXMMk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jul 2011 08:12:40 -0400
Received: by vws1 with SMTP id 1so2470059vws.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:content-type:x-mailer:message-id:date:to
         :content-transfer-encoding:mime-version;
        bh=dYUAZ7CVVKiGZayDurpstzYoAhyddLSLna+5eHS2iWU=;
        b=tJwtdH2/dYCyigbi3onpwy+Udy9ohZoymL68IsFiUc+ldvKyKFxZz3CuQ+nAYeuGIa
         7FYNT5KYzCOai3xJD2zadtRydzjWaXiSE6ATv9FjnoNU5hmqBrczZmenwKsHokapBQDb
         ufCAf7+8HLaSX37Bp+N+Y73yfYyXtQHWk9qjg=
Received: by 10.52.23.225 with SMTP id p1mr3585588vdf.134.1311509560028;
        Sun, 24 Jul 2011 05:12:40 -0700 (PDT)
Received: from [192.168.1.102] (user-0cdvj2d.cable.mindspring.com [24.223.204.77])
        by mx.google.com with ESMTPS id o3sm1515484vca.2.2011.07.24.05.12.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 05:12:39 -0700 (PDT)
X-Mailer: iPad Mail (8J2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177739>

I'm planning to use git for a work project, which requires tight control of the peer review process.  In previous jobs, the peer review was a tedious manual process of creating PDF files, writing comments in spreadsheets, and copying comments to the CM system.  I want to use technology to my best advantage.

Once a developer has completed all his changes in his development branch, what's the best way to get those files to the reviewers, without requiring the author to stop work?  First, I think I should create a tag in the developer branch.  Each developer has a local repository, and my review tool writes files directly in the work area.  Can they just fetch, checkout a tag (don't know how to do that), commit changes, and push it back to the central repository?  Is there a better workflow?
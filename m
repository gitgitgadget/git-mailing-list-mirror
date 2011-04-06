From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v5 0/4] Document diff and filter drivers in config
Date: Thu,  7 Apr 2011 00:16:47 +0530
Message-ID: <1302115611-1950-1-git-send-email-artagnon@gmail.com>
References: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 20:48:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Xm3-0006xn-GC
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 20:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756470Ab1DFSsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 14:48:01 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63758 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538Ab1DFSr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 14:47:59 -0400
Received: by iyb14 with SMTP id 14so1697854iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=TdONqbClddi3WFYxEwCokiWP2njoiO6xtAhXhMWzgaU=;
        b=SuGnYdJRLlhHucwdDxt8VpdWoxToHGhchVESSOPNIsw4OptENwCtjD2to5HduK31My
         YTe5VeycXcnI49dLDS1miYVgNho8YDbzsujr/70p5itZtWr/K42zRGqoGqObhfr7dHtq
         hV9H2njmAjntX4s7LvKoYHGOw+jKI4gb6YRAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CA5qJg7Tm8aolvMpJ/EwJM/y2tHPHk3bixaukaEjk4R6jBfuaPg8xcP8Apm22d/0GB
         NB9X+LFXZEf9Bg5aj/ID67VjJKsXIQfP/ADmdvWBi60atG/brldMPTao/XSdD63BDWKl
         li1T0lWg5GYck7iKwgJ7MXaS907z9mrYRJrRA=
Received: by 10.42.145.71 with SMTP id e7mr2280162icv.314.1302115678770;
        Wed, 06 Apr 2011 11:47:58 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id vr5sm495851icb.0.2011.04.06.11.47.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 11:47:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171002>

What changed since v4:
- I included the wrong commit in 1/4 last time.
- More nits and proof-reading.

-- Ram

Ramkumar Ramachandra (4):
  Documentation: Add filter.<driver>.* to config
  Documentation: Add diff.<driver>.* to config
  Documentation: Allow custom diff tools to be specified in 'diff.tool'
  Documentation: Minor language improvements to merge-config

 Documentation/config.txt       |   73 +++++---------------------------
 Documentation/diff-config.txt  |   92 ++++++++++++++++++++++++++++++++++++++++
 Documentation/merge-config.txt |   39 +++++++++--------
 3 files changed, 123 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/diff-config.txt

-- 
1.7.4.rc1.7.g2cf08.dirty

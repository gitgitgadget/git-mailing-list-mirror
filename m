From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH 0/2] SubmittingPatches: What to base work on
Date: Mon, 19 Apr 2010 01:23:11 +0530
Message-ID: <1271620352-sup-4304@kytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 21:55:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3aac-0007hv-HE
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 21:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab0DRTzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 15:55:17 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:50042 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab0DRTzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 15:55:16 -0400
Received: by yxe29 with SMTP id 29so2129738yxe.4
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:date:message-id:user-agent:content-transfer-encoding;
        bh=KbCQOGywdBhrsHi3LrS+fJpRnuC+JuJVl6O7MCCsRNI=;
        b=tZnoKaxIcEKi/VX3Vtm/LbO7cZdl7al9fi5Ng7InU09YE0x0ne2VFo6Hhvi/L6Vfr6
         rqcfF0YeEkV8eElmut0DEBJTyv7JgHur1fjzZ3rk5VsucdILGJavhI6yubd745crcABJ
         6d2+wCFp3qBpFSWWaZmCPTVKF2LY0dPSroryc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:date:message-id:user-agent
         :content-transfer-encoding;
        b=CQg45IOFL5vVkkB8DC1J7OfoOKN93fy4mRI/hZCP6J1pT3Nmyvq5DzlUYyt/3NQsap
         kZXx0uazShfzMkCpv8EKK9KU7amAEc866tm6Ek+U2xeoIocCEfmwWech4g7FWcAFICgC
         eZtSOO6/RXeLeaAxBYa/nibXki2M/iceCjGW0=
Received: by 10.151.61.20 with SMTP id o20mr4566785ybk.318.1271620515391;
        Sun, 18 Apr 2010 12:55:15 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 22sm4229823iwn.4.2010.04.18.12.55.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Apr 2010 12:55:14 -0700 (PDT)
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145239>

This is a two-part series. The first patch is a verbatim copy of
Junio's rough draft [1]. The second patch is my rewrite, which I
intend to squash into the first.

[1] http://article.gmane.org/gmane.comp.version-control.git/144378/

Ramkumar Ramachandra (2):
  SubmittingPatches: Add new section about what to base work on
  SubmittingPatches: Complete rewrite of section 0

 Documentation/SubmittingPatches |   49 ++++++++++++++++++++++++++++++--------
 1 files changed, 38 insertions(+), 11 deletions(-)

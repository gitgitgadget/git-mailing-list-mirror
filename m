From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/4] gitweb: Some code cleanups, part 2 (low hanging fruit)
Date: Mon, 11 May 2009 19:36:26 +0200
Message-ID: <20090511173025.15152.94215.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 19:36:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ZQf-0004Va-71
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 19:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbZEKRga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 13:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbZEKRga
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 13:36:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:7516 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbZEKRg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 13:36:29 -0400
Received: by fg-out-1718.google.com with SMTP id d23so617986fga.17
        for <git@vger.kernel.org>; Mon, 11 May 2009 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=RkqUMlnuTo2AcH6svvonlrdBjLrTDmTy2RHdgtdSt8s=;
        b=iuiz8D33S7lctQMI+DsomMMOcn2nbx3U4XlgUeQjhHqTIesmnA0JBkct1GRgJMKj2u
         ISVt0z540jVTXPMxWfJ4lvpKJoUliJyXFSeDAsOmaHBnRSpx/UcwHIeea7k2RdDUxGrG
         lUhAwGz5HWdlRo2clQunZ0SCu7mCyq9NBXwls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=gjtjj8QBLOeYvmdsQM1UPGYt1Ns5muJCDqmNwc0litJNDze17pfQ/PosjkvTMAdd7/
         F0uEhIMWtTu0sA+syNS+gR3MEhry8zr27NptT3TIQkF3okzSs+ravH/dZgc0NG96zApc
         o2qGCVOQ6ATMLAy/WhGeyNkt/jarHzrl048x4=
Received: by 10.86.36.4 with SMTP id j4mr2745108fgj.63.1242063388105;
        Mon, 11 May 2009 10:36:28 -0700 (PDT)
Received: from localhost.localdomain (absh130.neoplus.adsl.tpnet.pl [83.8.127.130])
        by mx.google.com with ESMTPS id 4sm4883075fge.8.2009.05.11.10.36.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 10:36:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4BHaQWR016650
	for <git@vger.kernel.org>; Mon, 11 May 2009 19:36:27 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118812>

The following series was inspired by severity: 3 Perl::Critic
(http://perlcritic.com) suggestions for gitweb; the patches listed
below are simple and obvious fixes.  That is why there is no detailed
explanation of perlcritic policy for each patch.

This time I have checked that t9500 passes...
---
Jakub Narebski (4):
  gitweb: Remove unused $hash_base parameter from normalize_link_target
  gitweb: Simplify snapshot format detection logic in evaluate_path_info
  gitweb: Use capturing parentheses only when you intend to capture
  gitweb: Replace wrongly added tabs with spaces

 gitweb/gitweb.perl |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
Poland

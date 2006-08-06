From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/6] gitweb: Further refactoring
Date: Sun, 6 Aug 2006 02:06:48 +0200
Message-ID: <200608060206.49086.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 06 02:06:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9WA8-0002Dm-ED
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 02:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWHFAGR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 20:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWHFAGR
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 20:06:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:21004 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750907AbWHFAGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 20:06:16 -0400
Received: by nf-out-0910.google.com with SMTP id p46so38989nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 17:06:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aGepELjvjQG/1zlBcMQZtXTBP8MtpTNVYx7MSvFq4QThlAbWf2PpSpAXoSoSRGRuwatPKXDSoHw2s9QYMYGd34p7f0cjOBHg1rfmmpFt1NazUNi0cjUNny6jfCNrJ5/8jXFP4T9zHFhdZzkenxXmq/yYQxiFPsdjG+FgiCOjeeA=
Received: by 10.49.93.13 with SMTP id v13mr629617nfl;
        Sat, 05 Aug 2006 17:06:14 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id o53sm4194042nfa.2006.08.05.17.06.14;
        Sat, 05 Aug 2006 17:06:14 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24943>

This series of patches, on top of my merged series
'[PATCH 7/5] Merge changes in "split patch 1" series'
although probably would apply on top of 'next'.

 * [PATCH 1/5] gitweb: Refactor untabifying - converting tabs to spaces
 * [PATCH 2/6] gitweb: Simplify git_diff_print
 * [PATCH 3/6] gitweb: Remove unused parse_date invocation from
   git_shortlog_body
 * [PATCH 4/6] gitweb: Make blob diff -p1 like commit diff
 * [PATCH 5/6] gitweb: Refactor printing shortened title in
   git_shortlog_body and git_tags_body
 * [PATCH 6/6] gitweb: Refactor git_history_body

-- 
Jakub Narebski
Poland

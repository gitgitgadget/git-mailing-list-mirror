From: Marc Singer <elf@buici.com>
Subject: Why would merge fail on a one-line addition?
Date: Sat, 25 Mar 2006 14:26:01 -0800
Message-ID: <20060325222601.GA1500@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 25 23:26:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNHD5-0002bz-G7
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 23:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbWCYW0D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 17:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWCYW0D
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 17:26:03 -0500
Received: from 206-124-142-26.buici.com ([206.124.142.26]:4579 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S1751954AbWCYW0C
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 17:26:02 -0500
Received: (qmail 1567 invoked by uid 1000); 25 Mar 2006 22:26:01 -0000
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

One of the unmerged files leaves this trail.

  elf@florence ~...git/linux-2.6 > git-ls-files --unmerged
  100644 6262d449120cdcde5db1b079806dcc0d9b5e6b7c 1       arch/arm/mach-lh7a40x/irq-lpd7a40x.c
  100644 dcb4e17b941990eabe8992680c9aa9b67afb6fd4 3       arch/arm/mach-lh7a40x/irq-lpd7a40x.c

  elf@florence ~...git/linux-2.6 > git-cat-file blob 6262d449120cdcde5db1b079806dcc0d9b5e6b7c > a
  elf@florence ~...git/linux-2.6 > git-cat-file blob dcb4e17b941990eabe8992680c9aa9b67afb6fd4 > b
  elf@florence ~...git/linux-2.6 > diff a b                                       21a22
  > #include "common.h"

Why would git have a problem with this?

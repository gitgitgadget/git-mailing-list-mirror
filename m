From: Matt Kraai <kraai@ftbfs.org>
Subject: Extra checks for PERL_PATH and SHELL_PATH?
Date: Mon, 19 Oct 2009 20:50:51 -0700
Message-ID: <20091020035051.GA3237@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 05:53:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N05n0-00029G-7l
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 05:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbZJTDx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 23:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755414AbZJTDx1
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 23:53:27 -0400
Received: from zoom.lafn.org ([206.117.18.8]:42586 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbZJTDx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 23:53:27 -0400
Received: from macbookpro (pool-173-51-225-123.lsanca.fios.verizon.net [173.51.225.123])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id n9K3rUpW028875
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 19 Oct 2009 20:53:31 -0700 (PDT)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by macbookpro with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1N05kJ-0005ND-Qw
	for git@vger.kernel.org; Mon, 19 Oct 2009 20:50:51 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.1 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130757>

Hi,

The top-level Makefile currently contains

> ifndef SHELL_PATH
> 	SHELL_PATH = /bin/sh
> endif
> ifndef PERL_PATH
> 	PERL_PATH = /usr/bin/perl
> endif

The checks are only necessary if these variables need to be overridden
by environment variables, not just via the make command line.  Is this
the case?

-- 
Matt Kraai                                           http://ftbfs.org/

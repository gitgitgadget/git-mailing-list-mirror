From: Matthias Lederhofer <matled@gmx.net>
Subject: disable the compile-flags-changed check
Date: Fri, 14 Jul 2006 07:47:02 +0200
Message-ID: <E1G1GVy-00007o-PM@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 14 07:47:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1GWB-0008UJ-Ta
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 07:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWGNFrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 01:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWGNFrG
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 01:47:06 -0400
Received: from moooo.ath.cx ([85.116.203.178]:58264 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1161191AbWGNFrF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 01:47:05 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23875>

Is there any way to disable the "the compile flags have changed,
recompile everything" check?  I want to built with another prefix than
installing to create a tarball I copy to other machines.  Is there any
way to do this?  Otherwise: could we include something like this?

ifeq ($(IGNORE_CFLAG_CHANGES),)
# old GIT-CFLAGS rules
else
GIT-CFLAGS:
        touch "$@"
endif

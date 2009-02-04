From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] apply: fix access to an uninitialized mode variable,
	found by valgrind
Date: Wed, 4 Feb 2009 09:36:34 -0500
Message-ID: <20090204143634.GY3827@redhat.com>
References: <cover.1233712140u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902040249030.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 15:35:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUiqT-0002DG-HB
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 15:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZBDOdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 09:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbZBDOdv
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 09:33:51 -0500
Received: from mx2.redhat.com ([66.187.237.31]:44746 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbZBDOdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 09:33:50 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n14EXk4h020935;
	Wed, 4 Feb 2009 09:33:46 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n14EXiG2006811;
	Wed, 4 Feb 2009 09:33:46 -0500
Received: from redhat.com (dhcp-100-18-183.bos.redhat.com [10.16.18.183])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n14EXiNn004759;
	Wed, 4 Feb 2009 09:33:44 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902040249030.9822@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108366>

On Wed, Feb 04, 2009 at 02:50:15AM +0100, Johannes Schindelin wrote:
> When 'tpatch' was initialized successfully, st_mode was already taken
> from the previous diff.  We should not try to override it with data
> from an lstat() that was never called.

heh, oops.  thanks.

Acked-by:  Don Zickus <dzickus@redhat.com>

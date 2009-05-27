From: Joel Becker <Joel.Becker@oracle.com>
Subject: git-svn clone problem
Date: Wed, 27 May 2009 15:16:01 -0700
Message-ID: <20090527221601.GA12914@mail.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 28 00:16:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RQc-0008D4-CK
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762154AbZE0WQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 18:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbZE0WQF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:16:05 -0400
Received: from rcsinet12.oracle.com ([148.87.113.124]:63043 "EHLO
	rgminet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762270AbZE0WQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 18:16:03 -0400
Received: from rgminet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by rgminet12.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n4RMFsCW023871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 27 May 2009 22:15:55 GMT
Received: from acsmt356.oracle.com (acsmt356.oracle.com [141.146.40.156])
	by rgminet15.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n4RKrsYC008878
	for <git@vger.kernel.org>; Wed, 27 May 2009 22:16:00 GMT
Received: from ca-server1.us.oracle.com by acsmt357.oracle.com
	with ESMTP id 17348710171243462548; Wed, 27 May 2009 17:15:48 -0500
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.69)
	(envelope-from <joel.becker@oracle.com>)
	id 1M9RPX-0007S9-LW
	for git@vger.kernel.org; Wed, 27 May 2009 15:15:47 -0700
Content-Disposition: inline
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Source-IP: acsmt356.oracle.com [141.146.40.156]
X-Auth-Type: Internal IP
X-CT-RefId: str=0001.0A010205.4A1DBBA2.0126:SCFMA4539814,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120124>

Hello everyone,
	I've got a fun git-svn bug I can't seem to track down.  The
google is no help.  I'm just trying to clone a full repo.  I'm not
looking to push changes back, and I've done this before, yet now (1.6.3
and 1.6.3.1) it's not working.
	The clone command and error is:

$ git svn clone --stdlayout --no-metadata -Aauthors  http://oss.oracle.com/projects/oracleasm/src/ driver-git
Initialized empty Git repository in
/build/jlbec/oracleasm/driver-git/.git/
	A	kernel/osm.c
	A	Configure
	A	include/osmprivate.h
	A	include/arch-i386/osmstructures.h
	A	include/osmlib.h
	A	include/osmerror.h
	A	libosm/osmlib.c
	A	Makefile
r1 = d855bc271ef7dcf70a58ae35fde5dc49f28d3e8e (trunk)
missing UUID at the end of .git/svn/trunk/.rev_db.????????-????-????-????-???????????? at /usr/lib/git-core/git-svn line 4488

You can drop the --no-metadata if you like - it doesn't help.  Clearly
it's tripping on the first revision.  I'm not sure what UUID it's
looking for.  The manpage speaks of UUIDs in regards to svk/svnsync, and
I'm not using those.
	I suspect the last time I did this was in the 1.5 range (my
distribution has obviously moved on).  But I would think this was tested
:-)

Joel

-- 

"Behind every successful man there's a lot of unsuccessful years."
        - Bob Brown

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

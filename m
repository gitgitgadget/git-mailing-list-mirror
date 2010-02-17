From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [BUG] git-gui blame: "Show History Context" is broken
Date: Wed, 17 Feb 2010 15:13:04 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20100217121304.GA1623@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 17 13:30:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhj2p-0005kV-12
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 13:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757098Ab0BQM35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 07:29:57 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:45204 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929Ab0BQM34 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 07:29:56 -0500
X-Greylist: delayed 861 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Feb 2010 07:29:56 EST
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1NhioM-0000OV-CW; Wed, 17 Feb 2010 15:15:22 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1Nhim8-0000UW-Fr; Wed, 17 Feb 2010 15:13:04 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140233>

Git-gui as shipped with todays git.git master is a bit broken:

in git.git master (v1.7.0-29-g6d81630), try running:

    $ git gui blame xdiff-interface.h

Then select first line 'd9ea d9ea   1 #ifndef XDIFF_INTERFACE_H', right
click to popup context menu, select "Show History Context" -->

--> git gui errors with:

    "Error: couldn't change working directory to "": no ...


Thanks,
Kirill

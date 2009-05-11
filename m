From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: auto-merge after push?
Date: Mon, 11 May 2009 17:23:27 +0300
Message-ID: <20090511142326.GA18260@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 16:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3WQm-0003MR-Vq
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 16:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbZEKOY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 10:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbZEKOY1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 10:24:27 -0400
Received: from mx2.redhat.com ([66.187.237.31]:53057 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbZEKOY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 10:24:26 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4BEORfC018250
	for <git@vger.kernel.org>; Mon, 11 May 2009 10:24:27 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4BEOQOt021505
	for <git@vger.kernel.org>; Mon, 11 May 2009 10:24:27 -0400
Received: from redhat.com (vpn-10-226.str.redhat.com [10.32.10.226])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4BEOOBV015422
	for <git@vger.kernel.org>; Mon, 11 May 2009 10:24:25 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118801>

Hi!
I'm working on two machines, and git allows me to switch between them
and sync by means of git pull. When one machine is behind a firewall, I
can sometimes only do pushes, but then I have to rememeber to merge when
I log into remote machine.

Is there a way to trigger merge on remote after push somehow,
so that running on local machine:
>git push remote
would be equivalent to
>ssh remote git pull local

Thanks,
-- 
MST

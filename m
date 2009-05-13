From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: add comments to reflog?
Date: Wed, 13 May 2009 13:35:54 +0300
Message-ID: <20090513103554.GC31593@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 12:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Bpd-0005Vq-SQ
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 12:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757714AbZEMKgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 06:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755117AbZEMKgx
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 06:36:53 -0400
Received: from mx2.redhat.com ([66.187.237.31]:50866 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135AbZEMKgx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 06:36:53 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4DAarKR018083
	for <git@vger.kernel.org>; Wed, 13 May 2009 06:36:53 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4DAarQo028030
	for <git@vger.kernel.org>; Wed, 13 May 2009 06:36:53 -0400
Received: from redhat.com (vpn-10-148.str.redhat.com [10.32.10.148])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4DAapZE025339
	for <git@vger.kernel.org>; Wed, 13 May 2009 06:36:52 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119030>

I noticed that I am often doing this

hack commit hack commit  hack commit ...

git tag  -s works -m "works on xyz, must rewrite abc"
git reset --hard HEAD~1

hack ...

I only tag just in case I want to revisit the design.
However, after I reset, I often forget how did
I name the tag. It would be nice if reflog would
show tag descriptions, which it does not seem to.

Comments?


-- 
MST

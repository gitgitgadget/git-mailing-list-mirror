From: Phil Wiffen <phil.m.wiffen@outlook.com>
Subject: Re: trouble on windows network share
Date: Tue, 3 Dec 2013 16:48:10 +0000 (UTC)
Message-ID: <loom.20131203T174155-97@post.gmane.org>
References: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil> <1367529968647-7584800.post@n2.nabble.com> <87ppx8o1lj.fsf@linux-k42r.v.cablecom.net> <8B6563E531152E4190313499F193F94214A9C966@mbx500-u1-lo-3.exch500.msoutlookonline.net> <87ip2wla12.fsf@linux-k42r.v.cablecom.net> <871B6C10EBEFE342A772D1159D1320853F65E5B6@umechphj.easf.csd.disa.mil> <8B6563E531152E4190313499F193F94214AB8CED@mbx500-u1-lo-3.exch500.msoutlookonline.net> <871B6C10EBEFE342A772D1159D1320853F65F7E0@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 17:50:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VntAp-00032h-5Q
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 17:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab3LCQuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 11:50:06 -0500
Received: from plane.gmane.org ([80.91.229.3]:38851 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753905Ab3LCQuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 11:50:04 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VntAh-000300-So
	for git@vger.kernel.org; Tue, 03 Dec 2013 17:50:04 +0100
Received: from 212.44.20.129.ip.redstone-isp.net ([212.44.20.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 17:50:03 +0100
Received: from phil.m.wiffen by 212.44.20.129.ip.redstone-isp.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 17:50:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.44.20.129 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:25.0) Gecko/20100101 Firefox/25.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238700>

Did anyone ever get to the bottom of this? I'm seeing this exact issue on
both NetApp storage systems with SMB 2.x enabled and also on Windows 7 and
Server 2008 R2 shares (which also use SMB 2.x). If we use SMB 1.x (such as
XP), things work fine.

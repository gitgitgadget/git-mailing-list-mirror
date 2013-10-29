From: Jim Garrison <jim.garrison@nwea.org>
Subject: Documentation for fetch, url, branches, tags keywords in git
 config?
Date: Tue, 29 Oct 2013 19:23:20 +0000
Message-ID: <0C723FEB5B4E5642B25B451BA57E273041FD3F9C@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 29 20:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbF4u-0000kZ-EK
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 20:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab3J2Tfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 15:35:45 -0400
Received: from gwo3.mbox.net ([165.212.64.25]:56231 "EHLO gwo3.mbox.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380Ab3J2Tfo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Oct 2013 15:35:44 -0400
X-Greylist: delayed 736 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Oct 2013 15:35:44 EDT
Received: from gwo3.mbox.net (localhost [127.0.0.1])
	by gwo3.mbox.net (Postfix) with ESMTP id 3d8N4b0nTwzfjXVL
	for <git@vger.kernel.org>; Tue, 29 Oct 2013 19:23:27 +0000 (UTC)
X-USANET-Received: from gwo3.mbox.net [127.0.0.1] by gwo3.mbox.net via mtad (C8.MAIN.3.82G) 
	with ESMTP id 398RJCTXV7648Mo3; Tue, 29 Oct 2013 19:23:21 -0000
X-USANET-Routed: 5 gwsout-gwsd Q:gwsd
X-USANET-Routed: 3 gwsout-vs Q:bmvirus
X-USANET-GWS2-Tenant: nwea.org
X-USANET-GWS2-Tagid: NWEA
Received: from S1P5HUB2.EXCHPROD.USA.NET [165.212.120.254] by gwo3.mbox.net via smtad (C8.MAIN.3.93K) 
	with ESMTPS id XID575RJCTXV3836Xo3; Tue, 29 Oct 2013 19:23:21 -0000
X-USANET-Source: 165.212.120.254 OUT  jim.garrison@nwea.org S1P5HUB2.EXCHPROD.USA.NET
X-USANET-MsgId: XID575RJCTXV3836Xo3
Received: from S1P5DAG3C.EXCHPROD.USA.NET ([169.254.3.33]) by
 S1P5HUB2.EXCHPROD.USA.NET ([10.120.223.32]) with mapi id 14.03.0158.001; Tue,
 29 Oct 2013 19:23:21 +0000
Thread-Topic: Documentation for fetch, url, branches, tags keywords in git
 config? 
Thread-Index: Ac7U28uZYfSDpOqqRBu+GduxZjnzcQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.98.171.2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236942>

A typical config

[svn-remote "svn"]
        noMetadata = 1
        url = http://repository.url/svn
        fetch = trunk/etl_app:refs/remotes/etl_app/trunk
        branches = branches/etl_app/*:refs/remotes/branches/*
        tags = tags/etl_app/*:refs/remotes/tags/*


However, the manpage for git-config(1) does not include anything exlicit on "url", "fetch", "branches", 'tags", and the meaning of the syntax following the colon. 

Where can I find this info?

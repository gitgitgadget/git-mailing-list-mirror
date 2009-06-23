From: Emmanuel Puerto <emmanuel.puerto@maxim-ic.com>
Subject: RE: [BUG] malloc error when using large file.
Date: Tue, 23 Jun 2009 00:05:11 -0700
Message-ID: <B03A893ADFE80748942D13AFAF2845190C2D5D3BDC@ITSVLEX06.it.maxim-ic.internal>
References: <B03A893ADFE80748942D13AFAF2845190C2D5D388A@ITSVLEX06.it.maxim-ic.internal>
 <20090622211542.GA19364@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 23 09:06:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ05R-0002AW-Sh
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 09:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbZFWHGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 03:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbZFWHGW
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 03:06:22 -0400
Received: from antispam01.maxim-ic.com ([205.153.101.182]:43470 "EHLO
	antispam01.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbZFWHGV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2009 03:06:21 -0400
X-ASG-Debug-ID: 1245740265-0f4801f60000-QuoKaX
X-Barracuda-URL: http://AntiSpam01:8000/cgi-bin/mark.cgi
Received: from terlingua.dalsemi.com (localhost [127.0.0.1])
	by antispam01.maxim-ic.com (Spam Firewall) with ESMTP
	id 3C805244FD6; Tue, 23 Jun 2009 01:57:45 -0500 (CDT)
Received: from terlingua.dalsemi.com (terlingua.dalsemi.com [180.0.34.46]) by antispam01.maxim-ic.com with ESMTP id j8JI4rAPqFNpCvvO; Tue, 23 Jun 2009 01:57:45 -0500 (CDT)
Received: from itdalex02.it.maxim-ic.internal (itdalex02.it.maxim-ic.internal [10.16.15.7])
	by terlingua.dalsemi.com (8.10.2/8.10.2) with ESMTP id n5N76O801828;
	Tue, 23 Jun 2009 02:06:24 -0500 (CDT)
Received: from itdalias01.it.maxim-ic.internal ([10.16.15.60]) by itdalex02.it.maxim-ic.internal with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Jun 2009 02:06:37 -0500
Received: from maxdalex01.maxim-ic.internal (10.16.15.103) by
 itdalias01.it.maxim-ic.internal (10.16.15.60) with Microsoft SMTP Server
 (TLS) id 8.1.358.0; Tue, 23 Jun 2009 02:06:36 -0500
Received: from maxsvlex01.maxim-ic.internal (172.18.47.212) by
 maxdalex01.maxim-ic.internal (10.16.15.101) with Microsoft SMTP Server (TLS)
 id 8.1.358.0; Tue, 23 Jun 2009 02:06:36 -0500
Received: from ITSVLEX06.it.maxim-ic.internal ([172.18.41.168]) by
 maxsvlex01.maxim-ic.internal ([::1]) with mapi; Tue, 23 Jun 2009 00:06:35
 -0700
X-ASG-Orig-Subj: RE: [BUG] malloc error when using large file.
Thread-Topic: [BUG] malloc error when using large file.
Thread-Index: AcnzfqWPj+5g7G6OTqSV7ex4mcua2AAUXt3A
In-Reply-To: <20090622211542.GA19364@coredump.intra.peff.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: fr-FR, en-US
X-OriginalArrivalTime: 23 Jun 2009 07:06:37.0492 (UTC) FILETIME=[26694F40:01C9F3D1]
X-Barracuda-Connect: terlingua.dalsemi.com[180.0.34.46]
X-Barracuda-Start-Time: 1245740265
X-Barracuda-Virus-Scanned: by Barracuda Spam Firewall at maxim-ic.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122078>



> Many operations in git assume that a whole file can be held in memory at
> once. Do you actually have 2G available on the machine? Are there any OS
> limits that might be a problem?

Thanks for your answer Jeff, 

Yes I have more that 2 Go available when a do it, and after this allocation error if I try to do a 'git add' with a 9Go file, I did not have any issue.

Emmanuel.

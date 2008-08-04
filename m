From: Robert Richter <robert.richter@amd.com>
Subject: Re: Gitweb: Provide Git links in project list?
Date: Mon, 4 Aug 2008 12:12:01 +0200
Message-ID: <20080804101200.GC811@erda.amd.com>
References: <20080730125743.GY15356@erda.amd.com> <1217432970.2884.8.camel@localhost.localdomain> <20080730161126.GE31295@erda.amd.com> <1217796793.32240.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 12:13:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPx4K-0001TO-0F
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 12:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409AbYHDKM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 06:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbYHDKM0
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 06:12:26 -0400
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:60517 "EHLO
	WA4EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbYHDKMY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 06:12:24 -0400
Received: from mail74-wa4-R.bigfish.com (10.8.14.251) by
 WA4EHSOBE002.bigfish.com (10.8.40.22) with Microsoft SMTP Server id
 8.1.240.5; Mon, 4 Aug 2008 10:12:23 +0000
Received: from mail74-wa4 (localhost.localdomain [127.0.0.1])	by
 mail74-wa4-R.bigfish.com (Postfix) with ESMTP id B99921C60322;	Mon,  4 Aug
 2008 10:12:23 +0000 (UTC)
X-BigFish: VPS1(zz98dR936eQ62a3Lzz10d3izzz32i6bh87il43j)
X-FB-DOMAIN-IP-MATCH: fail
Received: by mail74-wa4 (MessageSwitch) id 1217844741454918_16836; Mon,  4 Aug
 2008 10:12:21 +0000 (UCT)
Received: from ausb3extmailp01.amd.com (unknown [163.181.251.8])	(using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits))	(No client certificate
 requested)	by mail74-wa4.bigfish.com (Postfix) with ESMTP id 4CC95570069;
	Mon,  4 Aug 2008 10:12:21 +0000 (UTC)
Received: from ausb3twp01.amd.com ([163.181.250.37])	by
 ausb3extmailp01.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 m74ACFRa017127;	Mon, 4 Aug 2008 05:12:19 -0500
X-WSS-ID: 0K52N0D-01-ZZS-01
Received: from sausexbh1.amd.com (sausexbh1.amd.com [163.181.22.101])	by
 ausb3twp01.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 204BB194403;
	Mon,  4 Aug 2008 05:12:12 -0500 (CDT)
Received: from SAUSEXMB3.amd.com ([163.181.22.202]) by sausexbh1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Mon, 4 Aug 2008 05:12:16 -0500
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by SAUSEXMB3.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Mon, 4 Aug 2008 05:12:16 -0500
Received: from erda.amd.com ([165.204.85.17]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Mon, 4 Aug 2008 12:12:14 +0200
Received: by erda.amd.com (Postfix, from userid 35569)	id 2CC5F8A21; Mon,  4
 Aug 2008 12:12:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217796793.32240.36.camel@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-OriginalArrivalTime: 04 Aug 2008 10:12:14.0091 (UTC) FILETIME=[90EA35B0:01C8F61A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91337>

On 03.08.08 13:53:13, J.H. wrote:
> Working on refactoring the patch so that it can go upstream, one of the
> things I'm definitely making an assumption about (in my original code)
> is that the base url will be uniform for the entire project_list (as it
> is on kernel.org).  If that's acceptable I will probably be able to
> submit something today, if not I will need to muck about and read out
> the url from .git/cloneurl (which would be a rather hefty performance
> hit - needing to read that from each repository)

John,

I just sent out a patch that implements this using cloneurl. It seemed
small and easy to implement and so I just made the change myself.

Thank you anyway.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com

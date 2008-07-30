From: Robert Richter <robert.richter@amd.com>
Subject: Re: Gitweb: Provide Git links in project list?
Date: Wed, 30 Jul 2008 15:13:57 +0200
Message-ID: <20080730131357.GZ15356@erda.amd.com>
References: <20080730125743.GY15356@erda.amd.com> <20080730130257.GB28566@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org
To: Fredrik Skolmli <fredrik@frsk.net>
X-From: git-owner@vger.kernel.org Wed Jul 30 15:15:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOBWV-0004ww-NO
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 15:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbYG3NOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 09:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbYG3NOW
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 09:14:22 -0400
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:5704 "EHLO
	SG2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbYG3NOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 09:14:22 -0400
Received: from mail207-sin-R.bigfish.com (10.3.40.3) by
 SG2EHSOBE006.bigfish.com (10.3.40.26) with Microsoft SMTP Server id
 8.1.240.5; Wed, 30 Jul 2008 13:14:18 +0000
Received: from mail207-sin (localhost.localdomain [127.0.0.1])	by
 mail207-sin-R.bigfish.com (Postfix) with ESMTP id B9545610587;	Wed, 30 Jul
 2008 13:14:18 +0000 (UTC)
X-BigFish: VPS-23(zz1432R98dR936eQ62a3L1805M936fQzz10d3izzz32i6bh87il43j61h)
X-Spam-TCS-SCL: 0:0
X-FB-DOMAIN-IP-MATCH: fail
Received: by mail207-sin (MessageSwitch) id 1217423657627158_28342; Wed, 30
 Jul 2008 13:14:17 +0000 (UCT)
Received: from ausb3extmailp01.amd.com (unknown [163.181.251.8])	(using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits))	(No client certificate
 requested)	by mail207-sin.bigfish.com (Postfix) with ESMTP id 1552BC50054;
	Wed, 30 Jul 2008 13:14:16 +0000 (UTC)
Received: from ausb3twp02.amd.com ([163.181.250.38])	by
 ausb3extmailp01.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 m6UDE8Lj008699;	Wed, 30 Jul 2008 08:14:12 -0500
X-WSS-ID: 0K4TM3F-02-2R0-01
Received: from sausexbh2.amd.com (SAUSEXBH2.amd.com [163.181.22.102])	by
 ausb3twp02.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 2630816A03D5;
	Wed, 30 Jul 2008 08:14:03 -0500 (CDT)
Received: from sausexmb1.amd.com ([163.181.3.156]) by sausexbh2.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 30 Jul 2008 08:14:11 -0500
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by sausexmb1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 30 Jul 2008 08:14:10 -0500
Received: from erda.amd.com ([165.204.85.17]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 30 Jul 2008 15:14:08 +0200
Received: by erda.amd.com (Postfix, from userid 35569)	id 774C58403; Wed, 30
 Jul 2008 15:13:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080730130257.GB28566@frsk.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-OriginalArrivalTime: 30 Jul 2008 13:14:08.0037 (UTC) FILETIME=[26117550:01C8F246]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90779>

On 30.07.08 15:02:57, Fredrik Skolmli wrote:
> On Wed, Jul 30, 2008 at 02:57:43PM +0200, Robert Richter wrote:
> 
> > The Gitweb on git.kernel.org povides links to the Git repository for
> > each project (git <git://...>). However, I did not find this feature
> > in the current implementation of git_project_list_body(). Does
> > somebody know if there is a patch available for this and if this could
> > be added to gitweb?
> 
> Is putting the address in .git/cloneurl giving the behaviour you're looking for?

Yes, I did change this and in the project summary I get "URL git://...".

That I mean is the main page, that lists the projects. I only have:

... summary | shortlog | log | tree

At git.kernel.org there is additional '... | git' with a link to the
Git repository.

The current source of gitweb seems not to provide this.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com

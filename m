From: Robert Richter <robert.richter@amd.com>
Subject: Re: Gitweb: Provide Git links in project list?
Date: Wed, 30 Jul 2008 18:11:27 +0200
Message-ID: <20080730161126.GE31295@erda.amd.com>
References: <20080730125743.GY15356@erda.amd.com> <1217432970.2884.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Wed Jul 30 18:13:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOEJ1-0008FA-5j
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 18:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053AbYG3QMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758027AbYG3QMf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 12:12:35 -0400
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:22452 "EHLO
	VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757979AbYG3QMe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 12:12:34 -0400
Received: from mail21-va3-R.bigfish.com (10.7.14.253) by
 VA3EHSOBE001.bigfish.com (10.7.40.21) with Microsoft SMTP Server id
 8.1.240.5; Wed, 30 Jul 2008 16:12:33 +0000
Received: from mail21-va3 (localhost.localdomain [127.0.0.1])	by
 mail21-va3-R.bigfish.com (Postfix) with ESMTP id CA8F11380512;	Wed, 30 Jul
 2008 16:12:33 +0000 (UTC)
X-BigFish: VPS-21(zz1432R98dR936eQ4015M62a3L1805Mzz10d3izzz32i6bh87il61h)
X-Spam-TCS-SCL: 0:0
X-FB-DOMAIN-IP-MATCH: fail
Received: by mail21-va3 (MessageSwitch) id 1217434352265354_8162; Wed, 30 Jul
 2008 16:12:32 +0000 (UCT)
Received: from ausb3extmailp02.amd.com (ausb3extmailp02.amd.com
 [163.181.251.22])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail21-va3.bigfish.com (Postfix) with
 ESMTP id 11A7B172806C;	Wed, 30 Jul 2008 16:12:31 +0000 (UTC)
Received: from ausb3twp01.amd.com ([163.181.250.37])	by
 ausb3extmailp02.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 m6UGCQ1e013981;	Wed, 30 Jul 2008 11:12:30 -0500
X-WSS-ID: 0K4TUCM-01-J3Z-01
Received: from sausexbh2.amd.com (SAUSEXBH2.amd.com [163.181.22.102])	by
 ausb3twp01.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 2896A19472E;
	Wed, 30 Jul 2008 11:12:21 -0500 (CDT)
Received: from SAUSEXMB3.amd.com ([163.181.22.202]) by sausexbh2.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 30 Jul 2008 11:12:29 -0500
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by SAUSEXMB3.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 30 Jul 2008 11:11:40 -0500
Received: from erda.amd.com ([165.204.85.17]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 30 Jul 2008 18:11:38 +0200
Received: by erda.amd.com (Postfix, from userid 35569)	id 7471A8403; Wed, 30
 Jul 2008 18:11:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217432970.2884.8.camel@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-OriginalArrivalTime: 30 Jul 2008 16:11:38.0290 (UTC) FILETIME=[F21D1920:01C8F25E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90813>

On 30.07.08 08:49:30, J.H. wrote:
> That is a kernel.org specific change - if the community at large wants
> it I can dig the patch out (I likely didn't do it as it's own patch when
> I did it, being young, naive and stupid at the time - I'm now slightly
> older and slightly less naive now ;-)
> 
> But yeah - if people feel that's interesting I'm happy to rip it out
> later today and submit it to the mailing list.

John, I would like the patch.

Yes, I have seen the commit as well and it is not the only change in
this commit. Also, if I got it right, the repository is not taken from
.git/cloneurl. So, with the current implementation the git url in the
summary page may be different to cloneurl. But this is not a major
issue.

It would be great if you could provide a patch with your changes for
gitweb.

Thanks,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
email: robert.richter@amd.com

From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH 1/4] reset: add a few tests for "git reset --merge"
Date: Sun, 13 Sep 2009 23:01:20 +0100
Message-ID: <alpine.LSU.2.00.0909132300420.21486@hermes-2.csi.cam.ac.uk>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <20090910202333.3722.45063.chriscool@tuxfamily.org> <200909102259.16469.jnareb@gmail.com> <200909110722.13331.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Sep 14 00:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmx8S-0000A4-IP
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 00:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbZIMWBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 18:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbZIMWBT
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 18:01:19 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:41261 "EHLO
	ppsw-6.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbZIMWBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 18:01:18 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:54445)
	by ppsw-6.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Mmx8K-000160-La (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Sun, 13 Sep 2009 23:01:20 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1Mmx8K-0006ic-Ll (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Sun, 13 Sep 2009 23:01:20 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <200909110722.13331.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128421>

On Fri, 11 Sep 2009, Christian Couder wrote:
> On Thursday 10 September 2009, Jakub Narebski wrote:
> > Christian Couder wrote:
> > >
> > > exec </dev/null
> >
> > What does this do?
>
> Nothing! Yeah, this is a mistake.

It redirects stdin of the current shell.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.

From: Charles Bailey <cbailey32@bloomberg.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Wed, 26 Mar 2014 20:41:10 +0000
Message-ID: <20140326204110.GB6991@hashpling.org>
References: <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
 <20140326182103.GB7087@sigill.intra.peff.net>
 <20140326185153.GA12912@sigill.intra.peff.net>
 <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
 <20140326192536.GA13989@sigill.intra.peff.net>
 <20140326193359.GA14105@sigill.intra.peff.net>
 <20140326194043.GB14105@sigill.intra.peff.net>
 <20140326203618.GA6991@hashpling.org>
 <20140326203830.GA16332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 21:41:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSudT-0000A7-H4
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 21:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbaCZUlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 16:41:14 -0400
Received: from avasout05.plus.net ([84.93.230.250]:37045 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbaCZUlN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 16:41:13 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id iLhB1n0022iA9hg01LhC3z; Wed, 26 Mar 2014 20:41:12 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=SYp5d5hu c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=zd_RDMET5nsA:10 a=ZWHkJ8qrxXAA:10 a=N2sEI2mohSIA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=BNFp--SqAAAA:8 a=Ew9TdX-QAAAA:8
 a=VMhJHFvjrZMgmqpMrgUA:9 a=CjuIK1q_8ugA:10 a=Npoi8lV9haEA:10 a=7S9earn9soYA:10
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1WSudK-0001uB-Vg; Wed, 26 Mar 2014 20:41:10 +0000
Content-Disposition: inline
In-Reply-To: <20140326203830.GA16332@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245225>

On Wed, Mar 26, 2014 at 04:38:30PM -0400, Jeff King wrote:
> 
> By the way, can you confirm that this is a 64-bit system? On a 32-bit
> system, we should be triggering different code paths (we fail at the
> strtoul level). Those should be checked by the previous tests, but I'd
> like to make sure.

Yes, we're only building 64-bit at the moment.

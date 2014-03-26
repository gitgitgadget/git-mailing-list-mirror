From: Charles Bailey <cbailey32@bloomberg.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Wed, 26 Mar 2014 20:36:18 +0000
Message-ID: <20140326203618.GA6991@hashpling.org>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
 <20140326182103.GB7087@sigill.intra.peff.net>
 <20140326185153.GA12912@sigill.intra.peff.net>
 <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
 <20140326192536.GA13989@sigill.intra.peff.net>
 <20140326193359.GA14105@sigill.intra.peff.net>
 <20140326194043.GB14105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 21:36:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSuYo-0003zF-7o
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 21:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242AbaCZUgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 16:36:25 -0400
Received: from avasout06.plus.net ([212.159.14.18]:52263 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195AbaCZUgY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 16:36:24 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id iLcK1n0022iA9hg01LcLd8; Wed, 26 Mar 2014 20:36:22 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=dodVCjQ4 c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=zd_RDMET5nsA:10 a=ZWHkJ8qrxXAA:10 a=N2sEI2mohSIA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=BNFp--SqAAAA:8 a=Ew9TdX-QAAAA:8
 a=Fh3-5iwxQGZXB5aA2k8A:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1WSuYc-0001t2-UT; Wed, 26 Mar 2014 20:36:18 +0000
Content-Disposition: inline
In-Reply-To: <20140326194043.GB14105@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245223>

On Wed, Mar 26, 2014 at 03:40:43PM -0400, Jeff King wrote:
> On Wed, Mar 26, 2014 at 03:33:59PM -0400, Jeff King wrote:
> 
> > That being said, is the AIX value actually right? I did not look closely
> > at first, but just assumed that it was vaguely right. But:
> > 
> >   999999999999999999 / (86400 * 365)
> > 
> > is something like 31 billion years in the future, not 160 million.
> > A real date calculation will have a few tweaks (leap years, etc), but
> > that is orders of magnitude off.
> 
> Assuming my math is right, then here is the most sensible patch, IMHO.
> 

Perhaps hold onto this one for a little while longer. Splitting things
out from the test is giving me some inconsistent results, there may be
something else going wrong in our environment here.

Charles.

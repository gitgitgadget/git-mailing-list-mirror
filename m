From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git tag --contains : avoid stack overflow
Date: Wed, 23 Apr 2014 23:14:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404232313370.14982@s15462909.onlinehome-server.info>
References: <20140416141519.GA9684@camelia.ucw.cz> <20140416154653.GB4691@sigill.intra.peff.net> <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info> <20140417213238.GA14792@sigill.intra.peff.net> <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
 <20140417215817.GA822@sigill.intra.peff.net> <20140423075325.GA7268@camelia.ucw.cz> <20140423191749.GB20596@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:14:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4VF-0007SG-Uz
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605AbaDWVOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:14:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:54352 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757585AbaDWVOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:14:45 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0M1msU-1WtDk91OpO-00tnwj;
 Wed, 23 Apr 2014 23:14:43 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140423191749.GB20596@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:EvbXzo1n7VTkevpTl4tToyLcpwGKwqdX/VsARqi5vLBMc6ndI8Y
 /YeF1VNS/3b4aKcYmbD26G2q/XLfz1Lh1FrBXut/1InoTt6NX2D3E+gXU8WS9qcGZyc/LR6
 Bc6cp1Hwb5qWpqWqjssz79YzVGpq1ffhcH/S4ItYAufTPzBteVFMIfsj3OcoWSjr10X38t+
 e9R5KsI0L0+ffclUFzMBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246897>

Hi Peff,

On Wed, 23 Apr 2014, Jeff King wrote:

> On Wed, Apr 23, 2014 at 09:53:25AM +0200, Stepan Kasal wrote:
> 
> > I have found out that "ulimit -s" does not work on Windows.  Adding
> > this as a prerequisite, we will skip the test there.
> 
> I found this bit weird, as the test originated on Windows. Did it never
> actually cause a failure there (i.e., the "ulimit -s" doesn't do
> anything)? Or does "ulimit" fail?

I must have forgotten to test on Windows. For performance reasons (you
know that I only have a Git time budget of about 15min/day), I developed
the test and the patch on Linux.

Ciao,
Johannes

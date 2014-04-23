From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git tag --contains : avoid stack overflow
Date: Wed, 23 Apr 2014 16:28:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404231627590.14982@s15462909.onlinehome-server.info>
References: <20140416141519.GA9684@camelia.ucw.cz> <20140416154653.GB4691@sigill.intra.peff.net> <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info> <20140417213238.GA14792@sigill.intra.peff.net> <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
 <20140417215817.GA822@sigill.intra.peff.net> <20140423075325.GA7268@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Apr 23 16:28:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcyAK-0001DM-Ha
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 16:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266AbaDWO2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 10:28:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:63515 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902AbaDWO2m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 10:28:42 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MC3zg-1Wlnrr3IjA-008sm8;
 Wed, 23 Apr 2014 16:28:39 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140423075325.GA7268@camelia.ucw.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:mU532aW5PPBT/QGmSqY6Mc6eJirus06Hx8YFQzNAeAFoo5FHEWV
 uTfm1GZ1vHlYjvUQXK2T9GuU4bsEQcK8aqmSeVSdMN84frbG5lne/Czm2PVmL9OvH5Elekx
 Lu5lNFUiudIVID4Yb/4/NJWyv5j4mKdBOG6ZY2JiPspytZNtZCQeP+7vUa6d7Kvkrj0nIQP
 hVq9fVdmfyAH067HYn8wQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246842>

Hi,

On Wed, 23 Apr 2014, Stepan Kasal wrote:

> I have found out that "ulimit -s" does not work on Windows.
> Adding this as a prerequisite, we will skip the test there.

The interdiff can be seen here:

	https://github.com/msysgit/git/commit/c68e27d5

Ciao,
Johannes

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Use alternate GIT servers to share traffic
Date: Wed, 25 Mar 2009 23:57:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903252356160.26370@intel-tinevez-2-302>
References: <200903252145.30226.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Wed Mar 25 23:59:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmc3X-0000Xo-Kq
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 23:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981AbZCYW5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 18:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbZCYW5I
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 18:57:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:60437 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754149AbZCYW5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 18:57:07 -0400
Received: (qmail invoked by alias); 25 Mar 2009 22:57:02 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp060) with SMTP; 25 Mar 2009 23:57:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QrBg/NeRQ7K0le0D5xzV8idBPuwTn4kzBosezCV
	Nsz8M8NDUsEMKN
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200903252145.30226.thomas@koch.ro>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114689>

Hi,

On Wed, 25 Mar 2009, Thomas Koch wrote:

> we host a public GIT repository on our high availability company 
> cluster. Cloning the repo causes a trafic volume of 326 MB. We'd like to 
> avoid that much trafic while still leaving the GIT repo where it is.
> 
> I could imagine the following conversation between the GIT client and
> server:
> 
> Client: Wanna clone!
> Server: You're welcome. Please note, that while I serve the most current
> state, you can get objects much faster from my collegue Server
> CHEAPHOST.
> Client: Thank you. Will take all the objects I can get from CHEAPHOST
> and come back if I should need anything else!
> 
> The enduser should not need to specify anything, but only the regular
> git clone EXPENSIVEHOST line.
> 
> Your thoughts?

That sounds a lot like the mirror-sync idea.

Ciao,
Dscho

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Testing if a certain commit is in the current branch
Date: Wed, 27 Jan 2010 09:56:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001270955350.4985@pacific.mpi-cbg.de>
References: <201001270819.39819.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Wed Jan 27 09:50:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na3bT-00071d-Dc
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 09:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab0A0IuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 03:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831Ab0A0IuG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 03:50:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:33121 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751658Ab0A0IuB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 03:50:01 -0500
Received: (qmail invoked by alias); 27 Jan 2010 08:49:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp022) with SMTP; 27 Jan 2010 09:49:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wTH0xDYzwkOGvjH15ubDImBDRER0zMOC2HqLTDG
	y+61JFJKGeSlvt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <201001270819.39819.elendil@planet.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.69999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138118>

Hi,

On Wed, 27 Jan 2010, Frans Pop wrote:

> I'm currently using the following command for this:
>    git log --pretty=format:%H | grep -q '^<commit id>"
> 
> Problem is that with large repos that can be quite slow.
> 
> Is there a faster way to do the test?

You are more likely looking for "git branch --contains".  But this gives 
you _more_ information.

Ciao,
Dscho

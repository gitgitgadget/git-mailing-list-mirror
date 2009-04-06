From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fetching SHA id's instead of named references?
Date: Mon, 6 Apr 2009 14:48:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904061447220.6619@intel-tinevez-2-302>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>  <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302> <33f4f4d70904060541s6dfb7e8ctf50f5e8a872ae1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 14:51:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqoGu-0000w3-Ad
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 14:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbZDFMsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 08:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbZDFMsV
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 08:48:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:41660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755380AbZDFMsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 08:48:20 -0400
Received: (qmail invoked by alias); 06 Apr 2009 12:48:17 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp029) with SMTP; 06 Apr 2009 14:48:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TzG1i5HETjNlm11BeLPlYDfDelo8z9mKi52eXtX
	8buoGZs9bBq8tO
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <33f4f4d70904060541s6dfb7e8ctf50f5e8a872ae1c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115815>

Hi,

On Mon, 6 Apr 2009, Klas Lindberg wrote:

> Thank you, but I don't understand the answer. If I mistakenly publish a 
> tree that contains secrets and someone manages to fetch against it 
> before I correct the mistake; how does the limitation to only fetch 
> named references help me???

The issue is not if someone manages to fetch stuff before you repair it.  
The issue is that that someone should not be able to manage _after_ you 
repair it.

Oh, and please do not top-post,
Dscho

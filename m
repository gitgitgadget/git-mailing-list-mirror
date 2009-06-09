From: Nicolas Pitre <nico@cam.org>
Subject: Re: git clone failing over slow links?
Date: Tue, 09 Jun 2009 14:42:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906091440100.31536@xanadu.home>
References: <2729632a0906090852r124eff8eo8391ae90cbda5872@mail.gmail.com>
 <robbat2-20090609T171032-419739557Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME6IE-0002s3-Al
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 20:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757517AbZFISnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 14:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756850AbZFISnL
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 14:43:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15637 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbZFISnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 14:43:10 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKZ00FLIIL9N421@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Jun 2009 14:41:34 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <robbat2-20090609T171032-419739557Z@orbis-terrarum.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121202>

On Tue, 9 Jun 2009, Robin H. Johnson wrote:

> On Tue, Jun 09, 2009 at 08:52:10AM -0700, skillzero@gmail.com wrote:
> > People with slower connections are having problems cloning my
> > repository. The server seems to just drop the connection. This
> > repository is about 300 MB. The server is using git 1.6.1. This is
> > using an ssh URL. They've tried many times and it usually dies at
> > different places in the clone (5%, 80%, etc., with one successful
> > clone so far for them).
> For Gentoo, we saw what I think was same problem early on with our
> conversion experiments. In our case however, it's going to be a
> non-problem as we intend on disabling initial clone and requiring use of
> a bundle.

In the Gentoo case, I think your problem was rather about the memory 
usage impact of an initial clone and nothing to do with the speed of the 
connection.


Nicolas

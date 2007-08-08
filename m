From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Submodules
Date: Wed, 8 Aug 2007 01:07:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708080104170.14781@racer.site>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com> 
 <Pine.LNX.4.64.0708072349400.14781@racer.site>
 <a1bbc6950708071631w5d232e92gd0fa27158b27b5c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 02:58:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIZsw-0003Nv-Ju
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 02:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbXHHA6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 20:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbXHHA6r
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 20:58:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:47030 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763598AbXHHA6q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 20:58:46 -0400
Received: (qmail invoked by alias); 08 Aug 2007 00:08:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 08 Aug 2007 02:08:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fo4JAIXNfK0sh8x0eRXueTNNWuFEwGQza807six
	eTJJiFKknEsRKN
X-X-Sender: gene099@racer.site
In-Reply-To: <a1bbc6950708071631w5d232e92gd0fa27158b27b5c3@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55288>

Hi,

On Tue, 7 Aug 2007, Dmitry Kakurin wrote:

> * how come sumbodules are not initialized when I do a clone of super.
> I expect to be able to build super after I clone it. Is there a new
> (undocumented) flag to clone?

There might be.  But one of the reasons submodules are not just tree 
objects is that you should be able _not_ to check out all of them (think 
KDE).

> * why submodules should be listed in 2 places: in .submodules and in
> super/.git/config?

Well, URLs can change.  Therefore, .submodules has what is considered the 
current URL, but you can change it yourself in .git/config.  (At least 
that is how I understood it.)

Ciao,
Dscho

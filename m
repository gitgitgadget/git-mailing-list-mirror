From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-cvsimport gets parents wrong for branches
Date: Tue, 4 Jul 2006 10:09:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607041007391.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060703215303.GA24572@memak.tu-darmstadt.de>
 <46a038f90607031615m2cafbf05q5922fb04eae72362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Elrond <elrond+kernel.org@samba-tng.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 10:09:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxfyJ-0007ae-4Z
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 10:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWGDIJW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 04:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWGDIJV
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 04:09:21 -0400
Received: from mail.gmx.de ([213.165.64.21]:21633 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751116AbWGDIJU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 04:09:20 -0400
Received: (qmail invoked by alias); 04 Jul 2006 08:09:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 04 Jul 2006 10:09:19 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90607031615m2cafbf05q5922fb04eae72362@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23269>

Hi,

On Tue, 4 Jul 2006, Martin Langhoff wrote:

> It is pretty hard to get that one right in any case, as there are
> cases where the new branch starts from something that is not a commit
> in the parent (from GIT's perspective).

But it should be easy to introduce a faked commit, which just contains 
those versions (and takes the newest commit touching any of these file 
versions as branch point).

Ciao,
Dscho

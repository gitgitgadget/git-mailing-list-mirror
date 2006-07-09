From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] just an (stupid) idea when creating a new branch
Date: Sun, 9 Jul 2006 16:33:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607091632070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060708155547.73054.qmail@web25814.mail.ukl.yahoo.com> 
 <e8p8pj$jk3$2@sea.gmane.org> <e5bfff550607082354g62e99216gc72b07055762de3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 16:34:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzaMA-00021e-Qb
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 16:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWGIOd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 10:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWGIOd4
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 10:33:56 -0400
Received: from mail.gmx.net ([213.165.64.21]:30907 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932456AbWGIOdz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 10:33:55 -0400
Received: (qmail invoked by alias); 09 Jul 2006 14:33:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 09 Jul 2006 16:33:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550607082354g62e99216gc72b07055762de3a@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23553>

Hi,

On Sun, 9 Jul 2006, Marco Costalba wrote:

> It is possible to add a message (and more) to a tag creating a tag
> object. FWIK this is not allowed for the other refs.
> 
> Why there is this (artifical?) difference between tags and the other
> kind of refs?

The tag message is nothing else than a commit message. The 
(artificial-but-on-purpose) difference is that you are not supposed to 
change a tag ref, whereas a regular ref pointing to a commit is _expected_ 
to point to some other commit in the future.

Ciao,
Dscho

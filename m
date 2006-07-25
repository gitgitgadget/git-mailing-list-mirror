From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow an alias to start with "-p"
Date: Tue, 25 Jul 2006 08:27:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607250822200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607190125150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xmjh5sv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607241408170.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virlmfrl4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 25 08:27:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5GOR-00013Y-Et
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 08:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWGYG1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 02:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWGYG1n
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 02:27:43 -0400
Received: from mail.gmx.de ([213.165.64.21]:59035 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751455AbWGYG1m (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 02:27:42 -0400
Received: (qmail invoked by alias); 25 Jul 2006 06:27:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 25 Jul 2006 08:27:41 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virlmfrl4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24160>

Hi,

On Mon, 24 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Now, something like
> >
> > 	[alias]
> > 		pd = -p diff
> >
> > works as expected.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> This seems to break t5400 among other things (git-clone
> complains that it is not invoked in a git repository).

See Peff's mail for a fix (hopefully: I do not see why git-clone should 
be affected, as it is a script, not a hard link to the git wrapper). The 
funny thing: t5400 does not break here.

Ciao,
Dscho

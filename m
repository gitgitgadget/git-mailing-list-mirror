From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: [PATCH] contrib/vim: add syntax highlighting file for commits
Date: Wed, 13 Sep 2006 00:46:40 -0600
Message-ID: <20060913064640.GA3731@socrates.priv>
References: <20060911232249.GB29736@coredump.intra.peff.net>
 <20060912020813.GD26332@socrates.priv>
 <20060912023256.GA6596@coredump.intra.peff.net>
 <7vy7so9txj.fsf@assigned-by-dhcp.cox.net>
 <20060913062557.GA4783@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 13 08:45:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNOVG-0004YN-OY
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 08:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWIMGph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 02:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWIMGph
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 02:45:37 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:22222 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751629AbWIMGpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 02:45:36 -0400
Received: from pd5mr6so.prod.shaw.ca
 (pd5mr6so-qfe3.prod.shaw.ca [10.0.141.182]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J5I00EJTQOH7L70@l-daemon> for git@vger.kernel.org; Wed,
 13 Sep 2006 00:43:29 -0600 (MDT)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
 by pd5mr6so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0J5I00631QOHJVB0@pd5mr6so.prod.shaw.ca> for
 git@vger.kernel.org; Wed, 13 Sep 2006 00:43:29 -0600 (MDT)
Received: from socrates.priv ([68.148.44.80])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J5I000ONQOETBI0@l-daemon> for git@vger.kernel.org; Wed,
 13 Sep 2006 00:43:29 -0600 (MDT)
Received: from socrates.priv (localhost [127.0.0.1])
	by socrates.priv (8.13.4/8.13.4) with ESMTP id k8D6keVj007819	for
 <git@vger.kernel.org>; Wed, 13 Sep 2006 00:46:40 -0600
Received: (from cougar@localhost)	by socrates.priv (8.13.4/8.13.4/Submit)
 id k8D6keUB007818	for git@vger.kernel.org; Wed, 13 Sep 2006 00:46:40 -0600
In-reply-to: <20060913062557.GA4783@coredump.intra.peff.net>
To: git@vger.kernel.org
Mail-followup-to: git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.11-2006-05-17
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26905>

On Wed, Sep 13, 2006 at 02:25:57AM -0400, Jeff King wrote:
 
> My point was that there may be many files named gitcommit.vim; the
> directory they appear in under your .vim directory has significance. If
> we add another such file, they will conflict in the flattened namespace
> of contrib/vim.  See below (which also adds the necessary mkdir
> command):
> 

Much clearer. I had glanced at the readme and did
cp commit-syntax.vim ~/.vim/syntax
and it took me a minute or so to figure what was wrong.

  Tom

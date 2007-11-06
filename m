From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 00:08:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711060007010.4362@racer.site>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
 <fgo5dt$avh$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 01:09:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpC0t-0000fu-1O
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 01:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbXKFAJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 19:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754634AbXKFAJh
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 19:09:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:40798 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754453AbXKFAJg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 19:09:36 -0500
Received: (qmail invoked by alias); 06 Nov 2007 00:09:35 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp004) with SMTP; 06 Nov 2007 01:09:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LciYe6mLLzoh0raZ8f45z4/iCZUMSsTsCCv7zvf
	KYYKPHAFZ+Peku
X-X-Sender: gene099@racer.site
In-Reply-To: <fgo5dt$avh$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63598>

Hi,

On Mon, 5 Nov 2007, Jakub Narebski wrote:

> Aghiles wrote:
> 
> > I am not sure this is the best place to write about this. Anyway,
> > we just switched a couple of repositories to git (from svn) here
> > at work and one thing people find annoying is a pull into
> > a dirty directory. Before the "stash" feature it was even worse
> > but now we can type:
> > 
> > ? ? git stash
> > ? ? git pull
> > ? ? git stash apply
> > 
> > But isn't that something we should be able to specify to the "pull"
> > command ?
> 
> If I remember correctly there is/was some preliminary work (at most 'pu'
> stages) about adding --dirty option to git-merge, git-pull and git-rebase.

There was, but AFAICT these are dead now.

The consense was that you are much better off committing first, then 
pulling.  And if the work you are doing really is not committable, but you 
_have_ to pull _now_, you use stash.  Although you are quite likely to 
revert the pull when it succeeds, and _then_ unstash.

Ciao,
Dscho

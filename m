From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 15:13:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609271509240.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org>
 <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com>
 <20060927080652.GA8056@admingilde.org>
 <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060927113813.GC8056@admingilde.org>
 <Pine.LNX.4.63.0609271358100.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060927124604.GD8056@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 15:14:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSZEU-0006SH-DK
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 15:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWI0NNm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 09:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWI0NNm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 09:13:42 -0400
Received: from mail.gmx.de ([213.165.64.20]:36224 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751152AbWI0NNl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 09:13:41 -0400
Received: (qmail invoked by alias); 27 Sep 2006 13:13:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 27 Sep 2006 15:13:39 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060927124604.GD8056@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27904>

Hi,

On Wed, 27 Sep 2006, Martin Waitz wrote:

> On Wed, Sep 27, 2006 at 02:01:11PM +0200, Johannes Schindelin wrote:
>
> > AFAICT this is not the idea of subprojects-in-git. If you have to track 
> > the subprojects in the root project manually anyway, you don't need _any_ 
> > additional tool (you _can_ track files in a subdirectory containing a .git 
> > subdirectory).
> 
> But then you loose the fine grained commits of your subprojects. You 
> only store the tree of the subproject when committing to the parent, not 
> the entire history.

The more I get told about subprojects (I don't have a use for them 
myself), the more I think you are right: subprojects should not be 
integrated deeply into git.

Ciao,
Dscho

From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] rebase -i: use some kind of config file to save author information
Date: Wed, 24 Jun 2009 06:36:04 +0200
Message-ID: <200906240636.04675.chriscool@tuxfamily.org>
References: <20090620023413.3995.3630.chriscool@tuxfamily.org> <200906230730.01456.chriscool@tuxfamily.org> <alpine.DEB.1.00.0906231137220.5252@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 24 06:36:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJKDu-0002rY-QI
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 06:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbZFXEfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 00:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbZFXEfv
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 00:35:51 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:34980 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbZFXEfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 00:35:51 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A159E818076;
	Wed, 24 Jun 2009 06:35:45 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 84EBF8180CE;
	Wed, 24 Jun 2009 06:35:42 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0906231137220.5252@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122123>

Hi,

On Tuesday 23 June 2009, Johannes Schindelin wrote:
> Hi,
>
> On Tue, 23 Jun 2009, Christian Couder wrote:
> > The problem with this is that it will take a lot of time to implement
> > the features that have been added to rebase -i since the sequencer
> > stalled, then to polish it, and to get it reviewed and so on, and
> > during that time other features or changes may be implemented by other
> > people.
> >
> > So I prefer to use code from the current sequencer (at
> > http://repo.or.cz/w/git/sbeyer.git) to start porting step by step
> > rebase -i to C.
>
> I think that the best way to go forward would be to have something like
> fetch--tool, i.e. a builtin helper that successively takes more and more
> functionality into C.

Yeah, I started working on something like that.

> IMHO a first sensible step would be to implement the commands ("pick",
> "squash", "edit") in such a helper, and call them from do_next().
>
> That should take care of the most difficult part, getting the transition
> started.

I agree that it looks like a good way forward.

> But I had the impression that the sequencer started out almost like this,
> but then it also wanted to implement the do_next() and everything.

Yeah, I think at some steps we got something close to that.

Thanks,
Christian.

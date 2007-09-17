From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: metastore
Date: Mon, 17 Sep 2007 13:42:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709171308150.5298@iabervon.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161245490.24221@asgard.lang.hm> <7v7imq5ki0.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161541330.24221@asgard.lang.hm> <7vk5qq3y76.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709161925000.24221@asgard.lang.hm> <7v7imp539u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: david@lang.hm, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXKbu-0000WY-Vw
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 19:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbXIQRmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 13:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbXIQRmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 13:42:09 -0400
Received: from iabervon.org ([66.92.72.58]:41121 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbXIQRmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 13:42:08 -0400
Received: (qmail 27297 invoked by uid 1000); 17 Sep 2007 17:42:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Sep 2007 17:42:06 -0000
In-Reply-To: <7v7imp539u.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58465>

On Sun, 16 Sep 2007, Junio C Hamano wrote:

> david@lang.hm writes:
> 
> >> Post-checkout trigger is something I can say I can live with
> >> without looking at the actual patch, but that does not mean it
> >> would be a better approach at all.
> >
> > we agree on this much at least :-)
> >
> >> I would not be able to answer the first question right now; that
> >> needs a patch to prove that it can be done with a well contained
> >> set of changes that results in a maintainable code.
> >
> > you cannot answer the question in the affirmitive, but you could say
> > that any changes in that area would be completely unacceptable to you
> > (and for a while it sounded like you were saying exactly that). in
> > which case any effort put into preparing patches would be a waste of
> > time
> 
> I tend to disagree.  It's far from a waste of time.  While, as I
> said, I am skeptical that such a patch would be small impact, if
> it helps people's needs, somebody will pick it up and carry
> forward, even if that somebody is not me.  It can then mature
> out of tree and later could be merged.  We simply do not know
> unless somebody tries.  And I am quite happy that you seem to be
> motivated enough to see how it goes.

There's certainly the possibility that a changeset could consist of some 
patches that make the index/filesystem handling more clear, some patches 
that make the tree/index handling more clear, and some patches that allow 
a hook to replace one of these entirely. Things can be a lot more 
acceptable if the intrusive changes are improvements for the 
maintainability of the normal case, and the special case code is no longer 
intrusive at all.

	-Daniel
*This .sig left intentionally blank*

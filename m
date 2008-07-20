From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 20 Jul 2008 21:07:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807202102370.3305@eeepc-johanness>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org> <7vlk01hqzz.fsf@gitster.siamese.dyndns.org> <20080718175040.6117@nanako3.lavabit.com> <20080718182010.6117@nanako3.lavabit.com> <7v63r38r4r.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness>
 <7vabge30dh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness> <20080720130407.GF10347@genesis.frugalware.org> <7vd4l88l77.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 21:07:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKeFd-0002Lx-K4
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 21:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYGTTGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 15:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbYGTTGV
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 15:06:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:46267 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751290AbYGTTGU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 15:06:20 -0400
Received: (qmail invoked by alias); 20 Jul 2008 19:06:18 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp001) with SMTP; 20 Jul 2008 21:06:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VDqAlEXRVNgO+NThB6a6aR0SCAXpPYOEmsuYjCV
	HRfIKRoAKuvVQY
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vd4l88l77.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89216>

Hi,

On Sun, 20 Jul 2008, Junio C Hamano wrote:

> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
> > Third, it would be nice to allow passing extra parameter(s) to the
> > backends, but I do not know what concept is the best here. The
> > strategy1=foo,stategy2=bar limits the input to a single string. Is that
> > enough? Given that recursive=theirs was considered harmful, we don't
> > have too much examples;...
> 
> I personally think -sstrategy=string1,string2,... is simply a bad taste.
> 
> Why force yourself to parse things by having the users to concatenate
> something that the user could give us separated?  If you care about the
> order and association between strategy and their options, you can always
> do:
> 
> 	-s strategy1 -X option-1-for-strategy-1 -X option-2-for-strategy-1 \
> 	-s strategy2 -X option-1-for-strategy-2 ...

You mean something like

	$ git merge -s subtree -X --path -X git-gui/ git-gui/master

Wow. :-)

Speechless,
Dscho

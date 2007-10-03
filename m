From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Wed, 3 Oct 2007 16:54:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710031653480.28395@racer.site>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site> 
 <11912513203420-git-send-email-tom@u2i.com>  <7vr6ker1lf.fsf@gitster.siamese.dyndns.org>
  <550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com> 
 <87ejgescnb.wl%cworth@cworth.org>  <550f9510710011521s126ca747v956a6f80182444bb@mail.gmail.com>
  <20071001223050.GE2137@spearce.org>  <Pine.LNX.4.64.0710021056280.28395@racer.site>
  <550f9510710020329m7917dc9m2bb6cfc4055fea84@mail.gmail.com> 
 <7vr6kdl5rj.fsf@gitster.siamese.dyndns.org> <550f9510710030711p195378c5t2739292d31a12de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 17:56:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id6aE-0005Vu-AQ
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 17:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbXJCP4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 11:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbXJCP4G
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 11:56:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:37774 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755344AbXJCP4F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 11:56:05 -0400
Received: (qmail invoked by alias); 03 Oct 2007 15:56:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 03 Oct 2007 17:56:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uAfFmzrousQH7bBwl2npkVVX3Fk6X5sjWYfEORj
	tOw3Fv7I2YRa3M
X-X-Sender: gene099@racer.site
In-Reply-To: <550f9510710030711p195378c5t2739292d31a12de@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59847>

Hi,

On Wed, 3 Oct 2007, Tom Clarke wrote:

> On 10/2/07, Junio C Hamano <gitster@pobox.com> wrote:
> > I do not offhand think of a place other than "git pull" that
> > would make sense to sometimes be able to rebase when you
> > normally use merge, so I am inclined to say it would be easier
> > to teach that "'git pull' is usually a 'git fetch' followed by
> > 'git merge', but in certain workflow it is handier to 'git
> > fetch' and then 'git rebase', and here are the ways to get the
> > rebasing behaviour...".
> 
> I agree. I'll revisit teaching pull to be able to use rebase.

In that case, may I request a config variable to set this behaviour 
automatically when calling "git pull <nick>"?

Had we stayed with the merge strategy approach, that would have come for 
free with the --no-ff patch series.

Ciao,
Dscho

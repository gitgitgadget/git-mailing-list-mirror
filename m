From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] gitweb: add a setting to control the tabstop width
Date: Tue, 4 Mar 2008 08:41:20 +0000
Message-ID: <20080304084120.GB13585@hashpling.org>
References: <20080303221159.GA6875@hashpling.org> <7vhcfnfljw.fsf@gitster.siamese.dyndns.org> <46a038f90803031935s7957a700nb5d3ba09b6575423@mail.gmail.com> <200803040919.44925.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 09:42:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWSjS-0000bB-8w
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 09:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763790AbYCDIlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 03:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYCDIlb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 03:41:31 -0500
Received: from ptb-relay02.plus.net ([212.159.14.213]:34705 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759311AbYCDIla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 03:41:30 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1JWSiE-00076c-Cw; Tue, 04 Mar 2008 08:41:26 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m248fKct014326;
	Tue, 4 Mar 2008 08:41:20 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m248fKwl014325;
	Tue, 4 Mar 2008 08:41:20 GMT
Content-Disposition: inline
In-Reply-To: <200803040919.44925.jnareb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Plusnet-Relay: 1812f3f971bbe1c930d3395c7889f009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76053>

On Tue, Mar 04, 2008 at 09:19:43AM +0100, Jakub Narebski wrote:
> On Tue, 4 Mar 2008, Martin Langhoff wrote:
> > On Tue, Mar 4, 2008 at 12:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>  Some people say "Tabs are 8 characters, and thus indentations are also 8
> >>  characters.  There are heretic movements that try to make indentations 4
> >>  (or even 2!)  characters deep, and that is akin to trying to define the
> >>  value of PI to be 3."  Some people disagree.
> > 
> > And on the web, people use CSS to sort these disagreements amicably...
> > As a web apps guy, adding a setting for something like this, and then
> > changing the output feels _very_ weird, as it breaks with a lot of
> > stuff that Just Works in the HTTP+HTML world even for users that view
> > it differently... like caching :-)
> 
> The problem with using CSS to select tabstop width is twofold. First,
> it has to work correctly also in text browsers like lynx, elinks, w3m.
> Second, it is tabstop size, not the width of tab character; I'm not
> sure if it is possible to implement it in CSS.

I do understand Martin's point, it does feel a little wrong performing
a styling action in the html generation but, as Jakub says, I don't
believe there is a good CSS solution to the problem.

My patch doesn't change this issue (expanding tabs in the html
generation), it just makes it a little more flexible.

From: Teemu Likonen <tlikonen@iki.fi>
Subject: --all-match
Date: Fri, 5 Sep 2008 15:35:24 +0300
Message-ID: <20080905123524.GA3124@mithlond.arda.local>
References: <g9o0ac$qig$1@ger.gmane.org> <7v4p4w75b7.fsf@gitster.siamese.dyndns.org> <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org> <20080904140902.GY10544@machine.or.cz> <7vy7271z9g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 14:37:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbaYd-00008K-TS
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 14:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbYIEMfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 08:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbYIEMfw
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 08:35:52 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:35992 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbYIEMfw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 08:35:52 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48B55E9A00787455; Fri, 5 Sep 2008 15:35:26 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KbaX6-0001s8-DI; Fri, 05 Sep 2008 15:35:24 +0300
Content-Disposition: inline
In-Reply-To: <7vy7271z9g.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95010>

Junio C Hamano wrote (2008-09-04 12:34 -0700):

> One related thing I suspect many people haven't realized is that "git
> log" can use "--all-match".

> I've been wondering if we want to make --all-match the default for
> revision traversal family (i.e. "git log"), as I suspect it would
> match people's expectations more naturally, even though it is
> a backward incompatible change.  It is backward incompatible only
> because the original implementation was stupid ;-).

You can count my vote for making --all-match the default, at least for
"git log". My logic says that adding more commit-limiting options to
command line would limit commits more.

Anyway, thanks for hint. I see --all-match is not a new feature (70d0afb
2006-09-27).

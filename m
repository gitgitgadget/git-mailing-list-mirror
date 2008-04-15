From: Bill Fink <billfink@mindspring.com>
Subject: Re: Reporting bugs and bisection
Date: Tue, 15 Apr 2008 01:25:33 -0400
Message-ID: <20080415012533.832db7ed.billfink@mindspring.com>
References: <20080413232441.e216a02c.akpm@linux-foundation.org>
	<20080414072328.GW9785@ZenIV.linux.org.uk>
	<20080414010412.c42dc560.akpm@linux-foundation.org>
	<20080414.013058.149905948.davem@davemloft.net>
	<878wzgwyyw.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org,
	viro@ZenIV.linux.org.uk, w@1wt.eu, david@lang.hm,
	sclark46@earthlink.net, johnpol@2ka.mipt.ru, rjw@sisk.pl,
	tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 07:27:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jldhk-0004Ch-Ff
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 07:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbYDOF0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 01:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbYDOF0f
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 01:26:35 -0400
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:50740 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753635AbYDOF0e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2008 01:26:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=mindspring.com;
  b=f1HHp2Jq1/VMA/hVSIzr74ZPRpW/jvo+hASEq6TvfCF3R0pqd6yWMZq7dGKG1MB9;
  h=Received:Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [68.48.212.104] (helo=gwiz.sci.gsfc.nasa.gov)
	by elasmtp-mealy.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <billfink@mindspring.com>)
	id 1Jldfm-0002Lr-4d; Tue, 15 Apr 2008 01:25:38 -0400
In-Reply-To: <878wzgwyyw.fsf@basil.nowhere.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; powerpc-yellowdog-linux-gnu)
X-ELNK-Trace: c598f748b88b6fd49c7f779228e2f6aeda0071232e20db4d3abc4c2fc79d9de2dba9bc6b49639829350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.48.212.104
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79568>

On Mon, 14 Apr 2008, Andi Kleen wrote:

> David Miller <davem@davemloft.net> writes:
> >
> > It's still largely free form, loose, and flexible. 
> 
> I think Al's point was that we need far more "free form, loose and
> flexible" work for reviewing code. As in people going over trees and
> just checking it for anything suspicious and going over existing code
> and checking it for anything suspicious and going also over mailing
> list patch posts. And also maintainers who appreciate such review.
> 
> And checking it for anything suspicious does not mean running
> only checkpatch.pl or even just sparse, but actually reading it
> and trying to make sense of it.

If you really want to get more such review, then it would be very
useful when someone asks about some obtuse portion of kernel code
or makes a suggested improvement, that the reviewer then not be
flamed as being dense for not understanding the code or some kernel
coding concept.  It would be much better to treat it as an oppurtunity
to educate rather than belittle, thus eventually enlarging the base
of people who can assist with various aspects of kernel development.
For what's supposed to be an open, engaging community, and which
generally is, there sometimes seems to be some level of dismissal
of newcomers (not sure it's intended that way but nevertheless it
can tend to discourage newcomers from getting more involved).

						-Bill

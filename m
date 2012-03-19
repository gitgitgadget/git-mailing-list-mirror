From: Andrew Sayers <andrew-20120318@pileofstuff.org>
Subject: Licensing a file format (was Re: SVN Branch Description Format)
Date: Mon, 19 Mar 2012 01:28:52 +0000
Message-ID: <4F668BD4.70808@pileofstuff.org>
References: <4F5C85A3.4080806@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Nathan Gray <n8gray@n8gray.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	semen.vadishev@tmatesoft.com
X-From: git-owner@vger.kernel.org Mon Mar 19 02:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9RPF-0006AL-7o
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 02:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab2CSB25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 21:28:57 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:4130 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756673Ab2CSB24 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2012 21:28:56 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120319012854.WRNT20752.mtaout02-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Mon, 19 Mar 2012 01:28:54 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120319012854.QFCA10211.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>;
          Mon, 19 Mar 2012 01:28:54 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <4F5C85A3.4080806@pileofstuff.org>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=Hx-evdmYQ-YA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=l_N1UNUtkD0-H8DcrHYA:9 a=PUoBO-0LQ-BK9Z9ZlGYA:7 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193407>

(CCing Semen Vadishev as I'd like to know if the SubGit project has any
opinion about this)

If you haven't been following the thread - this is a discussion of a new
format for describing SVN branching/merging/tagging behaviour.  Among
other things, this would let people plug different SVN exporters into
different Git importers.

I'd like advice/opinions from the community about licensing the
specification and reference implementation for this format, because it
seems like establishing an open standard is a bit different to promoting
open source.  I've always thought of copyleft as the tool I use to
promote sharing, but standards get more sharing by abandoning copyleft
and relying on the network effect - forking a standard makes your
product less valuable, unless you're not allowed to use the standard or
you have so much market share you don't have to care about standards in
the first place.

I'm planning to release the spec under a Creative Commons
Attribution-NoDerivs license (i.e. commercial use allowed, changes have
to go through me) and the reference implementation under an MIT license
(i.e. blatant theft of the exact recommended behaviour is encouraged).
This should minimise the barriers for people wanting to implement the
format as specified, and maximise the barriers for people wanting to
subvert the format.  The downside is that it makes life difficult for
everyone if I'm hit by a bus, and makes me less inclined to put some of
the more complex algorithms into the non-copyleft reference implementation.

Just to be clear, the format is one of three parts involved in getting
SVN branches/merges/tags into git.  I plan to release an SVN exporter
and git importer under the GPL, but expect to make a special case for
the format.

So the big question - would you be more inclined to use/contribute to
the SVN Branch Description Format if it had a different license?

	- Andrew

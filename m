From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 06:39:43 +0100
Message-ID: <20080414053943.GU9785@ZenIV.linux.org.uk>
References: <47FEADCB.7070104@rtr.ca> <20080413121831.d89dd424.akpm@linux-foundation.org> <20080413202118.GA29658@2ka.mipt.ru> <200804132233.50491.rjw@sisk.pl> <20080413205406.GA9190@2ka.mipt.ru> <48028830.6020703@earthlink.net> <alpine.DEB.1.10.0804131546370.9318@asgard> <20080414043939.GA6862@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tilman Schmidt <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	Mark Lord <lkml@rtr.ca>, David Miller <davem@davemloft.net>,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
X-From: netdev-owner@vger.kernel.org Mon Apr 14 07:41:27 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlHRX-0006fr-0F
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 07:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbYDNFkn (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 01:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbYDNFkn
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 01:40:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57557 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbYDNFkm (ORCPT
	<rfc822;netdev@vger.kernel.org>); Mon, 14 Apr 2008 01:40:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.63 #1 (Red Hat Linux))
	id 1JlHPr-0005Hf-LC; Mon, 14 Apr 2008 06:39:43 +0100
Content-Disposition: inline
In-Reply-To: <20080414043939.GA6862@1wt.eu>
User-Agent: Mutt/1.4.2.3i
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79459>

On Mon, Apr 14, 2008 at 06:39:39AM +0200, Willy Tarreau wrote:

[snip]

> I'm sure many people would find this useless (or in fact reject the
> idea because it would show that most code will be rated 1 or 2),
> but I really think it can help subsystem maintainers make the relation
> between a reported bug and a possible submitter.

I have a related proposal: let us require all patches to be stamped
with Discordian *and* Eternal September dates.  In triplicate.  While
we are at it, why don't we introduce new mandatory headers like, say
it,

X-checkpatch: {Yes,No}
X-checkpatch-why-not: <string>
X-pointless: <number from 1 to 69, going from "1: does something useful" all
the way to "68: aligns right ends of lines in comments">
X-arbitrary-rules-added-to-CodingStyle: <number> (should be present if
and only if X-pointless: 69 is present).

Come to think of that, we clearly need a new file in Documentation/*,
documenting such headers.  Why don't we organize a subcommittee^Wnew maillist
devoted to that?  That would provide another entry route for contributors,
lowering the overall entry barriers even further...


Seriously, looks like Andi is right - we've got ourselves a developing
beaurocracy.  As in "more and more ways of generating activity without
doing anything even remotely useful".  Complete with tendency to operate in
the ways that make sense only to beaurocracy in question and an ever-growing
set of bylaws...

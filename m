From: Arafangion <thestar@fussycoder.id.au>
Subject: Re: [PATCH] git-send-email: provide hook to send lines more than
	998 symbols
Date: Fri, 21 Nov 2008 22:09:02 +1100
Message-ID: <1227265742.3311.8.camel@therock.nsw.bigpond.net.au>
References: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com>
	 <1227263693.3311.0.camel@therock.nsw.bigpond.net.au>
	 <5ec8ebd50811210237kd6f9341q23bc69b6ffcc2a87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 11:59:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3TjV-0000y3-8S
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 11:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbYKUK6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 05:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbYKUK6O
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 05:58:14 -0500
Received: from nschwmtas06p.mx.bigpond.com ([61.9.189.152]:21100 "EHLO
	nschwmtas06p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752664AbYKUK6N (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2008 05:58:13 -0500
X-Greylist: delayed 167448 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Nov 2008 05:58:13 EST
Received: from nschwotgx01p.mx.bigpond.com ([58.173.132.215])
          by nschwmtas06p.mx.bigpond.com with ESMTP
          id <20081121105811.YJVZ1799.nschwmtas06p.mx.bigpond.com@nschwotgx01p.mx.bigpond.com>;
          Fri, 21 Nov 2008 10:58:11 +0000
Received: from therock.local ([58.173.132.215])
          by nschwotgx01p.mx.bigpond.com with ESMTP
          id <20081121105810.SWDH1935.nschwotgx01p.mx.bigpond.com@therock.local>;
          Fri, 21 Nov 2008 10:58:10 +0000
In-Reply-To: <5ec8ebd50811210237kd6f9341q23bc69b6ffcc2a87@mail.gmail.com>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150201.49269443.0016,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101511>

On Fri, 2008-11-21 at 12:37 +0200, Andy Shevchenko wrote:
> On Fri, Nov 21, 2008 at 12:34 PM, Arafangion <thestar@fussycoder.id.au> wrote:
> >> By default git-send-email does not accept patch which is contain lines longer
> >> than 998 symbols. Sometime it's inconvenient, i.e. you have a long list in one
<snip>
> > As a curiosity, why is such a check even neccessary?
> I'm not an author of that strange check (possible it's somehow related
> to b8ebe08b9a643f432866eb7150c3b20d59b755f2)

I can't seem to find that changeset, however the reason why I asked is
because I thought I remembered that some mail clients could crash if
they got lines longer than that, and we should cater for that even if
those clients should handle mails better than that!  Apparently it's
specified in the relevant RFC2822, and this particular solution has
already been contributed as:
https://kerneltrap.org/mailarchive/git/2008/1/18/579779

I would be inclined to suggest that such patches should be sent as an
attachment instead? (Though this may become bikeshed painting on my
part, see
http://www.freebsd.org/doc/en/articles/mailing-list-faq/bikeshed.html
for what I mean by the term).

While patches should be sent inline to encourage discussion of the
patch, if the patch has such insanely long lines, the probability that
the bulk of your audience in having a good email client that doesn't
mangle your patch may become rather low.

(I really should get some sleep, not good to be argumentative when
people are contributing very useful patches, like yourself!)

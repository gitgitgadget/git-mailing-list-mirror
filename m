From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: git-scm.com refresh
Date: Sat, 05 May 2012 10:14:45 +0100
Message-ID: <4FA4EF85.2060104@pileofstuff.org>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 11:15:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQb5W-0004oG-3H
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 11:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab2EEJPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 05:15:25 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:31117 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752283Ab2EEJOu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 05:14:50 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120505091447.FWWS28930.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sat, 5 May 2012 10:14:47 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120505091447.VWDP13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 5 May 2012 10:14:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=anyJmfQTAAAA:8 a=pQs5aej7AAAA:8 a=_ZrFaiNRv8H5CVQpXFoA:9 a=11tZuYlhhMmTRtz-yAcA:7 a=QEXdDO2ut3YA:10 a=HIp4U4vYru96kNrq:21 a=El2x7Xazz8ML0egN:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197101>

I had a poke round the site looking for trouble - here's what I found:

I'm using Linux, but for some reason the front page offers me downloads
for Mac.  When I click on "Mac GUIs", I am taken to a sensible URL for
Macs[1] but the button at the top says "Only show GUIs for my own OS
(Windows)".  I'm not sure how the detection works, but I have Javascript
disabled and the following user agent string:
Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko)
Chrome/17.0.963.56 Safari/535.11
Automatically guessing the user's OS is a good way of reducing interface
complexity, but for example the Firefox homepage[2] shows Windows, Linux
and Mac OS buttons if it can't guess.  This probably also helps Google
index their site, as GoogleBot can follow links to all the OS-specific
download pages.

The "about" section doesn't work in JS-disabled browsers - I always see
the "branching and merging" page no matter what I click on.  Again, this
means GoogleBot most likely won't index the other pages.

Not a bug, but a little tip - while investigating the issue on the
"about" page, I noticed that all the links had href="#".  You might want
to consider using href="#some-unique-identifier" so when you click round
the site with a JS-enabled browser and notice a "#" in the URL, you can
identify which click handler(s) failed.

Probably another non-JS browser issue, although not one that will bother
Google: the "book" section in the documentation page[3] has the first
"book cover" block protruding way into the left column, with all its
text mirrored.

Not a bug but a feature request: in the actual book pages, could you put
the prev/next links at the top as well as the bottom?  If I read through
the book, then come back a few weeks later looking for one of the pages,
it's much quicker to click through links at the top without needing to
scroll or move the mouse.

These bugs are relatively minor - the new site looks great overall.

	- Andrew

[1] http://git-scm.com/download/gui/mac
[2] http://www.mozilla.org/en-US/firefox/new/
[3] http://git-scm.com/documentation

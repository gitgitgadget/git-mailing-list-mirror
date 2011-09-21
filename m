From: Timothy Harper <timcharper@gmail.com>
Subject: Re: mac osx
Date: Wed, 21 Sep 2011 11:49:34 -0600
Message-ID: <3509B3CD-8E7E-4097-B7F1-F092E5CF08F5@gmail.com>
References: <loom.20110921T002437-246@post.gmane.org> <CAFcyEtiexmE0WMif-eGHe5xMoYv7-8mdXos1qbQBH3g04z0sAg@mail.gmail.com> <CAGdFq_h0VqbZ5W3QVwoQWT63znhpePDFCRE+-n1TqPNztREwkA@mail.gmail.com> <F4C226A7-768D-4913-A6C1-12411FBA212C@gmail.com> <CAP2yMaJz3-iX11vhbrTVasFD1zdwsdiDFKU7z7=an8pBoORk8w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Kyle Neath <kneath@gmail.com>,
	tom smitts <tomsmitts@ymail.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 19:56:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6R2L-00056a-Dm
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 19:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583Ab1IUR4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 13:56:39 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:58899 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab1IUR4i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 13:56:38 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Sep 2011 13:56:38 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp57.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 82AA5F8316;
	Wed, 21 Sep 2011 13:49:30 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp57.relay.iad1a.emailsrvr.com (Authenticated sender: tim-AT-leadtune.com) with ESMTPSA id 502F2F8303;
	Wed, 21 Sep 2011 13:49:29 -0400 (EDT)
In-Reply-To: <CAP2yMaJz3-iX11vhbrTVasFD1zdwsdiDFKU7z7=an8pBoORk8w@mail.gmail.com>
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181853>


On Sep 21, 2011, at 09:58, Scott Chacon wrote:

> Hey,
> 
> On Wed, Sep 21, 2011 at 5:52 AM, Timothy Harper <timcharper@gmail.com> wrote:
>>>> On Tue, Sep 20, 2011 at 3:40 PM, tom smitts <tomsmitts@ymail.com> wrote:
>>>>> Do the git maintainers really think any mac users have
>>>>>  a clue which git install package to download?  You
>>>>> put some arcane chipset designation in the package
>>>>>  name!
>> 
>> Good point, I'll update the description to include "32-bit" and "64-bit"
> 
> Honestly this doesn't help much.  I think the point is that these
> numbers or machs are not in any of the docs or ads I can think of for
> macs.  I feel pretty stupid admitting this to this list, but I
> honestly don't know which macs are 32 bit - I assume the MBP is 64,
> but if someone challenged me I'm not sure I could really defend it.

At one point, I had a universal binary release (both 32 and 64 bit instructions compiled). The trouble with it was it increased the file size by an additional 3-4 MB (going off memory). So I decided to only release 32 bit versions since they run everywhere, and only a very small fraction of people would care about 64 bit. Later, I had some requests for 64 bit, so I decided to do two separate builds, satisfying those who care about 64 bit while keeping the download size smaller. In almost a year of doing things this way, this is the first complaint I had about it.

> 
> Not that I'm the smartest guy in the world, but I have been using *NIX
> for a long damn time - it's just that Apple doesn't really use that as
> much of a selling point - it's not like the old days when nerds like
> us would buy the CPU at the store and it said "64-bit" on it - you buy
> a mac, maybe you know it's a Core Duo or i5/i7 but how are you
> supposed to know that means 64-bit?  I suppose a real geek would, and
> maybe I've fallen out of that category somehow, but honestly chipset
> has been so unimportant these days when compared to disk type and
> speed (SSD, etc), memory size, etc - I just don't follow the
> incremental improvements anymore.
> 
> Even I don't really keep up with the chipset specs to know - I can't
> imagine anyone using the dmg installer instead of brew would have the
> slightest idea what 64-bit even means.  And in our defense, the march
> is nowhere on this entire tech spec page for a MBP:
> 
> http://www.apple.com/macbookpro/specs.html
> 
> So maybe you care enough to see that the chipset is an i7, so you
> google it and end up on the intel i7 page:
> 
> http://www.intel.com/content/www/us/en/processors/core/core-i7-processor.html
> 
> Nope, no march there either.  I had to specifically find the wikipedia
> page for the processor which lists it:
> 
> http://en.wikipedia.org/wiki/Intel_Core#Core_i7
> 
> And 3/4 of the way down a huge page and only as a passing reference.
> 
> The point being - almost nobody that clicks on the DMG link from the
> git-scm website is going to know what bit architecture they're running
> on.

I'm willing to concede your point.

>> Kyle, I'll put 32-bit and 64-bit in the description. Somebody mentioned linking to the featured download list as well in that issue, that's a good recommendation.
> 
> I link to the featured downloads from git-scm.com front page as the
> huge mac icon - I assume that's where most people land when they're
> looking for a mac installer. And on that page you have "Leopard" and
> "Snow Leopard" on each download, which is WAY more common for people
> to know.  What I should probably do is have a dropdown thingy on
> git-scm that asks you what kind of mac you have and what OS you are
> running (whatever I can't get from the browser info) and just
> auto-download the right one so they never have to see the google
> downloads page.  That would, however, take Google having an api or me
> scraping that page, which I'll have to look into.

Ever since installing OS X Lion and Xcode 4.1 it seems I have lost the ability to build targeting Leopard (see /Developer/SDKs/), and haven't looked in to a work around. I have only built packages targeting the Snow Leopard.

I see two possible resolutions:

A) Tag builds as 32-bit and 64-bit. At git-scm.com (and github), link to the list that only shows 32-bit builds. For 99.9% (pulled-out-of-butt) of people using the installer, this will be just fine. For people who care about 64 bit, if they are motivated they can build own or find it.

B) Switch to universal architecture and cause everyone to suffer an addition 30% or so wait while downloading the installer.

What do y'all vote for?

Tim
From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: http://tech.slashdot.org/comments.pl?sid=1885890&cid=34358134
Date: Mon, 29 Nov 2010 11:27:44 -0800
Message-ID: <4CF3FEB0.9040806@eaglescrag.net>
References: <AANLkTinTsn4PP8VxJX=pUOYKtoybCxqB0+-p9kNRGMj8@mail.gmail.com>	 <AANLkTim0FeCE94R1zacOxGiEP8vZRSoDqNuNRUotnd9B@mail.gmail.com>	 <AANLkTima6meFsovFS-15X7CMTD53n=kkvueKrOeN4Yd4@mail.gmail.com>	 <AANLkTi=aCRGNtKxrPLH81H8_NvpBNOmJ-0MHgRms2a3T@mail.gmail.com> <1291025571.4262.21.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 20:26:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN9N2-0007KT-27
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 20:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab0K2T0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 14:26:35 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:44569 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab0K2T0e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 14:26:34 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oATJQVGA000745
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 29 Nov 2010 11:26:31 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.7
In-Reply-To: <1291025571.4262.21.camel@wpalmer.simply-domain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 29 Nov 2010 11:26:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162418>

> I want my version control software to use p2p concepts for efficiency. I
> don't want my version control software to be a p2p client any more than
> I want my text-editor to be a mail client.

Keep in mind that adding p2p concepts to something doesn't make it more
efficient, in fact in most cases it makes it dramatically *LESS* efficient.

git-torrent like concepts have come up in the past, and I keep pointing
out how and why they likely won't be useful.  The biggest reason: there
is no advantage for a client to stay in the cloud once they have their
data.  You can force this, sure, but clones are seldom and rare to begin
with (as you mentioned) so there won't be a very large cloud to pull
from to start with.  With that in mind, I really see no advantage to p2p
inside of the git core at all.  It adds a lot of complexity for little gain.

Now you do mention things that would be useful:

- Ability to resume a clone that you only have a partial download for
(maybe just pack files?)
- Ability to include something like a 'meta-link' like list of
repositories to check for data (inferred from the multiple download
locations)

There are things we can learn from p2p, but I don't think adding it to
git is actually useful.

Just my $0.02 though.

- John 'Warthog9' Hawley

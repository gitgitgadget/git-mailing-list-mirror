From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Wed, 02 Mar 2011 07:45:21 -0500
Message-ID: <1299069921.17973.26.camel@drew-northup.unet.maine.edu>
References: <20110225133056.GA1026@sigill.intra.peff.net>
	 <201102251658.22678.johan@herland.net>
	 <20110301215907.GA23945@sigill.intra.peff.net> <4D6DEB64.1080003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 13:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PulSW-0002dC-7Q
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 13:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638Ab1CBMrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 07:47:10 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:49718 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269Ab1CBMrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 07:47:09 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p22CjN5Q011832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 Mar 2011 07:45:28 -0500
In-Reply-To: <4D6DEB64.1080003@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=4
	Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p22CjN5Q011832
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299674743.00909@MVPf0axywtGRfBbPruJHhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168304>


On Wed, 2011-03-02 at 20:01 +1300, Chris Packham wrote:
> On 02/03/11 10:59, Jeff King wrote:
> > On Fri, Feb 25, 2011 at 04:58:22PM +0100, Johan Herland wrote:
> >> Maybe we should use a slightly more verbose separator (i.e. more 
> >> unlikely to trigger false positives). As you say, we already have to 
> >> watch out for "---" because of "am", but that only applies to projects 
> >> that _use_ "am" (i.e. mailing-list-centric projects like git.git and 
> >> the Linux kernel). Other projects (e.g. github-centric projects or most 
> >> centralized "$dayjob-style" projects) seldom or never use "am" at all, 
> >> so I wouldn't expect those developers think of "---" as "special" in 
> >> any way.
> >>
> >> What about using something like "--- Notes ---" instead?
> > 
> > Yeah, it is true that many git users will never care about the
> > patch-through-mail workflow. And I think these days that is OK, because
> > rebase will take care to keep their commit message intact even if it
> > doesn't format well in a "format-patch | am" pipeline.
> > 
> > I really wanted to keep it short and natural, though. Because eventually
> > I'd like to have this on all the time via a config option, and I don't
> > want to see "--- Notes ---" in every commit that doesn't have notes. But
> > I _do_ want to be able to quickly say "oh, let me make a note on this"
> > and just add a quick separator.
> 
> <bikesheding>
> What about "#---"? Satisfies the quick to type and is a lot less likely
> to appear in commit messages. Not sure about the implications of finding
> that string before the commit message is stripped.
> </bikesheding>


True enough, but that would be seen as a comment and dropped outright
the way things are currently standing. If you want short, definitely
rare, and most likely intentional you'd need something harder to
remember like "-!N" as the tag. I don't know how well that'd go over
with people--it definitely isn't natural.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59

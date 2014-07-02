From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Show containing branches in log?
Date: Wed, 2 Jul 2014 12:52:55 -0400
Organization: PD Inc
Message-ID: <6C120F968C534117BC278DD93D1F84A5@black>
References: <CAHd499A78BRVawWSHNnzJcD1Ca7RfFeEnJf0SB7py1MD5qwL0g@mail.gmail.com> <20140702163451.GB14404@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Robert Dailey'" <rcdailey.lists@gmail.com>,
	"'Jeff King'" <peff@peff.net>
To: "'Git'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 18:53:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2NmT-0002D7-7q
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 18:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584AbaGBQxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 12:53:05 -0400
Received: from mail.pdinc.us ([67.90.184.27]:34852 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091AbaGBQxD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 12:53:03 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s62GqtNd026045;
	Wed, 2 Jul 2014 12:52:55 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20140702163451.GB14404@sigill.intra.peff.net>
Thread-Index: Ac+WE5LkoKE3TPzzRNCTqA9knotozQAAE6NQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252796>

> -----Original Message-----
> From: Jeff King
> Sent: Wednesday, July 02, 2014 12:35
> 
> On Wed, Jul 02, 2014 at 09:50:57AM -0500, Robert Dailey wrote:
> 
> > I know that with the `git branch` command I can determine which
> > branches contain a commit. Is there a way to represent this
> > graphically with `git log`? Sometimes I just have a commit, 
> and I need
> > to find out what branch contains that commit. The reason why `git
> > branch --contains` doesn't solve this problem for me is 
> that it names
> > almost all branches because of merge commits. Too much ancestry has
> > been built since this commit, so there is no way to find 
> the "closest"
> > branch that contains that commit.
> > 
> > Is there a way to graphically see what is the "nearest" named ref to
> > the specified commit in the logs?
> 
> Have you tried "git describe --contains --all <commit>"?
> 
> To some degree, I fear your question isn't something git can 
> answer. If
> the branch containing the commit has been merged into other branches,
> then they all "contain" the commit. There is not really any reason to
> prefer one over the other ("describe --contains" will try to find the
> "closest" branch, but that is based on heuristics and is not 
> necessarily
> well-defined).

Another way I answer this question is git log --oneline --graph --all and then
search for the commit and follow the lines.


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 

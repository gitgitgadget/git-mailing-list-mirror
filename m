From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: RFC: Patch editing
Date: Wed, 28 Feb 2007 11:13:15 +0100
Message-ID: <20070228101315.GA18444@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702270205540.6485@iabervon.org> <Pine.LNX.4.63.0702271247000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702271201400.6485@iabervon.org> <Pine.LNX.4.63.0702272106150.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0702271651500.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 11:13:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMLoM-00063E-Ae
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 11:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbXB1KNY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Feb 2007 05:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbXB1KNY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 05:13:24 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2177 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbXB1KNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 05:13:23 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HMLoB-0004y1-00; Wed, 28 Feb 2007 10:13:15 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702271651500.6485@iabervon.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40913>

On 2007-02-27 17:07:11 -0500, Daniel Barkalow wrote:

> I think I usually come up with something like: 7 patches related to
> the functionality I'm working on, 1 patch that fixes an old bug that
> became important due to the change, and 2 patches which improve the
> debugging infrastructure. And the actual sequence of intermediate
> states that my code was in is something like: API written, stub
> implementations, some code that suggests what should happen; program
> calling the API and crashing; version that is written but buggy;
> version that's buggy but verbose; version that's working but
> verbose. In refining the work, I drop or "if (DEFINED_TO_0_DEBUG)"
> the messages, split out the patches that support the new kinds of
> messages, and include only working versions of functions. And then I
> write commit messages that talk about the code and sign them.
>
> Am I unusual in being afraid of losing work in a state that contains
> 3 different half-features?

My usual workflow looks like this too. I start out with a rough plan
of how to accomplish my goal with a number of smaller changes, but it
always turns out that I need more debug code, need to fix old bugs in
the middle of the process, need to fix silly bugs in earlier commits
in the series I'm building, and so on. I record this work with lots of
small commits. When I'm done, and usually at some intermediate stages
as well, I coalesce and reorder these commits to get a history
resembling my initial plan.

StGit is really helpful here. It doesn't actually do anything I
couldn't do manually with just git, but it makes it _simple_, and
tracks all the metadata for me so that I don't get a chance to make a
mess of things.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

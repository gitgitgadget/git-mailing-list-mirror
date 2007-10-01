From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn merge helper
Date: Mon, 1 Oct 2007 04:50:59 +0200
Message-ID: <20071001025059.GA29323@atjola.homenet>
References: <20070930110550.GA4557@atjola.homenet> <1EF130A4-3CC7-4A42-9166-3539D9A38828@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Oct 01 04:51:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcBNF-00059o-Eh
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 04:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbXJACu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Sep 2007 22:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbXJACu5
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 22:50:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:48271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750715AbXJACu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 22:50:56 -0400
Received: (qmail invoked by alias); 01 Oct 2007 02:50:54 -0000
Received: from i577B9F09.versanet.de (EHLO localhost) [87.123.159.9]
  by mail.gmx.net (mp010) with SMTP; 01 Oct 2007 04:50:54 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+G1otGRbSGRt2BIxt/jOwXeneC1rfM4J5x4tZkky
	KCwXgZpw3SkTVy
Content-Disposition: inline
In-Reply-To: <1EF130A4-3CC7-4A42-9166-3539D9A38828@lrde.epita.fr>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59579>

On 2007.09.30 16:15:49 +0200, Benoit SIGOURE wrote:
> On Sep 30, 2007, at 1:05 PM, Bj=F6rn Steinbrink wrote:
>
>> Hi,
>>
>> I recently discovered git-svn and absolutey love it. One thing that =
I'm
>> missing though, is an equivalent of "svn merge" for merging between =
svn
>> remotes, to support the SVN way of using "squashed" merges, where yo=
u
>> just note the merge meta-data in the commit message. "git merge" did=
n't
>> work for me (and probably isn't expected to work) to merge between t=
wo
>> svn branches, so I've resorted to cherry-picking the required commit=
s
>> one by one into a temporary branch and then squashing them together =
by
>> doing a --squash merge with a second temporary branch (as in [1]).
>
> I fail to see why you'd want to reproduce the broken behavior of svn =
merge.=20
>  Anyways, git-svn is a great way to merge SVN branches, unfortunately=
 it=20
> can't detect when merges happened on the SVN side.  I think you can u=
se it=20
> nevertheless by manually adding a graft at the last merge point, whic=
h=20
> would help you merging the right revisions without having to specify =
what=20
> needs to be merged (unless someone made another merge on the SVN side=
, in=20
> which case you need to update your graft).

Then how does that work? The manpage explicitly says that I should not
use git-{pull,merge} on branches I want to dcommit from. And a trivial
test immediately got the expected effect of git-svn trying to commit to
trunk instead of the branch.

Thanks,
Bj=F6rn

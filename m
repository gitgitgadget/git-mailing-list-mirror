From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: git-svn: both merged commits and original commits are showing up 
	in branches after migration
Date: Thu, 8 Jul 2010 23:33:18 -0400
Message-ID: <AANLkTilm-BGNsAmb2OwP7qsHl3GJmTCxn_2uGM-GJGGd@mail.gmail.com>
References: <AANLkTikwyFwO2G1E6rozSxrI4g51wyA8CFV5jl30qRo-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 05:33:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX4LF-000149-4z
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 05:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab0GIDdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 23:33:21 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39821 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab0GIDdU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 23:33:20 -0400
Received: by qyk35 with SMTP id 35so166778qyk.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 20:33:19 -0700 (PDT)
Received: by 10.224.66.153 with SMTP id n25mr3873233qai.130.1278646399184; 
	Thu, 08 Jul 2010 20:33:19 -0700 (PDT)
Received: by 10.229.38.133 with HTTP; Thu, 8 Jul 2010 20:33:18 -0700 (PDT)
In-Reply-To: <AANLkTikwyFwO2G1E6rozSxrI4g51wyA8CFV5jl30qRo-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150637>

Note: I could understand how the log could contain commits to the
trunk from *before* the branch was made, but not commits to the trunk
after the branch was made that were eventually merged into the branch
in a separate commit.

On Thu, Jul 8, 2010 at 10:58 PM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> I've done a migration using "git-svn init" and "git-svn fetch". After
> the migration, I did a "git log refs/remotes/svn/6.7" and found that
> it listed both the commits that I merged into the 6.7 branch and the
> original commits to the trunk/master even though the SVN history
> obviously only has what was merged into that branch. Any idea why the
> Git branch has both (see below)? I did notice that the merged commits
> seem to have extra metadata in the "Merge" property.
>
> Results of "git log /path/to/6.7":
>
> commit 6e18557b8f7e7173d26df7dd1857362c27eb3ab1
> Merge: e36cfba c8a400c
> Author: <author>
> Date: =A0 Fri Jun 25 21:00:19 2010 +0000
>
> =A0 =A0PROJ-6648 (Merged from Trunk): Updated the API version in buil=
d file
>
> =A0 =A0git-svn-id:
> file:///Users/Developers/git_transition/svn_repo/6.7@14254
> f4356f54-06d4-464e-91d3-36485834cb4b
>
> commit c8a400c3ef8ac113dd325382bedd073bfedc3dd1
> Author: <author>
> Date: =A0 Fri Jun 25 20:39:33 2010 +0000
>
> =A0 =A0PROJ-6648: Updated the API version in build file
>
> =A0 =A0git-svn-id:
> file:///Users/Developers/git_transition/svn_repo/trunk@14253
> f4356f54-06d4-464e-91d3-36485834cb4b
>
>
> commit 9b968ba82f6f850919c41702dc024703e5721b7e
> Merge: <author2>
> Author: Mike Strauch <mike.strauch@hannonhill.com>
> Date: =A0 Fri Jun 25 14:45:30 2010 +0000
>
> =A0 =A0PROJ-6819: (Merged from Trunk) Reverted changes from last comm=
it
> where initialize and teardown were called on each sftpshuttle
> invocation. =A0Now using a strategy where
>
> =A0 =A0git-svn-id:
> file:///Users/Developers/git_transition/svn_repo/6.7@14251
> f4356f54-06d4-464e-91d3-36485834cb4b
>
>
> commit c628db12ef8136cdf22749058e8d8682d0021b8b
> Author: <author2>
> Date: =A0 Thu Jun 24 20:10:53 2010 +0000
>
> =A0 =A0PROJ-6819: Reverted changes from last commit where initialize =
and
> teardown were called on each sftpshuttle invocation. =A0Now using a
> strategy where the retries counter
>
> =A0 =A0git-svn-id:
> file:///Users/Developers/git_transition/svn_repo/trunk@14240
> f4356f54-06d4-464e-91d3-36485834cb4b
>

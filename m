From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: git-svn: both merged commits and original commits are showing up 
	in branches after migration
Date: Mon, 12 Jul 2010 13:34:04 -0400
Message-ID: <AANLkTin3TYuC-y2U-o4NEgXH7N4M59vqWxXsa6J2Ae74@mail.gmail.com>
References: <AANLkTikwyFwO2G1E6rozSxrI4g51wyA8CFV5jl30qRo-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 12 19:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYMtT-0002eN-Np
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 19:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303Ab0GLReI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 13:34:08 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47646 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab0GLReH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 13:34:07 -0400
Received: by qyk38 with SMTP id 38so4486180qyk.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 10:34:05 -0700 (PDT)
Received: by 10.224.37.19 with SMTP id v19mr675290qad.15.1278956044750; Mon, 
	12 Jul 2010 10:34:04 -0700 (PDT)
Received: by 10.229.38.133 with HTTP; Mon, 12 Jul 2010 10:34:04 -0700 (PDT)
In-Reply-To: <AANLkTikwyFwO2G1E6rozSxrI4g51wyA8CFV5jl30qRo-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150832>

I'm getting ready to switch over to Git entirely and wanted to make
sure this was expected behavior. It appears to be based on the
presence of the "Merge" property but I'm still not exactly sure why
the original commit would show up in the branch history.

I asked the same question on StackOverflow:
http://stackoverflow.com/questions/3229024/git-commits-to-master-branch=
-showing-up-in-other-branches.

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



--=20
Hannon Hill - Put Us to the Test
bradley.wagner@hannonhill.com | http://www.hannonhill.com

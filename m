From: Pavel Roskin <proski@gnu.org>
Subject: Re: Navigating remote branches in qgit
Date: Sun, 04 Feb 2007 22:13:55 -0500
Message-ID: <1170645235.4191.26.camel@dv.roinet.com>
References: <1170574889.21644.38.camel@dv>
	 <e5bfff550702040300x60bb1dfdxd312dc214bc49014@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 04:14:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDuIy-0006sb-P8
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 04:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbXBEDOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 22:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752684AbXBEDOA
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 22:14:00 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:34211 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbXBEDN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 22:13:59 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDuHj-0005hr-Ov
	for git@vger.kernel.org; Sun, 04 Feb 2007 22:12:51 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDuIm-00063z-7N; Sun, 04 Feb 2007 22:13:56 -0500
In-Reply-To: <e5bfff550702040300x60bb1dfdxd312dc214bc49014@mail.gmail.com>
X-Mailer: Evolution 2.9.5 (2.9.5-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38723>

Hello, Marco!

Many many thanks for being such a great magician and granting my wishes
so quickly :)

On Sun, 2007-02-04 at 12:00 +0100, Marco Costalba wrote:
> After the posted two patches "refs/" is shown only in StGIT bases. Currently
> qgit uses 'git show-ref -d' to retrieve ref list and "ref/" prefix is
> already in git-show-ref output,
> so as a general rule I would try to avoid 'massaging' git output as
> much as is possible to have more chances thing do not break after a
> git behaviour change.

OK, I understand.  I feel quite ambivalent on this if we stop showing
StGIT bases.  They seem internal details of StGIT to me.

Generally, if qgit shows unrecognized refs, it's a sign that it needs to
be taught about them.  So indeed, massaging things we don't fully
understand would be bad.

Thanks for making the remote branches appear in a unique way, but I
think you used a darker color than gitk, so they seem even more
noticeable than the local branches.

I've made a patch that makes qgit use the same color as gitk.  It looks
much better to my eyes.

I think the popup menu for remote branches should have one more level of
hierarchy.  The branches should be grouped by remotes:

Remote branches -> wireless-2.6 -> master
                                   upstream
                   wireless-dev -> master
                                   for-linus

It may not be as quick to access, but jumping the branches is not going
to happen often.  It's more important to provide a good visualization.

Also, qgit seems to be confused on one of my repositories.  It doesn't
show any tags in the main menu and shows tags with branches under
"More".  I guess there are too many remote branches.  The tarball is in
http://www.red-bean.com/proski/qgit/

-- 
Regards,
Pavel Roskin

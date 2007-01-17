From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Wed, 17 Jan 2007 20:34:06 +0100
Message-ID: <20070117193406.GG9761@nan92-1-81-57-214-146.fbx.proxad.net>
References: <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com> <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <eojn5c$v9u$1@sea.gmane.org> <20070117090313.GA9283@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 20:34:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7GYD-000389-H0
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 20:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbXAQTeW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 14:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbXAQTeW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 14:34:22 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:40773 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932669AbXAQTeW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 14:34:22 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 7AA7143934;
	Wed, 17 Jan 2007 20:34:20 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 621681F073; Wed, 17 Jan 2007 20:34:06 +0100 (CET)
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Content-Disposition: inline
In-Reply-To: <20070117090313.GA9283@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37030>

On Wed, Jan 17, 2007 at 10:03:13AM +0100, Karl Hasselstr=F6m wrote:
> (BTW, I've never seriously tried git rebase; does anyone have an
> opinion of how convenient its conflict handling is, compared to
> stgit's?)

When I was using it, it was much less convenient than stgit - required
to forge a git-am command-line to continue after a conflict
(--continue was added in April '06 - I had switched to StGIT before
implementing it myself ;).  My evaluation at that point was that it
required too much understanding of the plumbing issues to be shown to
a newbie - a problem which StGIT does not have.  But I have not used
it any more since then, and did not follow any improvements in this
field.

StGIT features like "push --undo" also make it much easier to delay
merge of a given patch, and stack handling makes it easier to continue
your work after a night-break.  Not to mention all goodies like patch
reordering.

Best regards,
--=20
Yann.

From: Yann Dirson <ydirson@altern.org>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 22:27:31 +0100
Message-ID: <20070124212731.GE4083@nan92-1-81-57-214-146.fbx.proxad.net>
References: <17846.53626.895660.762096@lisa.zopyra.com> <Pine.LNX.4.64.0701231937310.3606@woody.linux-foundation.org> <20070124203913.GD4083@nan92-1-81-57-214-146.fbx.proxad.net> <ep8ght$dlf$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 22:29:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9pfM-0007mE-9q
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 22:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXAXV2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 Jan 2007 16:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbXAXV2U
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 16:28:20 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:40312 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbXAXV2U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 16:28:20 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BEF5F4AB1B;
	Wed, 24 Jan 2007 22:28:18 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 8EA501F07B; Wed, 24 Jan 2007 22:27:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ep8ght$dlf$3@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37682>

On Wed, Jan 24, 2007 at 09:46:49PM +0100, Jakub Narebski wrote:
> Yann Dirson wrote:
>=20
> > What was particular about this tree, is that we are several people
> > working on it, namely developpers taking care of the app, and me as
> > build manager taking care of the build mechanics as well as kernel+=
OS.
> > So the task was logically divided: one dev would merge the app, and=
 I
> > would merge everything else. =A0As you see, it's far from one-file
> > merges, but the problem is quite similar.
>=20
> This I think would be best handled by (future/prototype) submodules
> support.

That could be used for some cases, but it's harder to use to avoid
getting a Makefile merged with the rest of the subtree.


> I wonder if fake-recording resolutions in git-rerere would help
> in that case...

Hm.  Looks like that would require being able to communicate rerere
results from one workspace to another.

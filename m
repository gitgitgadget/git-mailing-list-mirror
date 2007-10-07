From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Better diagnostic for wrong branch configuration.
Date: Sun, 7 Oct 2007 15:14:17 +0200
Message-ID: <20071007131417.GA28492@diana.vm.bytemark.co.uk>
References: <20071005204452.30902.60246.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 15:14:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeVyA-0008HO-B4
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 15:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbXJGNOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 09:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbXJGNOo
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 09:14:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1025 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbXJGNOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 09:14:44 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IeVxZ-0007Pu-00; Sun, 07 Oct 2007 14:14:17 +0100
Content-Disposition: inline
In-Reply-To: <20071005204452.30902.60246.stgit@gandelf.nowhere.earth>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60176>

On 2007-10-05 22:44:52 +0200, Yann Dirson wrote:

> If the branch.*.merge parameter does not name a valid remote head,
> stgit would not rebase after a fetch, and would write instead
> 'Rebasing to "None" ... done'.
>
> This patch makes this situation an error and tells the user what to
> fix in his repo configuration.

Good. Sign-off?

> -                raise GitException, "StGit does not support multiple=
 FETCH_HEAD"
> +                raise GitException, 'StGit does not support multiple=
 FETCH_HEAD'

Unrelated quote fixup. No big deal, though.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

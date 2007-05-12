From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Document patch syntax.
Date: Sat, 12 May 2007 15:56:44 +0200
Message-ID: <20070512135644.GA28039@diana.vm.bytemark.co.uk>
References: <20070512120704.22970.45140.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat May 12 15:56:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hms5b-0002ex-Lk
	for gcvg-git@gmane.org; Sat, 12 May 2007 15:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbXELN4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 09:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754949AbXELN4r
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 09:56:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1654 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508AbXELN4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 09:56:46 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hms5U-0007LR-00; Sat, 12 May 2007 14:56:44 +0100
Content-Disposition: inline
In-Reply-To: <20070512120704.22970.45140.stgit@gandelf.nowhere.earth>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47046>

On 2007-05-12 14:07:04 +0200, Yann Dirson wrote:

> +Patches in the stack are identified with a short name, which must be
> +unique in the stack.

s/a short name/short names/, maybe.

> +Patches in the current stack are just refered to by their name.  Som=
e
> +commands allow to specify a patch in another stack of the repository=
;

s/allow to/allow you to/. Or "allows one to", but I prefer the second
person here.

> +this is done by suffixing the patch name with a '@' sign followed by=
 the
> +branch name (eg. 'thispatch@otherbranch').

s/a '@'/an '@'/; "'@'" begins with a vowel sound. :-)

> +A number of position in the stack related to the patch are also

s/position/positions/.

> +accessible through '//' suffixes.  For example, 'patch//top'' is
> +equivalent to 'patch', and 'patch//bottom' refers to the commit belo=
w
> +'patch' (ie. the patch below, or the stack base if this is the

s/ie./i.e./.

> +bottom-most patch).  Similarly ''//top.old'' and ''//bottom.old''

You use double quotes here, and single quotes above. What's the
distinction?

> +refer to the previous version of the patch (before the last
> +stglink:push[] or stglink:refresh[] operation).  When refering to th=
e

s/refering/referring/.

Otherwise,

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

Yes, I'm too picky.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

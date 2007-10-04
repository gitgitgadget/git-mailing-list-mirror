From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: editing description of patch
Date: Thu, 4 Oct 2007 17:48:36 +0200
Message-ID: <20071004154836.GB21717@diana.vm.bytemark.co.uk>
References: <9e4733910710031626kff59666y77ba9001c0fef907@mail.gmail.com> <9e4733910710031914r766efa88pad9f55f9495d127e@mail.gmail.com> <20071004082624.GA17778@diana.vm.bytemark.co.uk> <9e4733910710040616l5358099dj1b65b47cf94cf031@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 17:48:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdSwT-0005Hc-Ma
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 17:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545AbXJDPsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 11:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756464AbXJDPsl
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 11:48:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2827 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516AbXJDPsk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 11:48:40 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IdSwG-0005wb-00; Thu, 04 Oct 2007 16:48:36 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910710040616l5358099dj1b65b47cf94cf031@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59969>

On 2007-10-04 09:16:46 -0400, Jon Smirl wrote:

> Why is mailing a patch series so slow?

Because the default per-patch delay is 5 seconds. You can change it by
setting stgit.smtpdelay in your config, or passing --sleep on the
command line.

> There also seems to be a disconnect when mailing patches. Locally
> the patches have a name, when you email them it uses the short
> description for the name by default instead of the local name. This
> may cause confusion because the emailed name does not default to the
> local name. A parallel issue happens on import.
>
> Now that I am aware of the naming scheme I can deal with it, but
> this may be a problem for new users. It might be better to force the
> short description and local name to always match.

I've never thought of the patch names as anything that would make
sense to export from a repository (like reflogs), so using the first
line of the commit message for mail subject (like git does) always
seemed like a no-brainer. But then I don't have any experience using
quilt or any related tool.

The default when creating a new patch is to make up a name from its
commit message (the user is free to give a name explicitly, however);
the same goes when you import a patch mbox. But when importing a patch
series (with "stg import --series"), I see the names are taken from
the series file you import. Maybe that should change, at least
optionally.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

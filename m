From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: how to filter a pull
Date: Fri, 4 May 2007 12:13:29 +0200
Message-ID: <20070504101329.GA16446@diana.vm.bytemark.co.uk>
References: <20070503131704.GA7036@kernoel.kernoel.fr> <20070503150752.GB6500@xp.machine.xx> <7vwszpzs33.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org,
	marc.zonzon@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 12:13:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjunP-0005sO-HL
	for gcvg-git@gmane.org; Fri, 04 May 2007 12:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422910AbXEDKNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 May 2007 06:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422926AbXEDKNh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 06:13:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1491 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422910AbXEDKNh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 06:13:37 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hjun3-0004JF-00; Fri, 04 May 2007 11:13:29 +0100
Content-Disposition: inline
In-Reply-To: <7vwszpzs33.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46156>

On 2007-05-03 11:21:04 -0700, Junio C Hamano wrote:

> If I were doing this today, I would probably use separate
> repositories, next to the primary project, to host the whole tree of
> other projects, adjust the build procedure of the primary project to
> borrow the whole of these other projects not just subtree -- and/or
> have appropriate symlinks in the primary project that point into
> relevant subtrees in the neighbouring repositories that host these
> other projects.

It should be straightforward (and efficient) to make a script that
takes an existing branch and makes a parallel branch that contains
only one subtree of the first branch. This derived branch can then be
used as a subproject or whatever.

Or is there some obvious reason why this wouldn't work, or would be
inconvenient?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

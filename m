From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 09:37:38 +0200
Message-ID: <20070905073738.GA10570@diana.vm.bytemark.co.uk>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <46a038f90709050021o5cdcc976xd099242aeb70643d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 09:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISpST-0003a0-EA
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 09:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbXIEHhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 03:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbXIEHhr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 03:37:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4962 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbXIEHhr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 03:37:47 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1ISpSE-0002qi-00; Wed, 05 Sep 2007 08:37:38 +0100
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46a038f90709050021o5cdcc976xd099242aeb70643d@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57676>

On 2007-09-05 19:21:29 +1200, Martin Langhoff wrote:

> I never followed up on one of your suggestions back in the day --
> that we printed an informational msg along the lines of "you have X
> loose objects, it's about time to repack" after some operations
> (fetch, merge, commit).

git-gui pops up a dialog that says precisely that, and gives you the
choice of repacking right then and there, or skip it.

As for truly automatic repacking after commands such as fetch, it
could probably be a config option (defaulting to "on"). It'd be
important to have "press any key to abort repacking (with no ill
effects)" type funtctionality, though.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

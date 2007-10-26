From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit restrictions on patch names
Date: Fri, 26 Oct 2007 09:29:24 +0200
Message-ID: <20071026072924.GA11286@diana.vm.bytemark.co.uk>
References: <20071025194808.GV26436@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 09:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlJdu-0005Np-Qx
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 09:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbXJZH3w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2007 03:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbXJZH3w
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 03:29:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1236 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbXJZH3v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 03:29:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IlJdE-0002xT-00; Fri, 26 Oct 2007 08:29:24 +0100
Content-Disposition: inline
In-Reply-To: <20071025194808.GV26436@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62397>

On 2007-10-25 21:48:08 +0200, Yann Dirson wrote:

> Do we want to:
>
> - implement a mechanism for checking beforehand that the operation
> will not fail? Seems awkward to duplicate checks already found
> elsewhere.

Duplication is bad. Calling the same verification function more times
than necessary is still bad, but maybe not so bad that it wouldn't be
OK.

> - wait for proper transactions so we can rollback on error ?

Yes, this is what we should aim for. I'm working on code that'll
eventually give us this if it pans out.

> - on clone error, delete the newly-created stack ? I'd vote for this
> one, until the previous one gets done.

Seems reasonable.

> =3D> is there any particular reason why we would refuse "+" ?

Not that I can think of at the moment, except maybe future-proofing.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

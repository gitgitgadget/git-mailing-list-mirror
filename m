From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Wed, 16 May 2007 08:27:11 +0200
Message-ID: <20070516062711.GA7235@diana.vm.bytemark.co.uk>
References: <20070506150852.8985.98091.stgit@yoghurt> <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com> <20070515210801.GO19253@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0705151436g64e24a32r23c45c19f750082@mail.gmail.com> <20070515214952.GQ19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed May 16 08:29:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoD0S-0000Mi-L2
	for gcvg-git@gmane.org; Wed, 16 May 2007 08:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283AbXEPG2y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 May 2007 02:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756274AbXEPG2y
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 02:28:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3356 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332AbXEPG2y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 02:28:54 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HoCyd-0001uJ-00; Wed, 16 May 2007 07:27:11 +0100
Content-Disposition: inline
In-Reply-To: <20070515214952.GQ19253@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47415>

On 2007-05-15 23:49:52 +0200, Yann Dirson wrote:

> On Tue, May 15, 2007 at 10:36:05PM +0100, Catalin Marinas wrote:
>
> > I think it would be useful to have a version file (probably per
> > branch) and just upgrade when a mismatch is detected (in the
> > __init__ function).
>
> Sounds reasonable, but I'd rather keep that in the config file (eg.
> branch.<name>.stgit.formatversion).

I agree that explicit versioning would be a good idea -- doing
explicit upgrades at well-defined points is good headache prevention.

And I agree that the config file is a good place to put it.

I'll probably have time to whip up a patch later today. I think I'll
call the old "old" format 0, the old "new" format 1, and then use
successive integers from then on. I'll make a single version bump for
the format changes you've alreay applied, and re-do the
format-changing patches you haven't applied yet so that they have
version bumping integrated.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

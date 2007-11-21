From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Added test case for stg refresh
Date: Thu, 22 Nov 2007 00:15:53 +0100
Message-ID: <20071121231553.GA19422@diana.vm.bytemark.co.uk>
References: <87tznfvqb4.fsf@lysator.liu.se> <87oddnvpzf.fsf@virtutech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: David =?iso-8859-1?Q?K=E5gedal?= <david@virtutech.se>
X-From: git-owner@vger.kernel.org Thu Nov 22 00:16:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuynv-00046R-N8
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 00:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbXKUXQF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 18:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754557AbXKUXQE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 18:16:04 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4520 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbXKUXQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 18:16:03 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IuynR-0005MZ-00; Wed, 21 Nov 2007 23:15:53 +0000
Content-Disposition: inline
In-Reply-To: <87oddnvpzf.fsf@virtutech.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65712>

On 2007-11-21 11:43:00 +0100, David K=E5gedal wrote:

> David K=E5gedal <davidk@lysator.liu.se> writes:
>
> > This test case fails on the kha/experimental branch. Using "stg
> > refresh -p <patch>" can cause all sorts of wieirdness, and there
> > is no test case for it.
>
> I just checked, and it fails on kha/safe as well. So maybe there is
> some problem with the test case, but I don't know what it is.

Thanks, more tests are always welcome. But it doesn't fail for me.
I've just pushed out updated kha/safe and kha/experimental branches --
with this new test at the bottom of the stack -- and the whole test
suite passes at every step. Could you try the updated branches and see
if you can still make it fail?

> And maybe it should be called t2301 instead?

Those numbers are just one big jumble anyway, so no need to bother.
:-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

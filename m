From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Stgit and refresh-temp
Date: Wed, 12 Nov 2008 11:14:39 +0100
Message-ID: <20081112101439.GA27469@diana.vm.bytemark.co.uk>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com> <20081107054419.GA27146@diana.vm.bytemark.co.uk> <b0943d9e0811110959t4eb236bvd648fbca5e482911@mail.gmail.com> <20081112080103.GA25454@diana.vm.bytemark.co.uk> <b0943d9e0811120202wae88381j9fbc9f919b49dce5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 11:15:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ClS-0000XA-2m
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 11:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbYKLKOo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Nov 2008 05:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbYKLKOo
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 05:14:44 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4513 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbYKLKOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 05:14:43 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L0CkB-0007E0-00; Wed, 12 Nov 2008 10:14:39 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0811120202wae88381j9fbc9f919b49dce5@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100735>

On 2008-11-12 10:02:10 +0000, Catalin Marinas wrote:

> I think it's just a matter of updating HEAD on the "merge_conflict"
> path but I'm still not fully confident in modifying the new lib
> infrastructure.

You're probably right.

I'll do it, but you're welcome to beat me to it if you like; I promise
to read your patch extra carefully if you do.

(I'll drop you a mail when I start attacking this, to prevent any
duplicated work.)

> 2008/11/12 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > I'll build a test case for that as well.
>
> We test the conflicts quite a lot in the "push" tests but this
> command hasn't been converted to the new infrastructure yet.

Yes. As soon as we convert push and/or pop, this will be caught by the
test suite. But that just means the test suite needs extending ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

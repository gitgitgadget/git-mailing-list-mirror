From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Wed, 11 Jun 2008 21:14:08 +0200
Message-ID: <20080611191408.GB23670@diana.vm.bytemark.co.uk>
References: <484D78BF.6030504@gmail.com> <20080610063328.GB26965@diana.vm.bytemark.co.uk> <484E87B2.2090506@gmail.com> <20080611062753.GB15034@diana.vm.bytemark.co.uk> <48500B28.1050505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 21:15:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Vmr-0007P8-BW
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 21:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbYFKTOS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2008 15:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbYFKTOS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 15:14:18 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3977 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbYFKTOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 15:14:18 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K6Vlp-0006yz-00; Wed, 11 Jun 2008 20:14:09 +0100
Content-Disposition: inline
In-Reply-To: <48500B28.1050505@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84643>

On 2008-06-11 12:28:08 -0500, Clark Williams wrote:

> Seems it would just take a try/except block

Yes. The only trick here is to catch the specific type of exception
you want, and nothing else. You can easily try it out at an
interactive Python prompt and just see what type of exception is
thrown.

> with logic to make the patchname right (I still would want to remove
> a .gz/.bz2 suffix from the patchname).

Indeed. (And now that's a bit more work, since you'll want to ignore
capitalization -- and you can't be sure the suffix is actually there.)

> I'll make sure I have tests to go with the next patch.

Excellent!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

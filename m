From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Wed, 16 May 2007 09:11:30 +0200
Message-ID: <20070516071130.GB7453@diana.vm.bytemark.co.uk>
References: <20070506150852.8985.98091.stgit@yoghurt> <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com> <20070515182549.GB17851@diana.vm.bytemark.co.uk> <b0943d9e0705151301r7412109qd73a6008b888f8bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 09:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoDgF-0007JB-Vk
	for gcvg-git@gmane.org; Wed, 16 May 2007 09:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbXEPHLf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 May 2007 03:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754100AbXEPHLe
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 03:11:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1339 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbXEPHLe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 03:11:34 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HoDfX-00023s-00; Wed, 16 May 2007 08:11:31 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0705151301r7412109qd73a6008b888f8bc@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47424>

On 2007-05-15 21:01:43 +0100, Catalin Marinas wrote:

> What is the impact on the bash completion for calling StGIT rather
> than reading those files? Is it visible?

Yes, it's visible, but not annoying (to me anyway). The overhead is
akin to the overhead we used to have when "stg help" generated the
command names -- on the order of 100-200 ms, when StGIT is in the
cache. The expensive part is to start stgit; the git calls are cheap.
So theoretically the completion script could duplicate the logic in
StGIT and avoid most of the overhead, if someone wanted it badly
enough.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

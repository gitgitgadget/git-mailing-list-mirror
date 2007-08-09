From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: 'pu' branch for StGIT
Date: Thu, 9 Aug 2007 16:24:40 +0200
Message-ID: <20070809142440.GB6342@diana.vm.bytemark.co.uk>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk> <1186549433.2112.34.camel@dv> <20070808092027.GB7860@diana.vm.bytemark.co.uk> <20070808213917.GA22521@diana.vm.bytemark.co.uk> <1186611514.7383.4.camel@dv> <20070808232349.GA23172@diana.vm.bytemark.co.uk> <20070808201003.nm90u2s5ny888wcc@webmailbeta.spamcop.net> <20070809073801.GA31482@diana.vm.bytemark.co.uk> <1186665883.28228.31.camel@dv> <20070809141848.GA6342@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 16:24:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ8wX-0005b7-BA
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 16:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbXHIOYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 10:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937185AbXHIOYr
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 10:24:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1428 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936578AbXHIOYq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 10:24:46 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IJ8wK-0001oY-00; Thu, 09 Aug 2007 15:24:40 +0100
Content-Disposition: inline
In-Reply-To: <20070809141848.GA6342@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55454>

On 2007-08-09 16:18:48 +0200, Karl Hasselstr=F6m wrote:

> I saw the same problem today. I haven't had time to look into it,
> but I believe it's due to stgit trying to directly modify files
> under .git/refs instead of using git-update-ref, which breaks with
> packed refs. The DAG patches rely much more on the refs, so the bug
> is more severe in that case.

git-gc started packing refs by default in late May. That's probably
what's caused it to surface.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

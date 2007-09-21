From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 14:53:37 +0200
Message-ID: <20070921125337.GA28456@diana.vm.bytemark.co.uk>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com> <Pine.LNX.4.64.0709211208440.28395@racer.site> <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Peter Stahlir <peter.stahlir@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 14:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYi1B-0002BJ-79
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 14:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbXIUMxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Sep 2007 08:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbXIUMxz
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 08:53:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2034 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbXIUMxy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 08:53:54 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IYi0n-0007Qa-00; Fri, 21 Sep 2007 13:53:37 +0100
Content-Disposition: inline
In-Reply-To: <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58847>

On 2007-09-21 13:41:07 +0200, Peter Stahlir wrote:

> My motivation is whether it is possible to run a system, for example
> Debian on a computer on top of gitfs, and then have a huge mirror on
> it, for example a complete 252GB Debian mirror as space efficient as
> possible.
>
> I wonder how big a deltified Debian mirror in one pack file would
> be. :)

Very, very close to 252 GB, since .deb files are already compressed.

If it's just the gzip compression you want, surely there must be real
filesystems that can do that.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

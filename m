From: Petr Baudis <pasky@suse.cz>
Subject: Support for old Perl versions
Date: Sat, 31 May 2008 14:17:55 +0200
Message-ID: <20080531121755.GL593@machine.or.cz>
References: <20080530095047.GD18781@machine.or.cz> <1212179270-26170-1-git-send-email-LeWiemann@gmail.com> <20080530210531.GH18781@machine.or.cz> <7vd4n3iivt.fsf@gitster.siamese.dyndns.org> <86r6bjmpqc.fsf@blue.stonehenge.com> <484078C7.7020008@gmail.com> <alpine.DEB.1.00.0805311248050.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 31 14:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Q3L-0003um-Vv
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 14:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbYEaMR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 08:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbYEaMR7
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 08:17:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43840 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbYEaMR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 08:17:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 78DCC393B306; Sat, 31 May 2008 14:17:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805311248050.13507@racer.site.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83378>

  Hi,

On Sat, May 31, 2008 at 12:50:14PM +0100, Johannes Schindelin wrote:
> On Fri, 30 May 2008, Lea Wiemann wrote:
> 
> > I'm honestly not too keen on sacrificing time (or code prettiness) on 
> > 5.6 compatibility, so if there are no reasons besides the memory leak to 
> > move away from throw/catch, perhaps we can just keep using it?
> 
> I think your opinion would change dramatically if you were stuck on a 
> platform with Perl 5.6.  In general, I deem it not nice to sacrifice 
> backwards compatibility just because _you_ do not need it.

  let's get some perspective here: 5.6.1 was released on 2001-Apr-08.
5.8.0 followed on 2002-Jul-18.  Is there anyone on the list who _is_
stuck on a platform with Perl 5.6 _and_ uses Git on it? Heck, we
are even approaching GNU Interactive Tools 4.3.20 release here,
walking that much back.

  Of course, there's no sense in arbitrarily requiring newer Perl
versions until we know we are not compatible anymore, but frankly,
I don't think wasting time on being compatible with 5.6 is worth it
either unless its actual users speak up.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe

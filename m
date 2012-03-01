From: solo-git@goeswhere.com
Subject: Re: Running git on ARM systems
Date: Thu, 1 Mar 2012 11:12:19 +0000
Message-ID: <20120301111219.GA1379@goeswhere.com>
References: <CAH5451=ngnGxpSd4+8xg1PwTSPOJ0napS+Y9KNVE_82a+n+GQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 12:20:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S343T-0002iz-Ef
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 12:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545Ab2CALUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 06:20:08 -0500
Received: from fau.xxx ([78.47.200.108]:46884 "EHLO reg.goeswhere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888Ab2CALUH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 06:20:07 -0500
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Mar 2012 06:20:07 EST
Received: by reg.goeswhere.com (Postfix, from userid 1000)
	id 82AE32E1C51; Thu,  1 Mar 2012 11:12:19 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAH5451=ngnGxpSd4+8xg1PwTSPOJ0napS+Y9KNVE_82a+n+GQQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191915>

On Thu, Mar 01, 2012 at 04:11:16PM +1100, Andrew Ardill wrote:
> Hi everyone,
> 
> You may have heard of the Raspberry Pi [1], a fully programmable
> computer the size of a credit card for $25-$35. It will run a linux
> (debian/fedora/arch) distribution on a 700 MHz ARM1176JZF-S core
> (ARM11 family) [2].

Then there's things like the Nokia n900 / n950 devices; 'phones with
Maemo (~= Debian) on them.  I've been using the git-core (installed via.
apt-get) on my n900 for backups and lightweight development for ages.

The main problem is the IO, in my experience, the device has 256MB of ram,
but only SD-card grade storage (like the Rasberry).

ARMv7, according to /proc/cpuinfo.

Package: http://maemo.org/packages/view/git-core/

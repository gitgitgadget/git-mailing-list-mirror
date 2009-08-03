From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: From P4 to Git
Date: Mon, 3 Aug 2009 23:51:37 +0200
Message-ID: <20090803215137.GC3759@blimp.localdomain>
References: <85ljm84lat.fsf@oqube.com> <m3fxcg3473.fsf@localhost.localdomain> <85r5vxbd8e.fsf@oqube.com> <200907311122.43918.jnareb@gmail.com> <81b0412b0907310414x7157fecey947da960ff8be1cc@mail.gmail.com> <4A76967B.7080502@vilain.net> <81b0412b0908030147i34a7440dg982c7a6e7dc51bca@mail.gmail.com> <1249299010.7164.8.camel@maia.lan> <81b0412b0908030650oc39f4a3s7c059e300b65addb@mail.gmail.com> <1249331540.12801.10.camel@maia.lan>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Arnaud Bailly <abailly@oqube.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:51:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY5Rh-00081W-JK
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 23:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbZHCVvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 17:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754796AbZHCVvn
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 17:51:43 -0400
Received: from mout0.freenet.de ([195.4.92.90]:37449 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782AbZHCVvm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 17:51:42 -0400
Received: from [195.4.92.25] (helo=15.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #92)
	id 1MY5RV-0005SC-9W; Mon, 03 Aug 2009 23:51:41 +0200
Received: from x49cd.x.pppool.de ([89.59.73.205]:53252 helo=tigra.home)
	by 15.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #93)
	id 1MY5RV-0002J7-1c; Mon, 03 Aug 2009 23:51:41 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id F2C0C277D8;
	Mon,  3 Aug 2009 23:51:37 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id B2A4B36D28; Mon,  3 Aug 2009 23:51:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249331540.12801.10.camel@maia.lan>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-purgate-ID: 149285::1249336301-00006BAA-AE609A01/0-0/0-0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124724>

Sam Vilain, Mon, Aug 03, 2009 22:32:20 +0200:
> On Mon, 2009-08-03 at 15:50 +0200, Alex Riesen wrote:
> > "varios options"? Operations? As when working on a live server?
> > Aren't P4 changelist numbers always increasing? Or you mean
> > the protection against multiple running instances of p4raw,
> > so it is also parallelizable?
> 
> The "live" parts are never touched - only the write-only files that
> perforce writes; and the rcs files are read using rcs.

I always felt Perforce had a touch of pure evil...

> All you need is the RCS backing files, a 'checkpoint' and (optionally)
> 'journal' files.  No access to the live perforce DBs is required.

Which in my case is all the same. I don't dare to ask, frankly.

> > That's were I hoped your project could help. I thought, if I pull in all the
> > needed changelists (selected by path/CL), there may be a way to
> > recreate a mergeable history out of this dump. At least, one involving less
> > labor then I have to do now.
> 
> Yeah... well the design of my tool is that it needs to have the perforce
> internal information.  But really you can probably consider the
> converter orphaned, I have no current need to work on it; it served a
> purpose, which was converting perl's perforce to perl.git, and that's
> history now.

Thanks anyway for bringing it to public attention. At least, it is
known to be done once. Could be an encouragement for next one to try.
A guide, even.

From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] gitweb: Adding a `blame' interface.
Date: Mon, 12 Jun 2006 16:29:30 -0500
Message-ID: <1150147770.23938.373.camel@cashmere.sps.mot.com>
References: <11500407193506-git-send-email-octo@verplant.org>
	 <46a038f90606111502g607be3cfnf83ce81764a5f909@mail.gmail.com>
	 <20060612082448.GA11857@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 23:34:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpu2v-0002eR-6F
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 23:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWFLVeB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 17:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWFLVeB
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 17:34:01 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:39835 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932375AbWFLVeA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 17:34:00 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k5CLoog3013391;
	Mon, 12 Jun 2006 14:50:50 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k5CLXrZL000949;
	Mon, 12 Jun 2006 16:33:54 -0500 (CDT)
To: Florian Forster <octo@verplant.org>
In-Reply-To: <20060612082448.GA11857@verplant.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21742>

On Mon, 2006-06-12 at 03:24, Florian Forster wrote:

> I have two more points regarding gitweb's configuration:
> - IMHO it would make sense to move the general gitweb-configuration
>   (where are the repositories, where are the binaries, etc) out of the
>   script.  As far as I know the Debian maintainer of the `gitweb'
>   package has asked for this before but was refused for some reason..
>   Possibly a file `gitweb.conf' in the same directory as the script
>   could be read and overwrite the builtin defaults..?

I already submitted a patch down this line on 22-Mar-2006:

    http://marc.theaimsgroup.com/?l=git&m=114308224922372&w=2

Thanks,
jdl

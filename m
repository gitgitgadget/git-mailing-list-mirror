From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: how to filter a pull
Date: Thu, 3 May 2007 22:37:19 +0200
Message-ID: <20070503203719.GA2755@steel.home>
References: <20070503131704.GA7036@kernoel.kernoel.fr> <20070503150752.GB6500@xp.machine.xx> <7vwszpzs33.fsf@assigned-by-dhcp.cox.net> <71295b5a0705031232l3dc6a61dh7c0d7f993536fab7@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: marc zonzon <marc.zonzon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 22:37:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hji3L-0004VV-8d
	for gcvg-git@gmane.org; Thu, 03 May 2007 22:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766616AbXECUhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 16:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766517AbXECUhX
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 16:37:23 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:55820 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766493AbXECUhW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 16:37:22 -0400
Received: from tigra.home ([195.4.200.160] [195.4.200.160])
	by post.webmailer.de (mrclete mo30) (RZmta 5.8)
	with ESMTP id 904ae1j43GFlk7 ; Thu, 3 May 2007 22:37:20 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C1676277BD;
	Thu,  3 May 2007 22:37:19 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5B2BBD171; Thu,  3 May 2007 22:37:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <71295b5a0705031232l3dc6a61dh7c0d7f993536fab7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ZBY8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46105>

marc zonzon, Thu, May 03, 2007 21:32:52 +0200:
> I need in my packages to produce rc scripts and udev conf, hotplug
> scripts. They depends of the base rc functions of openwrt (int etc),
> the config system (in lib/config), and the hotplug scripts
> (/etc/hotplug.d), and I need to patch some of these scripts.
> I would like to stay in sync with the development of openwrt, the
> change in the patched files are quite frequent but usualy merge
> easily. Of course this is only one part of my dependencies, the main
> tree that is imported in my project is the original package that I
> modify to tailor it to openwrt.

It looks like you need neither subproject nor partial checkouts
(another Git-specific feature which is just about to come into
existence). Just manage everything in one repo. Git deals with large,
big and even huge repos splendidly. It's the monstrous repos which
still make problems, but people working on them.

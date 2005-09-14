From: Jon Loeliger <jdl@freescale.com>
Subject: Re: dumb transports not being welcomed..
Date: Wed, 14 Sep 2005 09:10:16 -0500
Message-ID: <1126707016.14036.14.camel@cashmere.sps.mot.com>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
	 <20050913211444.GA27029@mars.ravnborg.org>
	 <7vacig1wrb.fsf@assigned-by-dhcp.cox.net>
	 <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sam Ravnborg <sam@ravnborg.org>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 16:14:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFXyM-0002fN-Ns
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 16:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVINOKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 10:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbVINOKk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 10:10:40 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:17551 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S965157AbVINOKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 10:10:40 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id j8EEHxar006612;
	Wed, 14 Sep 2005 07:17:59 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j8EEEojr011290;
	Wed, 14 Sep 2005 09:14:51 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8525>

On Tue, 2005-09-13 at 17:11, Junio C Hamano wrote:

> I just felt that it is a good habit to get into to prepare your
> repositories in a shape usable even when served by an HTTP
> server that is less forgiving than what kernel.org runs -- that
> was what I felt "discouraging" about.

Well, that is sort of just it, too.  Why not make the
default, obvious, common repo prep mechanism do all
the necessary steps for proper presentation?  Having
to remember to do 6 steps just begs for an additional
layer of scripting.

>   This means either people are
> not packing their repository (hence nobody complained), or
> public are pulling over rsync transport (which slurps everything
> in sight).  Both are good reasons to feel discouraged about.

I confess, I've been using rsync as it is what appears
to be able to reliably get a repository that works.

jdl

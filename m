From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Safe way to remove .temp objects?
Date: Fri, 27 Jan 2006 11:14:33 +0100
Organization: Harddisk-recovery.com
Message-ID: <20060127101433.GB3673@harddisk-recovery.com>
References: <20060126093507.GA5118@harddisk-recovery.nl> <43D8AFF1.2080106@op5.se> <7v1wyvfa8p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 11:14:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2Qcr-0001aQ-Ir
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 11:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWA0KOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jan 2006 05:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWA0KOi
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jan 2006 05:14:38 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:40803 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932457AbWA0KOh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2006 05:14:37 -0500
Received: (qmail 11554 invoked by uid 501); 27 Jan 2006 11:14:33 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wyvfa8p.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15179>

On Thu, Jan 26, 2006 at 04:24:06AM -0800, Junio C Hamano wrote:
> What is being asked is not about loose objects but droppings
> commit walkers make when interrupted.

That's indeed what I meant.

> I think *.temp files are garbage and you can safely remove
> them.  They are not even correct objects.

It looks like it was safe to remove, all git commands I tried just
work.


Thanks,

Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

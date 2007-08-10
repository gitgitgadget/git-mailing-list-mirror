From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 12:51:43 +0200
Message-ID: <3351C69E-C0A8-4D02-9E04-085E18F1DF75@zib.de>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de> <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de> <20070810053158.GJ24573@spearce.org> <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de> <Pine.LNX.4.64.0708101113380.21857@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 12:51:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJS5K-0000E8-Bb
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 12:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbXHJKvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 06:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759103AbXHJKvE
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 06:51:04 -0400
Received: from mailer.zib.de ([130.73.108.11]:64317 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417AbXHJKvD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 06:51:03 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7AAosvv002287;
	Fri, 10 Aug 2007 12:50:58 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7AAosTM006478
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 10 Aug 2007 12:50:54 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0708101113380.21857@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55528>


On Aug 10, 2007, at 12:16 PM, Johannes Schindelin wrote:

> Hi,
>
> On Fri, 10 Aug 2007, Steffen Prohaska wrote:
>
>> I recognized that '.' is included in the PATH in /etc/profile.
>> I don't think this is a good idea. At least it bit me once when
>> I expected to run /bin/git but instead /git/./git was chosen.
>> Shouldn't we remove '.' from the PATH?
>
> In my experience, Windows users (not Mac users forced to use Windows)
> _expect_ "." to be in the PATH.

Ah, what a crazy and dangerous world Windows is ;)

> Regarding the tclsh thing:  IMHO to unwaste space, we should add a
>
> 	#!/bin/sh
> 	exec tclsh84 "$@"
>
> instead.  MinGW does not have symlinks, and we should not put more  
> space
> to waste than Windows does already, by copying files around (yes, the
> repository will not care, but the working tree will).

I agree and pushed the following to mob

faeb4e3df9fb7c853dd1a46d6942776d4a743545

I forced a non-fast-forward of mob. Is this ok? Apparently it's allowed.


Another question related to mob. How do I need to setup /git/.git/config
to be able to push to git's mob?

ssh://mob@repo.or.cz/srv/git/mingw/4msysgit.git

doesn't work for me.

Could the installer setup the mob branches? Or is this too dangerous?
At least it would help new developers to get going. It took me some time
to find the right setup for mob of msysgit and I was not able to set it
up for git. And I heard about the mob concept already before.

	Steffen

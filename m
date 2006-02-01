From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: git-unadd anyone?
Date: Wed, 1 Feb 2006 16:38:23 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060201153823.GB16461@informatik.uni-freiburg.de>
References: <43E0D469.1030404@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 01 16:40:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4K3w-0008PE-DU
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 16:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbWBAPi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 10:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWBAPi0
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 10:38:26 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:64956 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1161094AbWBAPiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 10:38:25 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F4K3r-0007Qm-Vu
	for git@vger.kernel.org; Wed, 01 Feb 2006 16:38:24 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k11FcNTa016946
	for <git@vger.kernel.org>; Wed, 1 Feb 2006 16:38:23 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k11FcNTW016945
	for git@vger.kernel.org; Wed, 1 Feb 2006 16:38:23 +0100 (MET)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <43E0D469.1030404@gorzow.mm.pl>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15420>

Hello Radoslaw,

Radoslaw Szkodzinski wrote:
> Is there an easy way to just unmark files wrongly marked as added?
> 
> I'm not thinking about something like git-reset --mixed,
> which would discard the index as a whole.
> I only want to unmark files I git-add(1)ed.
How about

	git update-index --force-remove <filename>


Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=5+choose+3

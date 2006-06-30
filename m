From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 20:20:09 +0200
Message-ID: <E1FwNb7-0000BL-Ad@moooo.ath.cx>
References: <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net> <E1FwDiI-0007Xp-2s@moooo.ath.cx> <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net> <E1FwGgm-0006Nc-9a@moooo.ath.cx> <7vejx6k54p.fsf@assigned-by-dhcp.cox.net> <E1FwMPf-0005XA-N9@moooo.ath.cx> <7vpsgqimu7.fsf@assigned-by-dhcp.cox.net> <e83n97$973$1@sea.gmane.org> <E1FwN7M-0007GI-Ng@moooo.ath.cx> <7vfyhmil07.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 30 20:20:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwNbJ-0002pq-Iw
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 20:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932996AbWF3SUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 14:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbWF3SUR
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 14:20:17 -0400
Received: from moooo.ath.cx ([85.116.203.178]:28625 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932996AbWF3SUP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 14:20:15 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <7vfyhmil07.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23010>

Junio C Hamano wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> 
> > -e foo --or  --near \( -e A -- or -e B \)
> > would mean lines containing foo or having A or B in the context.
> 
> How would that "--near" be useful?  You will see A or B either way.
Ok, this example was quite bad.

If --near is binary
-e foo --and ( --near=3:0 -e A --or --near=0:3 -e B )
could not be done anymore, could it (without repeating the first
pattern)? (Find foo with A in the 3 lines before or B in the 3 lines
after the line.)
Without different contexts for multiple --near it probably does not
matter if --near is binary or unary.

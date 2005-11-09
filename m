From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/4] Add git-pack-intersect
Date: Wed, 9 Nov 2005 12:19:17 +0100
Message-ID: <20051109111917.GB30496@pasky.or.cz>
References: <43714EFB.5070705@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 09 12:20:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZnz9-0003ey-9S
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 12:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVKILTU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 9 Nov 2005 06:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVKILTU
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 06:19:20 -0500
Received: from w241.dkm.cz ([62.24.88.241]:58754 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751373AbVKILTU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 06:19:20 -0500
Received: (qmail 6111 invoked by uid 2001); 9 Nov 2005 12:19:17 +0100
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <43714EFB.5070705@etek.chalmers.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11394>

Dear diary, on Wed, Nov 09, 2005 at 02:20:59AM CET, I got a letter
where Lukas Sandstr=F6m <lukass@etek.chalmers.se> said that...
> This patch series adds git-pack-intersect. It finds redundant packs
> by calculating the union of all objects present in .git/objects/pack
> and then computing the smallest set of packs which contain all the
> objects in this union.

Sounds nice, except the name - it does something else than what the nam=
e
says, so perhaps something like 'git-pack-redundant' would be more
appropriate.

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.

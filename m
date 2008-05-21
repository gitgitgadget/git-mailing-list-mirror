From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Tue, 20 May 2008 22:41:26 -0400
Message-ID: <20080521024126.GI29038@spearce.org>
References: <48301B17.30309@dirk.my1.cc> <20080519022125.GV29038@spearce.org> <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org> <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com> <20080520201722.GF29038@spearce.org> <bd6139dc0805201322r6c8dae8cy45d31af6c25fd25a@mail.gmail.com> <20080520203153.GH29038@spearce.org> <7v3aoc8xtg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sverre@rabbelier.nl,
	Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 04:42:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyeHa-0003Ux-Jb
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 04:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758128AbYEUClf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 22:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757537AbYEUClf
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 22:41:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38011 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297AbYEUCle (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 22:41:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JyeGT-0000Fc-3V; Tue, 20 May 2008 22:41:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DA8AF20FBAE; Tue, 20 May 2008 22:41:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v3aoc8xtg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82519>

Junio C Hamano <gitster@pobox.com> wrote:
> > Sverre Rabbelier <alturin@gmail.com> wrote:
> >> 
> >> Ah, I didn't realise git-gui does stuff that you can't really do
> >> through the regular porcelain. In that case it would indeed be
> >> impossible to print the regular porcelain commands. I think the
> >> '--trace' option should be advertised as 'debugging option' so that
> >> the user can see what is going on in the case something goes wrong
> >> perhaps?
> 
> Probably --trace should be renamed to --debug then?

Well, we do have GIT_TRACE, and git-gui --trace is sort of the
same idea.  :-)

I was going to call it --debug, but went with --trace as it is
closer to GIT_TRACE than it is to say git-describe --debug.

-- 
Shawn.

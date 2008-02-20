From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
	local branches
Date: Wed, 20 Feb 2008 01:13:39 +0100
Message-ID: <20080220001339.GA16574@steel.home>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com> <20080219074423.GA3982@steel.home> <76718490802190549p549a34afo913efefebaf5fa97@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 01:14:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRcbM-0003J4-He
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 01:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbYBTANp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 19:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbYBTANp
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 19:13:45 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:36665 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYBTANo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 19:13:44 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClWJug==
Received: from tigra.home (Fad34.f.strato-dslnet.de [195.4.173.52])
	by post.webmailer.de (mrclete mo50) (RZmta 16.5)
	with ESMTP id z00313k1JKcDfH ; Wed, 20 Feb 2008 01:13:42 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 21620277BD;
	Wed, 20 Feb 2008 01:13:40 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 70FE956D24; Wed, 20 Feb 2008 01:13:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <76718490802190549p549a34afo913efefebaf5fa97@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74483>

Jay Soffian, Tue, Feb 19, 2008 14:49:17 +0100:
> On Feb 19, 2008 2:44 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> > Jay Soffian, Tue, Feb 19, 2008 03:07:12 +0100:
> > > +enum branch_track {
> > > +     BRANCH_TRACK_NEVER = 0,
> >
> > enums start at 0 anyway, don't they?
> 
> I don't know, but guys, give me a break on the enums already. What's
> the preferred syntax already because the existing code is not
> consistent:

Well, it could also mean that there is no rules yet, and you can
do the next sane thing of your choice.

> enum color_branch {
> 	COLOR_BRANCH_RESET = 0,
> 	COLOR_BRANCH_PLAIN = 1,
> 	COLOR_BRANCH_REMOTE = 2,
> 	COLOR_BRANCH_LOCAL = 3,
> 	COLOR_BRANCH_CURRENT = 4,
> };
>
> enum {
> 	TAGS_UNSET = 0,
> 	TAGS_DEFAULT = 1,
> 	TAGS_SET = 2
> };

Which is just as useless. It is not useful even for documentation,
as the verbatim values are not used anywere else (i.e. they are not
a part of file format, where they could stand out as the numbers
listed).

It looks like someone was just too paranoid or suffered a mental
damage from too long exposure to proprietary code.

> enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
> 
> enum exist_status {
> 	index_nonexistent = 0,
> 	index_directory,
> 	index_gitdir,
> };
> 
> enum CAPABILITY {
> 	NOLOGIN = 0,
> 	UIDPLUS,
> 	LITERALPLUS,
> 	NAMESPACE,
> };

All the same...

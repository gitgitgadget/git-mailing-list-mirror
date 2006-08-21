From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] branch as a builtin (again)
Date: Mon, 21 Aug 2006 04:03:45 -0400
Message-ID: <20060821080345.GA26191@spearce.org>
References: <59ad55d30608201422h4a6d40f7y7782212637380438@mail.gmail.com> <Pine.LNX.4.63.0608210045450.17336@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 10:04:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF4lV-00077r-QW
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 10:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWHUIEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 Aug 2006 04:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWHUIEE
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 04:04:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:20096 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030320AbWHUIEB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 04:04:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GF4lJ-0004tH-4F; Mon, 21 Aug 2006 04:03:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0752D20FB7D; Mon, 21 Aug 2006 04:03:45 -0400 (EDT)
To: hoegsberg@gmail.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608210045450.17336@chino.corp.google.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25787>

> On Sun, 20 Aug 2006, Kristian H=F8gsberg wrote:
> > diff --git a/builtin-branch.c b/builtin-branch.c
> > +static const char builtin_branch_usage[] =3D
> > +    "git-branch [(-d | -D) <branchname>] | [[-f] <branchname> [<st=
art-point>]] | -r";

What happened to the -l switch to create a reflog for the new branch?

> > +static void delete_branches(int argc, const char **argv, int force=
)

What happened to deleting the reflog when the branch gets deleted?


In both cases please see the existing git-branch documentation and
shell script.

I applaud the effort of removing some of these smaller shell scripts
with more portable C code but at the same time I'd hate to see a
loss of functionality, especially something that I use!  :-)

--=20
Shawn.

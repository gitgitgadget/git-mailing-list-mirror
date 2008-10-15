From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: [PATCH] doc: enhance git describe --tags help
Date: Wed, 15 Oct 2008 22:05:34 +0200
Message-ID: <20081015200534.GA32686@strlen.de>
References: <20080928135526.GG5302@artemis.corp> <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com> <20080928143949.GH5302@artemis.corp> <20080928150318.GI5302@artemis.corp> <20080928151259.GJ5302@artemis.corp> <20080929150127.GB18340@spearce.org> <20080930095641.GA9001@strlen.de> <20080930190449.GG21310@spearce.org> <20080930221453.GA13659@strlen.de> <20080930222646.GP21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Erez Zilber <erezzi.list@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:06:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCe0-00073H-A6
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbYJOUFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 16:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbYJOUFo
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:05:44 -0400
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:58440 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752818AbYJOUFn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 16:05:43 -0400
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1KqCcg-0008WU-D7; Wed, 15 Oct 2008 22:05:34 +0200
Content-Disposition: inline
In-Reply-To: <20080930222646.GP21310@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98313>

Hi Shawn,

On Tue, Sep 30, 2008 at 03:26:46PM -0700, Shawn O. Pearce wrote:
> Its a change in behavior.  Today users are getting annotated tags
> back from `git describe --tags` even if lightweight tags are closer.
> Once this code change is in they'll start to get lightweight tags.
>
> Previously `git describe --tags` never gave a lightweight tag if
> there was at least one annotated tag in the history.  Now it will
> start to give the lightweight tags.  Some users may see that as a
> breakage.
Right, and previously `git describe` didn't differ from `git describe
--tags` in the presence of at least one annotated tag.  This is the main
reason for me to believe that this breakage doesn't hurt that much.

>            Especially after the 1.6 "dashless" change...
I didn't get why the "dashless" change is relevant here.  IMHO this one
is/was harder for the user because it changed every command, and they
had to start using bash completion if they didn't before.  This one
should only hurt the users of "git describe --tags", and I assume there
are not that many.  Still more as the documentation describes the
behaviour the patch implements.

Best regards
Uwe

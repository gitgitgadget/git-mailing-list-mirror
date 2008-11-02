From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH 1/3] git send-email: make the message file name more 
 specific.
Date: Sun, 2 Nov 2008 16:34:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811021629110.25369@sys-0.hiltweb.site>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225456609-694-1-git-send-email-madcoder@debian.org> <1225456609-694-2-git-send-email-madcoder@debian.org> <7vwsfm3b33.fsf@gitster.siamese.dyndns.org> <20081102093533.GE4066@artemis>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 22:36:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwkch-0005AT-1O
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 22:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbYKBVfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 16:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754239AbYKBVfN
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 16:35:13 -0500
Received: from mail.gmx.com ([74.208.5.67]:36329 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754232AbYKBVfL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 16:35:11 -0500
Received: (qmail invoked by alias); 02 Nov 2008 21:35:08 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com (EHLO [192.168.1.5]) [75.185.223.130]
  by mail.gmx.com (mp-us005) with SMTP; 02 Nov 2008 16:35:08 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX18v3kYyW4Ev2h2qDsV1TE21e93n4QJMku+dDlEzDK
	o/NwbqS/WhJQiH
In-Reply-To: <20081102093533.GE4066@artemis>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99875>

On Sun, 2 Nov 2008, Pierre Habouzit wrote:
> On Sun, Nov 02, 2008 at 06:18:08AM +0000, Junio C Hamano wrote:
> > Having said that, if we were to do this, let's do it the right way and put
> > these "temporary" files under $GIT_DIR.
> 
> Agreed, I should have done that.

Perhaps like this:

	my $compose_filename = $repo->repo_path() . "/sendemail.msg.$$";

where $repo is a repository instance.


	Ian

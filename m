From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH] describe: Make --tags and --all match lightweight
	tags more often
Date: Sun, 12 Oct 2008 11:00:40 -0700
Message-ID: <20081012180040.GC4856@spearce.org>
References: <20081010165952.GI8203@spearce.org> <48F12CF8.505@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Erez Zilber <erezzi.list@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Oct 12 20:02:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp5Gy-00087Q-UH
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 20:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760237AbYJLSAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 14:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbYJLSAm
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 14:00:42 -0400
Received: from george.spearce.org ([209.20.77.23]:60364 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564AbYJLSAl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 14:00:41 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 03CE43835F; Sun, 12 Oct 2008 18:00:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48F12CF8.505@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98040>

Andreas Ericsson <ae@op5.se> wrote:
> Shawn O. Pearce wrote:
>> If the caller supplies --tags they want the lightweight, unannotated
>> tags to be searched for a match.  If a lightweight tag is closer
>> in the history, it should be matched, even if an annotated tag is
>> reachable further back in the commit chain.
>>
>> The same applies with --all when matching any other type of ref.
>>
>
> In 99% of the cases, "--all" will then give back the currently
> checked out branch unless a revision is specified, right?

Yup.

`git describe --all` or `git describe --all HEAD`

would kick back the current branch you have checked out, assuming
you have a real branch under refs/heads and not some detached HEAD.

IMHO, that's what the user asked for.

-- 
Shawn.

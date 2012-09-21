From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Quickly searching for a note
Date: Fri, 21 Sep 2012 17:10:54 +0200
Message-ID: <m2d31fbedd.fsf@igel.home>
References: <505C7C80.3000700@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 17:11:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF4sq-0005KB-3Q
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 17:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab2IUPLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 11:11:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41161 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab2IUPK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 11:10:59 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XNdYF2X67z4KK4C;
	Fri, 21 Sep 2012 17:10:55 +0200 (CEST)
X-Auth-Info: 67PhaSYq0K+pXovt3dIvMWDHVpN2L9WCNLq6qT/BDho=
Received: from igel.home (ppp-88-217-127-217.dynamic.mnet-online.de [88.217.127.217])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XNdYC3411zc9dF;
	Fri, 21 Sep 2012 17:10:55 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id AE449CA2A5; Fri, 21 Sep 2012 17:10:54 +0200 (CEST)
X-Yow: You should all JUMP UP AND DOWN for TWO HOURS while I decide
 on a NEW CAREER!!
In-Reply-To: <505C7C80.3000700@workspacewhiz.com> (Joshua Jensen's message of
	"Fri, 21 Sep 2012 08:41:04 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206126>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

> Background: To tie Perforce changelists to Git commits, I add a note to a
> commit with the form "P4@123456".  Later, I use the note to sync down the
> closest Perforce changelist matching the Git commit.
>
> I search for these notes by getting a list of revisions:
>
>         git rev-list --max-count=1000
>
> I iterate those revisions and run git show and grep on each:
>
>         git show -s --format=%N%n%s --show-notes=p4notes COMMIT

How about "git grep P4@123456 notes/p4notes"?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

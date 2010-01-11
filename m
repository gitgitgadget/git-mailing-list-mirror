From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: How to check new commit availability without full fetch?
Date: Mon, 11 Jan 2010 21:06:16 +0100
Message-ID: <m2iqb8xv7r.fsf@igel.home>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 11 21:07:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUQXa-0000Yd-DO
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 21:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab0AKUGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 15:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141Ab0AKUGU
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 15:06:20 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:37176 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097Ab0AKUGS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 15:06:18 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id B16051C001AC;
	Mon, 11 Jan 2010 21:06:17 +0100 (CET)
Received: from igel.home (DSL01.83.171.152.131.ip-pool.NEFkom.net [83.171.152.131])
	by mail.mnet-online.de (Postfix) with ESMTP id 9FDE090153;
	Mon, 11 Jan 2010 21:06:17 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 2A66DCA298; Mon, 11 Jan 2010 21:06:17 +0100 (CET)
X-Yow: I didn't order any WOO-WOO...  Maybe a YUBBA..  But no WOO-WOO!
In-Reply-To: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
	(Leo Razoumov's message of "Sun, 10 Jan 2010 06:12:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136661>

Leo Razoumov <slonik.az@gmail.com> writes:

> Hi List,
> I am trying to find a way to check availability of new commits
> *before* doing fetch or pull. Unfortunately, neither fetch nor pull
> take "--dry-run" option (unlike push)

Try git remote show origin.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

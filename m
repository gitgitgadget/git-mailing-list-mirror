From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Illegal filename characters one Windows
Date: Sun, 15 Apr 2012 19:16:29 +0200
Message-ID: <4F8B026D.5070505@kdbg.org>
References: <20120415000725.GA32140@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 19:16:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJT3z-0000iC-Ox
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 19:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008Ab2DORQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 13:16:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:44501 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727Ab2DORQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 13:16:31 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BBCEB130055;
	Sun, 15 Apr 2012 19:16:29 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6AEA519F6BA;
	Sun, 15 Apr 2012 19:16:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <20120415000725.GA32140@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195572>

Am 15.04.2012 02:07, schrieb Clemens Buchacher:
> I recently noticed that git does not deal very well with illegal
> filenames on Windows. I have a repository which contains a couple of
> filenames like "Re: some email.eml". On a Windows box, those files get
> truncated to just "Re" during checkout, because ':' is an illegal
> character for filenames on Windows. [1]

This is a issue very similar to files named nul, aux, prn, com1 and the
like; they can't be checked out, either. I've suggested to use sparse
checkout in such cases; other than that, I think we don't have a
solution for it.

-- Hannes

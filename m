From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: git svn dcommit sends to wrong branch
Date: Wed, 11 Jan 2012 15:05:13 +0100
Message-ID: <20120111140513.GA12633@victor>
References: <20120110161843.GC8196@victor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 15:06:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkyop-0008JI-CF
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 15:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757654Ab2AKOF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 09:05:28 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:48330 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757711Ab2AKOFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 09:05:23 -0500
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20120110161843.GC8196@victor>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188367>

This message was never delivered and no error message ever came back; is
there some weird filtering going on?

On Tue, Jan 10, 2012 at 05:18:43PM +0100, Victor Engmark wrote:
> Commands:
> 
> git svn clone -s -r 1:HEAD http://svn/repo
> cd repo
> git commit [thrice, in master only]
> git rebase --interactive HEAD~20 [i.e., started rebase in commits before
> the clone]
> [Merged two commits I had made *after* the clone]
> git commit ...
> git dcommit
> 
> This created commits on
> <http://svn/repo/branches/branch_name>! Why? Is it because HEAD~20's
> git-svn-id <http://svn/repo/branches/branch_name@22481> is on that
> branch?
> 
> And more importantly, how do I "replay" my commits on trunk?

Cheers,
V
-- 
terreActive AG
Kasinostrasse 30
CH-5001 Aarau
Tel: +41 62 834 00 55
Fax: +41 62 823 93 56
www.terreactive.ch

Wir sichern Ihren Erfolg - seit 15 Jahren

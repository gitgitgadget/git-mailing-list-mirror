From: Michel Marti <mma@objectxp.com>
Subject: Re: [PATCH] Allow git-runstatus to limit its scope to a set of files/directories.
Date: Sat, 27 Oct 2007 20:44:57 +0200
Message-ID: <47238729.10901@objectxp.com>
References: <ffofbm@ger.gmane.org> <1193508519-14140-1-git-send-email-mma@objectxp.com> <Pine.LNX.4.64.0710271922340.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 27 20:45:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilqel-0002N1-9K
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 20:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757528AbXJ0SpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 14:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757524AbXJ0SpA
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 14:45:00 -0400
Received: from automatix.objectxp.com ([62.2.156.210]:43265 "EHLO
	automatix.objectxp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757522AbXJ0So7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 14:44:59 -0400
Received: from obelix.objectxp.com (obelix.office.objectxp.com [192.168.0.2])
	by automatix.objectxp.com (Postfix) with ESMTP id 7D61958011ED;
	Sat, 27 Oct 2007 20:44:57 +0200 (CEST)
Received: from powerbook-wl.home.mcfly.ch (unknown [192.168.10.34])
	by obelix.objectxp.com (Postfix) with ESMTP id 5AD382F63;
	Sat, 27 Oct 2007 20:44:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <Pine.LNX.4.64.0710271922340.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62508>

Johannes Schindelin wrote:
> On Sat, 27 Oct 2007, Michel Marti wrote:
> 
>> Signed-off-by: Michel Marti <mma@objectxp.com>
>> ---
>> IMO, the next step should be to tweak git-status/git-commit: I suggest 
>> introducing a new option '--what-if' to 'git-commit' that behaves like current
>> 'git-status [<path>...]' and in return stop 'git-status' from displaying 
>> '[<path>...]'  as "Changes to commit".
> 
> I am not sure this is the correct way to go, since "git status" as a "git 
> commit --dry-run" has worked well so far.
Maybe, but current git-status behaviour is somewhat illogical and I'm 
pretty sure there are more than a few git-users that were puzzled after 
calling "git-status some-dir" for the first time.

> Besides, I would like to see builtin-commit go in as soon as possible, and 
> this patch would delay that.
Hmmm, why is that? The patch only touches git-runstatus, invoking 
"git-status <path>" will behave as usual.

- Michel

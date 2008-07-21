From: Andreas Ericsson <ae@op5.se>
Subject: Re: Suggestion: doc restructuring
Date: Mon, 21 Jul 2008 08:41:44 +0200
Message-ID: <48842FA8.5070309@op5.se>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <48806D03.30603@fastmail.fm> <alpine.DEB.1.00.0807190314010.3064@eeepc-johanness> <7vk5fhc6qo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 08:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKp7y-0002Pg-Vf
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 08:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231AbYGUGm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 02:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757032AbYGUGm7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 02:42:59 -0400
Received: from mail.op5.se ([193.201.96.20]:40192 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756911AbYGUGm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 02:42:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C59A424B0DA6;
	Mon, 21 Jul 2008 08:43:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dcn37M8AWUiF; Mon, 21 Jul 2008 08:43:36 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 170EC1B80380;
	Mon, 21 Jul 2008 08:43:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <7vk5fhc6qo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89309>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> So what I really would like is this: leave the plumbing pages as they are, 
>> but enhance those pages that users (especially new ones) are likely to see 
>> most often.
> 
> Regarding the original "do we want to ever teach plumbing to new users?"
> issue, I suspect that, with sufficient enhancement to Porcelain, we might
> be able to reach a point where end users can work without ever touching a
> single plumbing command at all.
> 
> 	Side note, that was why I suggested us to first think about use
> 	cases in our every day work that we still need to resort to the
> 	plumbing, so that we can identify what that enhancement would
> 	consist of.
> 

Half a year or so ago, there were some mailings to the list along the lines
of "what git commands do you use?", using the bash history and a shell
oneliner to dig out some crude intel. Here's mine:
cat ~/.bash_history | grep ^git | awk '{ print $2 }' | grep -v '^--' | sort | uniq --count | sort -nr
     29 status
     26 diff
     19 show
     17 log
     11 branch
      9 grep
      8 pull
      8 commit
      7 fetch
      7 describe
      6 rev-list
      5 help
      4 push
      4 merge
      3 reset
      3 config
      3 clone
      3 add
      2 rev-parse
      2 format-patch
      1 stash
      1 checkout
      1 apply

To be fair, rev-parse and rev-list are on there due to some oneline scripting.
I needed to move commits from several different branches to a single place,
filtering on author.

> When we reach that point, we might want to restructure the documentation
> into two volumes.  One volume for end-users who exclusively use the stock
> git Porcelain, and another that describes plumbing commands for Porcelain
> writers.
> 
> Perhaps move the plumbing documentation to section 3; just like Perl has
> DBI.3pm and friends there, /usr/share/man/man3/git-cat-file.3git will
> describe what scripts can do with the command.

I like this idea, although newbie users may not know what section 3 is for.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

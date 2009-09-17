From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Update the usage bundle string.
Date: Thu, 17 Sep 2009 18:04:27 +0200
Message-ID: <vpqbpl9woac.fsf@bauges.imag.fr>
References: <1253136011-12011-1-git-send-email-tfransosi@gmail.com>
	<4AB1D364.1080701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:04:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoJTH-0006uo-OG
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 18:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655AbZIQQE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 12:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757526AbZIQQE0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 12:04:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47037 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755916AbZIQQE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 12:04:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8HG1aS5010259
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 17 Sep 2009 18:01:36 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MoJT9-0002T1-D8; Thu, 17 Sep 2009 18:04:27 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MoJT9-0001D4-Bi; Thu, 17 Sep 2009 18:04:27 +0200
In-Reply-To: <4AB1D364.1080701@viscovery.net> (Johannes Sixt's message of "Thu\, 17 Sep 2009 08\:12\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 17 Sep 2009 18:01:36 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128762>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Thiago Farina schrieb:
>
>> +static const char builtin_bundle_usage[] = "\
>> +  git bundle create <file> <git-rev-list args>\n\
>> +  git bundle verify <file>\n\
>> +  git bundle list-heads <file> [refname...]\n\
>> +  git bundle unbundle <file> [refname...]";
>
> You indent the usage text. Do other commands do that, too? If you resend,
> it may be worth using this style:
>
> static const char builtin_bundle_usage[] =
> 	"git bundle create <file> <git-rev-list args>\n"
> 	"git bundle verify <file>\n"

I like aligned usage strings, like:

$ git stash -h
Usage: git stash list [<options>]
   or: git stash show [<stash>]
   or: git stash drop [-q|--quiet] [<stash>]
   or: git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
   or: git stash branch <branchname> [<stash>]
   or: git stash [save [-k|--keep-index] [-q|--quiet] [<message>]]
   or: git stash clear

or

$ git branch -h |& head -n 4
usage: git branch [options] [-r | -a] [--merged | --no-merged]
   or: git branch [options] [-l] [-f] <branchname> [<start-point>]
   or: git branch [options] [-r] (-d | -D) <branchname>
   or: git branch [options] (-m | -M) [<oldbranch>] <newbranch>

but Git isn't very consistant here:

$ git bisect -h |& head  -n 6
Usage: git bisect [help|start|bad|good|skip|next|reset|visualize|replay|log|run]

git bisect help
        print this long help message.
git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
        reset bisect state and start bisection.

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/

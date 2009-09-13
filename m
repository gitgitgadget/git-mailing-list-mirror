From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: Effectively tracing project contributions with git
Date: Sun, 13 Sep 2009 02:10:49 +0200
Message-ID: <4AAC3889.6030908@webdrake.net>
References: <4AAB9459.3070809@webdrake.net> <20090912185940.GA21277@coredump.intra.peff.net> <fabb9a1e0909121203r527bc81ctd68382fc1107bf06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 02:10:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmcg9-00051h-Mz
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 02:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbZIMAKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 20:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752941AbZIMAKp
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 20:10:45 -0400
Received: from up.nbi.dk ([130.225.212.6]:46815 "EHLO mail2.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747AbZIMAKo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 20:10:44 -0400
Received: from [192.168.0.4] (zux221-207-155.adsl.green.ch [81.221.207.155])
	by mail2.nbi.dk (Postfix) with ESMTP id 3E4B73C930;
	Sun, 13 Sep 2009 02:10:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <fabb9a1e0909121203r527bc81ctd68382fc1107bf06@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128319>

Sverre Rabbelier wrote:
> Git stats can aggregate diffs, so it can show you "this author made
> changes to this many lines to this file in total", but it doesn't work
> across renames. It also has an option to aggregate that to a total per
> project number, but I'm not sure how useful that is to your case, as
> you seem to be interested in a per-file/line basis? I agree with Jeff
> that you'll need to define more precisely what it is you want to know
> :).

That would certainly be a very useful function -- it wouldn't solve my
problem for me but would make it easier to identify core authors.  After
all, 'number of commits' doesn't necessarily correspond to meaningful
contribution -- many of them could be editorial -- but number of lines
(or the ratio of lines to commits) could be a much better indicator.

I don't see any solution that doesn't see me browsing diffs -- there's
no metric that will solve the problem -- but if your stats work could
help me get an output of the form 'here are all the diffs on file X by
contributor Y in order of size, largest first' then I think it would
help a LOT.

Is there a website where I can read more about your stats/metrics work?
 Beyond the applications to the present problem I have some other
reasons to be very interested in what can be done with git history stats.

Thanks & best wishes,

    -- Joe

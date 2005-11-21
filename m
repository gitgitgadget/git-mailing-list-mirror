From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [RFC] git-format-patch options
Date: Mon, 21 Nov 2005 10:27:37 -0800 (PST)
Message-ID: <20051121182737.43012.qmail@web31811.mail.mud.yahoo.com>
References: <43820AF8.5060208@op5.se>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Nov 21 19:28:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeGON-00018z-58
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 19:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVKUS1k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 13:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVKUS1k
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 13:27:40 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:37782 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932405AbVKUS1j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 13:27:39 -0500
Received: (qmail 43015 invoked by uid 60001); 21 Nov 2005 18:27:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SzkAiloj1xDiVSNO5TgOvtnmkpfXLMzZPO3ETUuKIFX3PuCEb4LSAlRBiwAKZl7xrl4fFeMsp6pqhD+MjnE3WygVe0fXbzS5mmJhy08HFP7YCfmACK1syDJNcAPkbClSi6r8kfBPNB4xo7t9gdxnQWP6RwMt0kf/SpaNmmNTYAI=  ;
Received: from [68.221.112.229] by web31811.mail.mud.yahoo.com via HTTP; Mon, 21 Nov 2005 10:27:37 PST
To: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
In-Reply-To: <43820AF8.5060208@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12465>

--- Andreas Ericsson <ae@op5.se> wrote:

> Here's how to automate it.
> 
> git format-patch $(git rev-list --max-count=2 <commit-ish> | tail -n 
> 1)..<commit-ish>

I've a similar script, called
"git-format-commit-patch <commit-ish>" which is slightly
more involved.

> Either way, you need to know <commit-ish>, but this format should be 
> fairly easy to add to git-format-patch. If you do, please

How about git-format-patch --commit <commit-ish>
to generate the formatted patch of only what _that_ commit
introduced? (i.e. <parent>..<commit-ish>)

Do people find this valuable to have?

    Luben
P.S. Since it is really trivial to write such a script
on top of git-rev-list and git-format-patch, it may be
easier to just leave things as they are.  It was just
something I needed, which I thought other people might
need too.

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Add a bugzilla website
Date: Fri, 15 Nov 2013 11:19:58 -0800
Message-ID: <20131115191957.GA27781@google.com>
References: <20131115085326.GA2401@brouette>
 <551223703.314994127.1384508447263.JavaMail.root@zimbra35-e6.priv.proxad.net>
 <20131115135132.431d3e344dadee64e2be5127@domain007.com>
 <CAH5451=+N1vYoNeweQXe9vavjmRvkEzP=7U+mDf-0zH9OSpZPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	ycollette.nospam@free.fr,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 15 20:28:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhP4E-000829-7d
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 20:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab3KOT2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 14:28:31 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:53557 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab3KOT23 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 14:28:29 -0500
Received: by mail-yh0-f42.google.com with SMTP id z12so2039748yhz.29
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 11:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QIHvAUjaCN1GMNwlN3kjx1nLJ3LlXvIfpxsA9S+q1gM=;
        b=0UsiB24ag1STnakQx6lTrGCvsMQhV/3lp+I8hnpfTNQS0C1MODIqpnpj5LxF5ke5xQ
         A7VafGsdvkxiYzn8Jqi4/+Ux2betwHRi2cUDSauMKEPrccmTrp5adKF5fdTGseCo0bcE
         JWshdqBNaOnOqSMa7trj0fYE+Yr5W8byq1fm2drVL+I6T8cEObgqpITwmG+/Uvr2etn1
         Oq5Ba827iKa7SrBY76ixbnA75NopATjz8x9778L9abXxiccnnZkqhrBpZ74kQn6W5ZCP
         ciRfevbAw7sTgyE/g/U+rfM2+4+QJXPkO4xfRChdI2gqgzHxGTXRoKpmnY5p7l7sqNf1
         /sMw==
X-Received: by 10.236.135.109 with SMTP id t73mr191334yhi.237.1384543210257;
        Fri, 15 Nov 2013 11:20:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id v96sm6757028yhp.3.2013.11.15.11.20.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 Nov 2013 11:20:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAH5451=+N1vYoNeweQXe9vavjmRvkEzP=7U+mDf-0zH9OSpZPA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237914>

Hi,

Andrew Ardill wrote:
> On 15 November 2013 01:51, Konstantin Khomoutov
> <flatworm@users.sourceforge.net> wrote:

>> But there was an announcement that an experimental JIRA instance has
>> been set up for Git [1].  I'm not sure what its current status is, but
>> you could look at it.
>
> So!
>
> The biggest concern has always been that any bug tracking system needs
> to complement the existing workflow of many developers. For bugs and
> feature requests, they are raised, discussed, and fixed on the list.
> Replacing this process is not in scope for a bug tracker.

I always thought the biggest concern was that someone has to have a
sense of what bugs are a priority to track and do the curation to keep
the list of bugs useful.  In the mailing list it's easy to prioritize
based on what people are actually working on; on a bug tracker, which
is mainly about what people are *not* working on, that's harder work.

One way to address that problem is to decentralize: maybe everyone has
a different idea of what bugs are important, but if each person or
project makes their own idea of that public, you get most of the
benefit of a bugtracker.  Bonus points if different project's
bugtrackers link to each other to avoid duplication of information.

In this vein, there are a few active bugtrackers for git already:

 * the mailing list archive is the canonical source of truth
 * the JIRA experiment: https://git-scm.atlassian.net
 * the Debian project maintains http://bugs.debian.org/src:git
 * the Ubuntu project maintains
   https://bugs.launchpad.net/ubuntu/+source/git

I don't think the Ubuntu bugtracker wants reports for upstream issues
that were not discovered on Ubuntu.  By contrast, the maintainers of the
Debian bugtracker have made it clear that they are happy to receive
reports for the git package even when they do not affect Debian at all
(e.g., Windows-specific issues).

In other words: if you report a bug by sending an email to
submit@bugs.debian.org with body text starting with

	Package: git
	Version: 1:1.8.5~rc2-1
	Tags: upstream

	... description of the bug here ...

then I am happy to keep track of it, link to the corresponding
upstream conversation, and let you know when I notice it's fixed.  Of
course I won't fix your bug for you, unless it's a priority to me for
other reasons. :)

More details on reporting bugs through the Debian BTS are at [1].

Maybe other people provide the same service as well.

Thanks and hope that helps,
Jonathan

[1] http://www.debian.org/Bugs/Reporting

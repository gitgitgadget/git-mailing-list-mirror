From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Fri, 12 Dec 2014 10:31:14 -0800
Message-ID: <20141212183114.GA29365@google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <20141210084351.GA29776@peff.net>
 <20141210091815.GA18372@google.com>
 <20141212091625.GA9049@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 19:31:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzUzu-0004XP-Eg
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 19:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbaLLSbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 13:31:22 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38164 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbaLLSbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 13:31:21 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so1903325igi.12
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 10:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MDtgPpUVrkzS17CecaATeYEzPUlYAawwRRk0a0hzWfA=;
        b=przwhNKBRb/+ZUTwc0Uy0fA1CG6j2CFj8blg0aQbx5k6sL2bpPSdW9+fMYqhfSa6b9
         LtAylkqjHU7Jtr08vBgD4UZPeSCXWmXjYnLqA54orvTXQmqwd/lX/ufpg5qAZ7hqMjp3
         nI3GRIfGsKP1evu+Cbhn/D9HWj0k/gJLSbwt07IDfkCSLfAkgBrOB6VjZOW2wVQ2eImt
         SNYegeiJ4qRLiGq4F1Cesnr3qTUM/Zl2fkIjWVFI0HwRGgzNy1jezRhnMvHOZ0fF0t8O
         lbflN7JZvk1zgFAVTzzzcL10NGz5uimftL5gP+mFZdqh1fu90+MaTkMRhBiKsrOrk+lP
         ibJw==
X-Received: by 10.42.201.212 with SMTP id fb20mr17465074icb.2.1418409081260;
        Fri, 12 Dec 2014 10:31:21 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:88f6:7c4b:61b7:9a92])
        by mx.google.com with ESMTPSA id m127sm968590ioe.32.2014.12.12.10.31.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 10:31:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141212091625.GA9049@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261354>

Jeff King wrote:

> I'm not sure any such thought as "intended to be out of date" went into
> it.

Junio started the documentation in v1.5.4-rc1~49 (2007-11-24).  I'm
not sure if there was a discussion preceding that commit.  My
understanding was always that putting the documentation out-of-line
was an intentional decision and that it was understood that the
documentation would have cycles of falling out of date and needing to
be updated, but I may be misunderstanding the history.

Separate from the question of history, I honestly prefer this way of
doing API documentation relative to 90% of the API documentation in
headers I've seen in other projects.  I suspect you don't.  That's
okay --- it's possible for rational people to disagree about things.

It's moot given that we don't seem to disagree about what should be
done about it.  Why keep arguing?

> I think the end result that I posted is still strictly better than what
> we have currently, with the exception that I should have reformatted the
> hanging indents. What is it that you don't like about it?

Other issues of inconsistent markup.  For example, some comments are
strangely indented, and some look like

	/* First line
	 * second line
	 * third line */

> I'm not super interested in going back and forth over minor markup
> issues if there are overall issues with the concept that might block it
> from happening (just because they are tedious and time-consuming, and I
> do not want to spend a lot of time formatting something that will get
> thrown away). So please list your complaints in order of increasing
> specificity. :)

The overall concept is good.

I chose not to list markup issues for the same reason (it's more
tedious to go back and forth than for someone to spend some time to
get it mostly-right first on their own).  I am kind of confused about
the current status, since I've said again and again that I'd be happy
to see the documentation in the header but you still seem to be trying
to convince me of that.  What am I missing?

Jonathan

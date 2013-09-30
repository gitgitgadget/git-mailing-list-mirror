From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Git counterpart to SVN bugtraq properties?
Date: Mon, 30 Sep 2013 18:54:35 +0200
Message-ID: <5249ACCB.5090007@syntevo.com>
References: <51E69612.6020201@syntevo.com> <20130717133357.GB2337@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Sep 30 19:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQgpb-0005QA-1W
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 19:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab3I3RAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 13:00:16 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:55801 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934Ab3I3RAP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 13:00:15 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2013 13:00:15 EDT
Received: from [91.113.179.170] (helo=[192.168.92.3])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1VQgk1-0001ls-HP; Mon, 30 Sep 2013 18:54:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20130717133357.GB2337@serenity.lan>
X-Enigmail-Version: 1.5.2
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235617>

On 17.07.2013 15:33, John Keeping wrote:
> On Wed, Jul 17, 2013 at 03:03:14PM +0200, Marc Strapetz wrote:
>> I'm looking for a specification or guidelines on how a Git client should
>> integrate with bug tracking systems. For SVN, one can use
>> bugtraq-properties [1] to specify e.g. the issue tracker URL or how to
>> parse the bug ID from a commit message. AFAIU, there is nothing
>> comparable for Git [2]? If that's actually the case, is someone
>> interested in working out a similar specification for Git?
>>
>> [1] http://code.google.com/p/tortoisesvn/source/browse/tags/version_1.2.0/doc/issuetrackers.txt
>>
>> [2] http://stackoverflow.com/questions/17545548
> 
> The Git way to record the issue ID as a footer in the commit message.
> See for example [1].  Although I'm not aware of any standard for naming
> this footer.
> 
> In terms of recording the URL and other data, I think you'd want a
> dotfile in the repository (perhaps .bugzilla).  This shoudld probably be
> in the gitconfig format, like .gitmodules.
> 
> I think "all" it needs is to draw up a spec for the names of keys and
> format of their values, along with the format of footer(s) identifying
> issues associated with a commit and to persuade UI developers to support
> it... ;-)

Finally, I've created a minimal spec which is sufficient to parse and
display issue IDs:

https://github.com/mstrap/bugtraq/blob/master/specification.txt

I'd appreciate comments and pull requests.

-Marc

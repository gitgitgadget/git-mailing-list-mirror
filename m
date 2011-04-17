From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: How to manage multiple repos using submodules?
Date: Sun, 17 Apr 2011 14:42:29 -0400
Message-ID: <4DAB3495.3090200@sohovfx.com>
References: <4DA9C7A7.4010503@sohovfx.com> <20110416182053.GA11017@elie> <20110417064818.GA25344@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 20:42:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBWvi-0003iu-5m
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 20:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab1DQSmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 14:42:38 -0400
Received: from smtp01.beanfield.com ([76.9.193.170]:58983 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753432Ab1DQSmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 14:42:36 -0400
X-Spam-Status: No
X-beanfield-mta01-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta01-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta01-MailScanner: Found to be clean
X-beanfield-mta01-MailScanner-ID: 1QBWvY-000EJW-4J
Received: from [99.231.190.188] (helo=ZanarkandMac.local)
	by mta01.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.72)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QBWvY-000EJW-4J; Sun, 17 Apr 2011 14:42:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110417064818.GA25344@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171726>

Thanks for the mail archives! They were a very good read.

The smaller projects I have are fairly independent, so there isn't a 
situation where a commit works well with the other commits. I just 
wanted some ways to split each project out to its own repo. So that when 
I want to do some git operations on one project, I don't have to worry 
about the other projects. While submodules isn't an ideal solution, it 
seems to be the closest. Maybe what I need from submodules is a way for 
the super-repo to not record the commit of the sub-repos. i.e. Just use 
the head of a branch. But if that's the case, maybe it's out of the 
scope of a SCM, since I'm not really tracking a history anymore.

I haven't tried it yet, but the mr tool you mentioned seems interesting 
too. I'll check it out.

Thanks!
Andrew


On 11-04-17 2:48 AM, Jonathan Nieder wrote:
> Hi,
>
> Jonathan Nieder wrote:
>
>> Yep, if you want to keep track of the state of a bunch of repos over
>> time, submodules are not so bad[*].
> A kind person pointed out that I left out a footnote.  I think all I
> had been planning to say is that, roughly speaking, submodules are
> about[1] saying that a specific commit is known to work well with the
> rest of the code.  A supermodule like the one discussed in [2] is only
> likely to be useful if you are interested in what historical
> combinations of repositories were published and meant to work well
> together.
>
> Ciao,
> Jonathan
>
> [1] e.g., http://thread.gmane.org/gmane.comp.version-control.git/27803/focus=27830
> [2] http://lists.x.org/archives/xorg-devel/2009-September/001966.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

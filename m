From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Tue, 10 Oct 2006 10:33:26 +0200
Message-ID: <452B5AD6.7040301@op5.se>
References: <20061010051545.15859.qmail@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 10:33:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXD3M-0005X7-Mz
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 10:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWJJIda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 04:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWJJId3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 04:33:29 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:7568 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S965105AbWJJId3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 04:33:29 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id C149E6BE08; Tue, 10 Oct 2006 10:33:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 3FD2E6BD5D; Tue, 10 Oct 2006 10:33:26 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: ltuikov@yahoo.com
In-Reply-To: <20061010051545.15859.qmail@web31801.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28618>

Luben Tuikov wrote:
> --- Petr Baudis <pasky@suse.cz> wrote:
>> If the project includes a README file, show it in the summary page.
>> The usual "this should be in the config file" argument does not apply here
>> since this can be larger and having such a big string in the config file
>> would be impractical.
>>
>> I don't know if this is suitable upstream, but it's one of the repo.or.cz
>> custom modifications that I've thought could be interesting for others
>> as well.
> 
> I don't see how a read-me file relates to gitweb.
> 
> People may call those files "00README" or "README.txt"
> or "README.TXT" or "README_001", etc.
> 
> The contents of such a file has nothing to do with gitweb,
> and or git.  It may work for repo.or.cz but is unlikely that
> it would work for all projects for all git repos and for all
> gitweb interfaces.
> 

Well, git isn't the right tool for everything, and umbrellas are only 
good when it rains.

> The contents of a read-me file could be quite large and thus
> not suitable for the "summary" page.  Both the contents and the
> size may not be suitable.  "repo.or.cz" is the exception, not
> the rule.
> 
> A readme file isn't written with the intent of git or gitweb.
> It is a function of the project, not the SCM used to keep it in, or
> the SCM web interface used to show it.
> 

I can quite clearly envision usage for a README file for gitweb 
exclusive usage; It would show a link to coding guidelines, 
email-addresses for mailing-lists and project maintainers, bugtracker 
urls and other things which are handy to find fast on the web but that 
you don't necessarily want to dig around inside the repo for.

the project-root/README usually holds info along the lines of
"This program is really spiffy. It does this, this and that, and if you 
configure it properly, it will Make the World a Better Place(tm)."; Too 
newbie'ish info for people looking to submit bugs, patches and suggestions.


> I don't understand why the "description"  file doesn't do what
> you want?  Do you need it to be multi-line or slightly larger?
> Why not just extend "description" and/or create/use a second
> file called "description_long" to store multi-line descriptions?
> 

I imagine description_long is what's discussed here, although README is 
the suggested name.

> Or why not extend the "description" file s.t. only the first
> line would be shown in the "description" line of "summary" and
> down below, show the rest of the description file if present?
> 

Junio suggested this 2 hours before you sent your mail, and it seems as 
reasonable now as it did then. It also makes .git/description consistent 
with how we write and show commit-messages.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC v3] Git User's Survey 2008
Date: Tue, 26 Aug 2008 00:08:27 +0200
Message-ID: <200808260008.28958.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 00:09:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXkFr-0003bQ-6v
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 00:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbYHYWIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 18:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbYHYWIh
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 18:08:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:34583 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbYHYWIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 18:08:36 -0400
Received: by nf-out-0910.google.com with SMTP id d3so829333nfc.21
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zqkLw2bk+taRphpGf7qGaXgS7oc2oe8+Lt/sdBZK9ms=;
        b=c79Ku+6ftbhmShaDZ8Z7HyelDdBOAtCf6EP7A2AQrD998p8DRxY1LowEdTRfL0R9JO
         KEIybYdUl8H3HvhwmUQfc5k9KVT+Dio5YKSW9dN3kpbOsahsU7E/iHzYYaG8MchS8rpz
         aJupfJzkrNuCjCAi+xqvvTdSYN/vjZ2WiLPQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=KxCa6tcGKpSBnTh3Zi/CJqzykucZVvlA6JXAAxSIjGXRVRVHTd+hrvqqoYv3qushRg
         7vkEwKdanuBxiwWZzN+VxQlSALn9EtHAXO2gvo0euMniinYJU2NdjAaUbUvujYByJXW9
         tvgsOqAXLMbTB94Lu9UsQtIWk0+U2HhyK9ce8=
Received: by 10.210.36.8 with SMTP id j8mr7309089ebj.77.1219702114779;
        Mon, 25 Aug 2008 15:08:34 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.216.72])
        by mx.google.com with ESMTPS id z33sm4685647ikz.0.2008.08.25.15.08.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 15:08:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200807230325.04184.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93689>

This is third (and hopefully last) revision of proposed questions 
and announcement for Git User's Survey 2008.


First, it was decided that it would be web based survey.  I would use
Survs.com (new, in beta); it is unlikely to change as all questions 
are entered there already and moving it would require quite a bit of 
work.  It was recommended here on the list (I have received courtesy
invitation; thanks a lot); I have chosen it over survey.net.nz, used for 
preceding 2006 (by Paolo Ciarrocchi) and 2007 (by me) surveys, because 
it has some nice features, and allows export of results to CSV format 
for further analysis.

Note that new features like "matrix" questions and ability to have
'other' selection for single choice and multiple choice questions
affect a bit form of this survey.  This also affect chance to move 
survey to different web survey site.

There are good news and bad news about choosing Survs.com.  Good news is 
that there would be no problem of free Survs beta account expiring 
during running survey, or during analysis.  Bad news is that submitting 
survey currently requires having JavaScript enabled, which was pointed 
out by Stephan Beyer; they are working on it, but I don't know if this 
issue would be corrected in time for planned duration of Git User's 
Survey 2008.


Second, what possible answers in the case of single answer and multiple 
answer questions should be?  You can view current version of survey at 
provided survey link (see below), currently test one only.  Please 
point typos, mistakes and errors; I am not native English speaker.


Third, where to send survey to / where to publish information about the 
survey?  Last year the announcement was send to git mailing list, to
LKML (Linux kernel mailing list), and mailing list for git projects 
found on GitProjects page on GIT wiki.  Now that the number of projects 
using Git as version control system has grown, I don't think it would 
be good idea to "spam" all those mailing list; and if we don't send 
notice to all other projects I'm not sure if we should include LKML.

Last year survey announcement was put on Git Homepage (thanks Pasky), 
and on front page of Git Wiki; info about survey was also put on two 
git hosting sites: kernel.org and repo.or.cz.  It would be nice if it 
was possible to put announcement about Git User's Survey 2008 at front 
pages of other Git hosting sites, like GitHub (one of most popular, I 
think), Gitorious, Freedesktop.org.  If you know some other popular Git 
hosting sites, and even better if you know who to contact about putting 
survey announcement, please write.  Is there some channel that I have 
forgot about?  Should info/announcement about Git User's Survey 2008 be 
sent also to one of on-line magazines like LinuxToday or LWN, or asked 
to put on some blog?  I'll add it as journal entry for #git on Ohloh, 
and try to make it so it would appear in "News" section for Ohloh 
project page for Git: http://www.ohloh.net/projects/git.

Survs.com has nice feature of "channels", which allow to count
responses sent via different means separately; I am using it to
publish URL for 'test' channel - answers from this channel won't be
counted AT ALL!!!

I am thinking about asking to put annoncement about Git User's
Survey 2008 at the following places (in parenthesis there are people who 
I think can ask to put announcement about survey):
 * git.or.cz, Git Homepage (Petr 'Pasky' Baudis)
 * git-scm.com, alternate Git Homepage (Scott Chacon)
 * http://git.or.cz/gitwiki/FrontPage (it is wiki, after all)
 * #git channel subject (one of channel admins, but who?)
 * git.kernel.org (John 'Warthog9' Hawley)
 * repo.or.cz (Petr 'Pasky' Baudis)
 * gitorious.org (???)
 * github.com (???)
 * ...
What are other git hosting sites, or blogs, or other sites where to ask 
to put announcement about this survey?


Fourth, how long should the survey last?  When sending announcement we 
should say where notice about Git User's Survey 2008 should be taken 
down.  Last year the survey was meant to take three weeks, but was up 
longer.  I'm thinking about having it last a month, or a month and a
half, starting from September 1.


Below there is second version of announcement email (I should probably
come up also with boilerplate announcement for web pages).  I haven't 
put third version of this year round of questions, because text of 
survey at Survs.com and what I had written diverged, I'm sorry...

----
Hello all,

We would like to ask you a few questions about your use of the Git
version control system. This survey is mainly to understand who is
using Git, how and why.

The results will be published to the Git wiki and discussed on the git
mailing list.

We'll close the survey in 1 month starting from today, 1 September.

Please devote a few minutes of your time to fill this simple
questionnaire, it will help a lot the git community to understand your
needs, what you like of git, and of course what you don't like  of it.

The survey can be found here:
  http://www.survs.com/survey?id=M3PIVU72&channel=9XYYGHJ77G

(this is temporary channel URL; responses to this URL would
be, I guess, discarded).
----

You can view survey results (only summary, not individual responses)
at http://www.survs.com/shareResults?survey=M3PIVU72&rndm=OKJQ45LAG8
-- 
Jakub Narebski
Poland

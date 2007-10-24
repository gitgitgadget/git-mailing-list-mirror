From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git public repository naming convention
Date: Wed, 24 Oct 2007 11:03:24 +0200
Message-ID: <471F0A5C.6090705@op5.se>
References: <471E50AA.2020004@gnu.org> <200710232339.05948.bruno@clisp.org> <471E6A74.1050402@podval.org> <loom.20071023T215212-99@post.gmane.org> <87sl41cvpj.fsf@penguin.cs.ucla.edu> <86C7B590-6DF9-4785-92CB-B1466641256F@lrde.epita.fr> <87y7dtt0gk.fsf@rho.meyering.net> <FD3A6F4E-1570-4AF0-ADDC-5680B4E83C7D@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <jim@meyering.net>, bug-gnulib@gnu.org,
	git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Wed Oct 24 11:03:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikc9U-0007yb-AM
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 11:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbXJXJDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 05:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbXJXJDf
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 05:03:35 -0400
Received: from mail.op5.se ([193.201.96.20]:57988 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727AbXJXJDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 05:03:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2491D17306C7;
	Wed, 24 Oct 2007 11:03:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id icvBqSg2gbyr; Wed, 24 Oct 2007 11:03:04 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id A6DE617306B0;
	Wed, 24 Oct 2007 11:03:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <FD3A6F4E-1570-4AF0-ADDC-5680B4E83C7D@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62202>

Benoit SIGOURE wrote:
> [CC: Git-ML]
> 
> On Oct 24, 2007, at 9:51 AM, Jim Meyering wrote:
>> Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
>>>> On Oct 24, 2007, at 12:28 AM, Paul Eggert wrote:
>>>>> Index: gnulib.html
>>>>> ===================================================================
>>>>> RCS file: /web/gnulib/gnulib/gnulib.html,v
>>>>> retrieving revision 1.13
>>>>> retrieving revision 1.16
>>>>> diff -p -u -r1.13 -r1.16
>>>>> --- gnulib.html    22 Oct 2007 21:41:43 -0000    1.13
>>>>> +++ gnulib.html    23 Oct 2007 22:22:18 -0000    1.16
>>>>> @@ -57,14 +57,20 @@ You can also view the <a href="MODULES.h
>>>>>  anonymous <a href='http://git.or.cz/'>Git</a>, using the following
>>>>>  shell command:</p>
>>>>>
>>>>> -<pre><samp>git clone git://git.savannah.gnu.org/gnulib.git
>>>>> +<pre><samp>git clone git://git.savannah.gnu.org/gnulib
>>>>>  </samp></pre>
>>>
>>> Is there any reason why this has changed?  I learned (the hard way)
>>> that for bare public repositories, it's better to stick to what turns
>>> out to be more than a naming convention of `project.git'.  I don't
>>
>> What are the consequences of not doing that?
> 
> You can't git-clone the remote repo because it tries to fetch the wrong 
> URL (if the url isn't of the form `foo.git' it will try to fetch 
> `foo/.git' which will fail).
> 
>>> know if these issues are only related to dumb protocols (HTTP*) or if
>>> they also affect the Git protocol.  I can't find the relevant thread
>>
>> Hmm... maybe it's http-specific?
>> Things seem to work fine with the git protocol.
> 
> Yeah, that's what I wondered.
> 
>>> on the Git ML but the thing is that it seems that several tools rely
>>> on the fact that a repository name of the form `foo.git' implies that
>>> it's a bare repository (and thus it doesn't need to look for a  nested
>>> .git directory).
>>
>> It has always worked -- on that server, at least.
>> I use that form because I prefer the shorter URL:
>>
>>     git clone git://git.sv.gnu.org/gnulib
>>
>> In general, if you control the server repo,
>> you can simply add a symlink in project.git:
>>
>>     .git -> ..
>>
>> I suppose that avoids any such problems, but I haven't
>> done that on any of the savannah repositories.
> 
> Yeah well that's more of a workaround than anything else.
> 
> My guess: it works with the Git protocol, probably because 
> git-http-fetch works differently than whatever tool does the fetch for 
> the native Git protocol.  OTOH, isn't it better to have a consistent 
> naming?  If you look at the gitweb of gnulib [ 
> http://git.savannah.gnu.org/gitweb/?p=gnulib.git ], it says "URL 
> git://git.sv.gnu.org/gnulib.git".  Oddly enough, whether you add the 
> `.git' or not doesn't seem to change anything.
> 
> The documentation (Documentation/urls.txt) only shows examples of the 
> form `git://host.xz/path/to/repo.git/'.  So do 
> Documentation/core-tutorial.txt, Documentation/git-clone.txt and 
> Documentation/repository-layout.txt (among others).
> 
> Maybe the Git gurus will be able to shed some light on this issue.
> 

The dwimmery is handled on the server side and always happens unless
git-upload-pack gets the --strict flag. In git-daemon, this option is
called "--strict-paths".

git clone http://anything means the request doesn't end up in the hands
of git-upload-pack, so the DWIM code in path.c::enter_repo() is never
run.

Letting http-fetch re-implement the same dwimmery, using a trial/error
approach, but saving the correct URL in the remotes config, should
solve this problem, although it will be quite slow on high-latency
networks. Perhaps that doesn't matter, as it should only be an issue
for the original clone.

The suffixes to try are these:
const char *suffix[] = { ".git/.git", "/.git", ".git", "", NULL };

I believe gitweb mimics this behaviour.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sat, 24 May 2008 01:41:58 -0700 (PDT)
Message-ID: <m3r6bs2ixn.fsf@localhost.localdomain>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
	<m34p8o4ijg.fsf@localhost.localdomain>
	<5d46db230805232216p7936e5dex3aa3ff0e1e0dce06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat May 24 10:43:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzpLc-0000vv-AK
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 10:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbYEXImK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 04:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbYEXImJ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 04:42:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:18341 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbYEXImD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 04:42:03 -0400
Received: by nf-out-0910.google.com with SMTP id d3so501046nfc.21
        for <git@vger.kernel.org>; Sat, 24 May 2008 01:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=k5tGIOE0twSEMda2giGQGk+euKAX/1Q6pYaToDlgTSg=;
        b=IYrKWTmBDOT49zZw10QTdsQDDCkn/ziTkHwcy0HoLuaVP3RlD6qjKaiQU6/rbRh/GKdU2iPPwulVx077LRoawiTT+h4xTXiUs+esaKgtwdRvyffkSsft6n7Cyj0mAs4CpZ0PR/0m/goBPdRxAXd7eccm3nImaTMq3Jf7FVm5kig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=JAqnsOkrsPunj3KCFnytRs/ahdpOGu2BFaZ0ju93lT7u+1GElkJ5B2Wvt7F0KoJbvUCDld1KL5/MoRl+eKoUeXgi4ExWeefz2vNOgH96jueNBQUfUGyXPuRJRoeDzEI2ZZAStum5lFK6rDCtbGOB85T+nYrj64ivbDNRl215B+I=
Received: by 10.210.77.3 with SMTP id z3mr192134eba.183.1211618519816;
        Sat, 24 May 2008 01:41:59 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.36])
        by mx.google.com with ESMTPS id y34sm6997868iky.10.2008.05.24.01.41.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 May 2008 01:41:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4O8fOsY002518;
	Sat, 24 May 2008 10:41:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4O8f8QV002496;
	Sat, 24 May 2008 10:41:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <5d46db230805232216p7936e5dex3aa3ff0e1e0dce06@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82804>

"Govind Salinas" <blix@sophiasuchtig.com> writes:

What I forgot to ask: how would you compare Pyrite to similar tool,
namely to EasyGit?

> On Fri, May 23, 2008 at 8:07 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> "Govind Salinas" <blix@sophiasuchtig.com> writes:
>>
>>> One of the things that has been commented on by almost any review of
>>> git are the large numbers of commands that are present and the
>>> endless stream of flags, options, configuration variables and
>>> syntaxes that are present in git.  They certainly serve a purpose
>>> and I probably would not be able to do this without all those things
>>> but it can get in a normal users way some times.  Here are some of
>>> the steps I have and will be taking.
>>
>> Which is bogus, because most of those commands are plumbing, [almost]
>> never to be used by user directly.
>>
>> If I understand correctly in next major git release those commands are
>> to be hidden and not present in PATH anymore.
> 
> That may be true but it is only part of the story.  I see plumbing commands
> being given to users all the time on the mailing list.  Usually in some
> combination.  To make it worse they usually get several sets of commands
> that do something similar but any one may or may not be exactly what
> they want because not everyone who responds fully understands what the
> commands are doing.

The change to "git help" to show only porcelain commands unless
explicitely requested, and to git(7) manpage to have porcelain first
would help there.

But I think using plumbing in examples are remainder of git early
days, where it was the only way to work with git.  Tools like Pyrite,
or EasyGit, wouldn't change it...

>>> 1) Reduce the number of commands.
[...]
>> Note also that if you make all those unrelated (at least a bit) things
>> into one command you would lose some of error detection.  For example
>> you want to clone, but due to typo and DWIM-mery of "pyt co" command
>> it would silently fetch/merge/branch/whatever.  Not good...
>>
>> Note also that another complaint is that git commands do many fairly
>> independent things... and you would want to escalate it even
>> further...
>>
> 
> I will just have to do it right then :)  Seriously, I am not afraid to
> experiment
> with this to get the commands right.  Perhaps some of these can't be
> combined, but that is no reason not to see if it works.  Besides, DWIM is
> not enough, in needs to be "DWIM Safely".

I think you should start not with "minimal number of commands" as a
goal, but rather with set of distinct tasks ordinary (not scripting)
user might need, and how to map them into commands.
 
To heavily overloaded commands are as much if not worse than having
too many commands to choose from.

> >> 2) Reduce complexity.
[...]
>>> How about not using the ".." and "..." since it can be surprising to
>>> users what they actually do without understanding how git works.
>>> Perhaps something like --revision-start (-r) and --revision-end(-R)
>>> would help them out.  Add a --symmetric or something for "...".
>>
>> You don't need two options; first -r is start, second -r is end...
>>
> 
> Maybe, I prefer to be explicit and its a little less work for me.  Let me
> ask you this.  Is there a down side to having 2 different names?  If I
> say "pyt log -r foo" do I mean "..foo" or "foo.."?

Ah, yes, good catch.
 
>>> 3) Addons.
>>>
>>> Some functionality isn't for everyone.  I have just put into my
>>> next branch an addon that gives git revision numbers.  Why, because
>>> other SCMs that are supposed to be more user friendly have them.
>>> Because people have been asking for them.  Because they are easier
>>> to remember.
>>
>> Because people does not understand the concept and constraints of
>> distributed version control system (with implied multiple branches and
>> nonlinear history).
>>
>> Revision numbers cannot be all of: decentralized, global, unchanging,
>> encompassing.
[...] 
> I responded to this in another mail.  The other DVCSs don't claim that
> revision numbers are all of those things.  It is only necessary that when
> two people say the same thing, it mean the same thing.

> This doesn't stop them from using these numbers more than the sha1
> IDs because given a branch, the numbers are solid.  Doing things the
> way I propose has the same properties.

I wonder how useful in practice those revision numbers are in larger
repositories, with nonlinear history, i.e. if -r 6453:master -R 6455:master
(or something like that) is truly easier to use than master~2..master 

I _think_ that sha-1 are largely theoretical scare, as for example I
don't use them much, and if I use them it is in copy'n'paste manner.

>>> 5) One stop shop.
>>>
>>> I tried setting up Apache, lighttpd etc on Windows to do some ad-hoc
>>> serving of a git repo.  I was painful.  I want my webserver, gui,
>>> command line, diff tool, merge tool to all come in one package.  And
>>> I DON'T want it to need a cygwin or msys installation to work.
>>>
>>> That just makes life easier.  And I am all about the not expending
>>> effort.
>>
>> Perhaps we could just get more examples in gitweb/README and perhaps
>> in user's manual.
>>
> 
> Examples won't help too much on windows, partially because its just a pain
> in the ass to do, but also because thats not the preferred platform for any
> of the tools.  I was using cygwin git at the time and it simply did not work.
> Perhaps it has gotten better in the last few months particularly with
> msysgit.
> 
>> BTW. there always is git-instaweb.
>>
> 
> Yeah, but I still need the webserver, thats what I want to get rid of.  If you
> want to do some ad-hoc sharing it is a huge problem and you may not
> have permissions/time to install software.
> 
>> But having git-serve would be nice...
>>
> 
> Indeed.

And with Python AFAIK you can quite easily set up _simple_ web server
for HTTP access and browsing repository...

BTW. there was at some time git web interface in Python (old wit), but
it lost to gitweb; nowadays Ruby, eRuby or Ruby on Rails seems to be
the rage (new Wit (from XMMS2), Gitarella, Gitorious, GitHub).

-- 
Jakub Narebski
Poland
ShadeHawk on #git

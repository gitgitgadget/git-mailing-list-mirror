From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 17:06:27 -0400
Message-ID: <2B5084A3-9BDB-4463-8530-3C8AB2E09A1F@boostpro.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com> <20090424141847.GD10761@coredump.intra.peff.net> <91225E09-505A-4CD6-AC8E-FBB500A95984@boostpro.com> <20090424181539.GB11360@coredump.intra.peff.net> <0FC64949-689C-43A4-B656-9618E808962B@boostpro.com> <20090424202403.GB13561@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 23:08:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxScu-0007Lc-AV
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 23:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087AbZDXVGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 17:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbZDXVGa
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 17:06:30 -0400
Received: from boost-consulting.com ([206.71.190.141]:49817 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbZDXVG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 17:06:29 -0400
Received: from [192.168.188.150] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id 35FE71CC1F;
	Fri, 24 Apr 2009 14:03:58 -0700 (PDT)
In-Reply-To: <20090424202403.GB13561@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117488>


On Apr 24, 2009, at 4:24 PM, Jeff King wrote:

> On Fri, Apr 24, 2009 at 03:00:19PM -0400, David Abrahams wrote:
>
>>> How did you find out about them?
>>
>> The first time?
>>
>> $ man git
>>
>> [...]
>>
>> which makes no distinction [between porcelain and plumbing].
>
> Really? The command list in my version is divided into "HIGH-LEVEL
> COMMANDS (PORCELAIN)" and "LOW-LEVEL COMMANDS (PLUMBING)", with the
> commands you mentioned falling into the latter. And skimming "git log
> Documentation/git.txt", it looks like it has been that way for some
> time.

Sorry, you are totally right.

The list is just so crazy-long; I may have skimmed it.

>> Huh?  `which git` works.  ls-tree is an argument to git as far as I  
>> know.
>
> Yes, but shell completion will never present you with the text
> "ls-tree". You have to have found out about it somewhere else (and
> completion used to show, because git-ls-tree was in the PATH).
>
>>  $ xxx [--]help
>>
>> is usually OK if I already know xxx pretty well and just want a
>> refresher.  If know I'll need a little more than that, I use man  
>> straight
>> away.
>
> git --help shows a list of common commands, but otherwise "git help
> foo" and "git foo --help" _do_ show the manpage. It may be that "man
> git" could use some cleanup; specific suggestions are welcome.
>
>> What is "porcelain," please?  This is one among many examples of  
>> jargon
>> used only (or encountered by me for the first time) in the Git  
>> community.
>
> I think I ended up explaining it later in my email, but let me know if
> you are still confused.

Nope; I'm fine now.  It's not a great analogy, because everyone who  
uses a sink ends up dealing with spigots and valves, but I get it.

>>> The idea was to give a uniform calling convention without
>>> unnecessarily confusing users by presenting a large number of
>>> infrequently-used commands.
>>
>> It's not working, I'm sorry to say.
>
> Right, that's why I'm trying to figure out why you are hung up on the
> low-level commands. The idea was that you wouldn't need to be  
> exposed to
> them at all, but obviously you were (or if you were exposed, it  
> would be
> in a list that was clearly marked as "this is low-level stuff that you
> don't really need to worry about". So I'm trying to figure out where  
> it
> went wrong.

I'm sorry that I can't be much help in that department.  If I really  
knew how I ended up with that wrong impression, I probably would have  
corrected it already.  It's weird; git is composed of ideas that are  
all very familiar to me (reference-counted management of immutable  
data, hashing, etc.) yet for me, getting to know it has been really  
tough.  By contrast, for example, subversion was instantly  
understandable when I pawed through the SVN book.

>>> At any rate, it is too late to change the calling convention for
>>> plumbing.
>>
>> I disagree.  You can leave the old functionality there in a  
>> "deprecated"
>> state and change the way you advertise it.
>
> But does that really help? It means that "git hash-object" is still
> there, which I thought was the problem you had. You can argue that it
> wouldn't be advertised to users, and so wouldn't be a problem, but  
> that
> is _already_ the strategy we are using. So either that strategy is  
> fine,
> in which case we are on the right track but may still have some work  
> to
> do in properly implementing it. Or it's not, in which case your  
> proposal
> is no better.

You've got me stumped there, I have to admit.

>> It would even help a lot if the plumbing were all spelled "git-xxx"
>> and the high level stuff were "git xxx."
>
> Differentating calling conventions like that was proposed when dashed
> forms were deprecated and removed from the PATH. But if we had dashed
> forms for plumbing (i.e., not forwarding them via the "git" wrapper),
> then you have to do one of:
>
>  - put them in the user's PATH. Now tab completion or looking in your
>    PATH means you see _just_ the plumbing commands, and none of the
>    high level ones. Which is one of the reasons they were removed from
>    the PATH in the first place (due to numerous user complaints).
>
>  - put them elsewhere, and force plumbing users to add $GIT_EXEC_PATH
>    to their PATH. That becomes very annoying for casual plumbing  
> users.
>    If you come to the mailing list with a problem, I would have to  
> jump
>    through extra hoops to ask you to show me the output of "git
>    ls-files".

I see your point.

   llgit xxx

?

> Not to mention that the git wrapper does other useful things besides
> simply exec'ing. For example, it supports --git-dir, --bare, etc.
> So the problem is that the low-level commands _are_ still useful, and
> many people still want to call them, just like regular git commands.
> It's just that they are numerous and low-level, which makes them
> daunting for new users.
>
> And it has become obvious over several years of the git mailing list
> that users, once they see mention of a command, must start  
> investigating
> it to find out if and how it is useful. And I am not saying that is a
> failing of users; on the contrary, I think it is quite a healthy
> behavior on a unix-ish system. But it means that if we want not to
> advertise low-level commands, we have to be very careful about the  
> ways
> in which we mention them.
>
> Perhaps it would make sense for each plumbing command's man page to
> start with something like "this is a low-level command used for
> scripting git or investigating its internals. For high-level use, you
> may be more interested in $X", where $X may be "git commit" for
> write-tree, commit-tree, etc. And that would at least help intercept
> users before they get too confused.

Sounds like a great idea to me.

>>>> [excuse me, but what the #@&*! is "porcelainish" supposed to mean?
>>>> (http://www.kernel.org/pub/software/scm/git/docs/git-rev- 
>>>> parse.html)]
>>>
>>> Heh. That one is particularly egregious, because it rests on several
>>> layers of git jargon. The low-level tools are plumbing, like pipes  
>>> and
>>> valves.
>>
>> ? I use the valves on my kitchen sink all the time.
>
> Sorry, I meant the ones under the sink, that you would use if you were
> replacing the faucet. I would call the ones above "taps". But  
> hopefully
> you get a sense of the distinction between plumbing and porcelain.


I know, but the point is, they're not porcelain.  They're "plumbing  
fixtures."

I think UI/API works way better than porcelain/plumbing.  We are,  
after all, programmers.  It would also be good to link to a definition  
any time you use a term of art in the docs.  I would even do that in  
the case of UI/API since the distinction could appear to be subtle.

I should also say, most of the docs and interfaces I see in Git (and  
its wrappers, web interfaces, etc.) give the SHA1 hashes way too much  
exposure.  The times when it's actually more convenient to use a hash  
instead of one of the other notations are rare, and if hashes weren't  
so exposed I bet most interfaces would make those other names more  
available.  One reason I think hashes retain their prominent exposure  
is that you have no other reasonably stable way of referring to  
commits, since branch~NN counts backward from HEAD.  Adding such a  
thing would help.

Oh, one other specific issue: the rev-parse manpage uses $GIT_DIR  
without saying what it is.  I *think* that means the root of the  
working copy and has nothing to do with environment variables, but  
it's hard to be sure, and if I'm right about that, it's misleading  
notation.

Someone needs to get gitiseasy.org/gitiseasy.net and then provide  
content that lives up to the name :^)

--
David Abrahams
BoostPro Computing
http://boostpro.com

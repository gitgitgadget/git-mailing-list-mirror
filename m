Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808F1845
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0D4EE
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 03:52:25 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id DDB95202F9;
	Mon, 23 Oct 2023 06:52:22 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qusXm-YE5-00; Mon, 23 Oct 2023 12:52:22 +0200
Date: Mon, 23 Oct 2023 12:52:22 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTZQZhtTxvGT/s81@ugly>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>

On Sun, Oct 22, 2023 at 02:55:05PM +0200, Dragan Simic wrote:
>Oh, that's awesome and I'm really happy to be wrong with my broad 
>classification of VCS users.  However, I still need to be convinced 
>further, and I'd assign your example as an exception to the rules, 
>
i don't see myself as exceptional at all in that regard.
in fact, your second user group seems like unicorns, and the first like 
a disparaging attitude from an elitist. in reality, users lie on a 
spectrum of willingness to engage with the details of the tools they 
use, and that willingness is circumstantial. a tool that is forthcoming 
with information has a higher chance of being actively engaged.

> especially because you migrated to git from another VCS,
>
that isn't all that uncommon, esp. in the older cohorts. and unless git 
achieves a total monopoly, it will remain a regular occurence.

but i don't see how that advances your argument anyway.

> which you liked,
>
i didn't say that.

> and because you use the command line a lot.
>
in my experience, this isn't uncommon for users of "discrete" vcs'es at 
all, even if they aren't too interested in the details. they just copy 
"magic incantations" from stackoverflow, etc. - disgusting, right? ;-)

>After using git for a while, I can firmly say that git is awesome, but 
>that it also is a total overkill for many projects that need a VCS, for 
>which choosing Subversion would be a much batter choice.  Why, you'll 
>ask?  Because Subversion is many times simpler, and because many 
>projects actually don't need a distributed VCS.
>
that line of reasoning seems mostly bogus to me. every project can 
benefit from using a dvcs - reviewing and polishing the history prior to 
publication leads to higher quality (primarily of the history, but such 
polishing often also transpires to the code itself), so encouraging it 
is a useful default (of course interested users can just use git-svn, 
but that's a bigger step than just having a closer look at what was 
shoved in their faces).

git is indeed pretty much by definition many times harder than svn, 
simply because it splits the process of submission into three stages.  
however, this is not a _useful_ definition, as everyone can remember to 
use `git commit -a && git push` instead of `svn commit`. the real 
complexity comes from all the interesting things one can do because of 
the split stages, but that's optional (well, until you need to pull and 
you get a merge conflict - unlike with svn, git leaves the repo in a 
"weird" state, and the poor communication of that was in fact the major 
source of frustration for me when i started).

>I also ask myself why would I use git-gui or any other GUI utility?  To 
>me, clicking on something that represents a file is often simply wrong.  
>
that makes you an outlier. most people find point-and-click interaction 
rather intuitive and significantly more efficient than encoding their 
intent into character sequences.

also, i said "add -p". selecting hunks (and even single lines) plays in 
a wholly different league than whole files.

>Though, I understand that many people prefer GUI utilities and I 
>respect that, everyone is free to do anything, but I also expect others 
>to respect my own preferences.
>
where did anyone even suggest disrespecting your preferences?

you should however consider whether your preferences are a good default 
for the wider audience, even within the context of the command line.

i for one think that it would be a perfectly valid experiment to go 
all-in and beyond with jacob's proposal - _and make it the default_ 
(when the output is a tty). more advanced users who feel annoyed would 
be expected to opt out of it via configuration, as they are for the 
advice messages. because it's really the same idea, only thought bigger.

regards

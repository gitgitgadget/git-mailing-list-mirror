From: "George Dennie" <gdennie@pospeople.com>
Subject: RE: Hey - A Conceptual Simplication....
Date: Wed, 18 Nov 2009 21:03:31 -0500
Message-ID: <009401ca68bc$7e4b12b0$7ae13810$@com>
References: <005a01ca684e$71a1d710$54e58530$@com>	 <20091118142512.1313744e@perceptron>	 <008401ca6880$33d7e550$9b87aff0$@com>	 <m37htnd3kb.fsf@localhost.localdomain> <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: =?UTF-8?Q?'Jan_Kr=C3=BCger'?= <jk@jk.gs>, <git@vger.kernel.org>
To: "'Jason Sewall'" <jasonsewall@gmail.com>,
	"'Jakub Narebski'" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 03:04:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAwNk-0003sT-Pb
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 03:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbZKSCD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 21:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbZKSCD0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 21:03:26 -0500
Received: from smtp130.rog.mail.re2.yahoo.com ([206.190.53.35]:29331 "HELO
	smtp130.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932221AbZKSCD0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 21:03:26 -0500
Received: (qmail 70678 invoked from network); 19 Nov 2009 02:03:31 -0000
Received: from CPE001cf04d66c9-CM0012c9a0913a.cpe.net.cable.rogers.com (gdennie@99.244.179.211 with login)
        by smtp130.rog.mail.re2.yahoo.com with SMTP; 18 Nov 2009 18:03:31 -0800 PST
X-Yahoo-SMTP: zge3jO.swBAK2Pj1ZBh8nVciRpiiK2CUUeAJch.zCNP5zAk-
X-YMail-OSG: 9psIEjUVM1lnHwhgaZZ3lM6S.87qgHQvHQMB.quQyy3bbLifAM_GZg74BuAOdiTCOA--
X-Yahoo-Newman-Property: ymail-3
In-Reply-To: <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com>
X-Mailer: Microsoft Office Outlook 12.0
thread-index: AcpoiKz03wi3lDFwRo++9xqQFOVl5gADrVwA
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133208>

Thanks Linus, Jason, and Jakub...

Linus Torvalds wrote....
>On Wed, 18 Nov 2009, George Dennie wrote:
>> 
>> The Git model does not seem to go far enough conceptually, for some 
>> unexplainable reason...
>
> Others already mentioned this, but the concept you missed is the git 'index', which is actually very 
> central (it is actually the first part of git written, before even the object database) but is something 
> that most people who get started with git can (and do) ignore.

Uhmmm, subtle. I hear you. Thanks for the heads up. But before that, I just put these two cents down...

One of the persistent problems with software documentation is that it often fails to define the "functional or usage" model, apart from a dry list of commands. I am sure there are many good reasons for this. For one thing, explaining stuff is hard. Now, I have not had occasions to do merges, as such. So I am finding the justification for the index vague. I am wondering whether this might be a great space to describe the functional model of git in a way that more clearly justifies the index...

Specifically, can there be a succinct description of the usage or functional model of Git that necessarily incorporates the index. 

For example, the functional notion of the repository seems well defined: a growing web of immutable commits each created as either an isolated commit or more typically an update and/or merger of one or more pre-existing commits. 

With such a description the rest of the structure becomes almost implicit: Commits may be annotated such as with release number labels. Commits that have not been linked to such as by an update or merger remain dangling like loose threads in the web and are called branches. Branches may be given special labels that the repository will then automatically update so as to refer to the latest commit to that branch.

I don't yet have such a clear model for the index. Yes it is a staging platform, but so is the IDE....I'll do more reading.

Jason Sewell wrote....
> I find this leads to big, shapeless commits and, as I mentioned before, it seriously limits the utility 
> of 'git bisect'.  I also fail to see how 'selectively saving parts of the document' is versioning and 
> publishing - what is the publishing part?  The act of committing is one thing (and 'saving...

The notion of a shapeless commit is curious. Intuitively, I consider a commit as capturing the state of my work at a transactional boundary (i.e. a successful unit test...or even lunch break). However, your characterization of "shape" suggest that you are constructing something other than the immediate functionality of the software. Consequently, your software document is not really the solution files alone but also this commit history that you meticulously craft. 

Further, the participating of the IDE is not to compose within itself the committable document but rather to contribute to such a document in pieces. In fact, the closest metaphor to this process/workflow seems to be submitting articles to a magazine; except you are both the writer and editor/graphic artist; and each edition of the magazine becoming the committable version. 

With this metaphor the index does play a clear role as a layout board of sorts for the complete magazine. And also clearly, the IDE does not "functionally" edit the entire committable document but rather parts of it. Even though it may effectively have the entirety of the index in its working tree; Git requires that it be submitted to the index which is the true committable document. 

It begs the question, why is the working tree (the IDE document) so closely tied to the repository since it really amounts to a scratch pad. In fact, while the index may be attach to the working tree, the repository can be anywhere and have more than one index attached...yeah, I know, having a personal dedicated repository is cheap. (A great example of how expediency, the proximity of the repository, might obscure the functional model by making what is arbitrary and due to convention appear a functional necessity...; if, in fact, my above conclusion is correct of course :)

> What if you are hacking away and make changes to several parts of the code at once?  Making the commits 
> as fine-grained as possible makes it easier to cherry-pick, bisect, and understand the history.

You know Jason, it is often hard to isolate my changes to specific files. I have come to appreciate unit tests as a means of delineating changes. However, clearly the historically record of your solution tree is of substantially value to you. It is something I will have to pay closer attention in my case.

> Perhaps I don't understand your scheme, but it sounds like you're advocating 2 .gitignores:
>
> * .gitignore_track; with everything you don't automatically staged but  which can be trashed by your cleaning checkout
> * .gitignore_keep; with things you don't want staged but which shouldn't be deleted by git during cleaning

Yep, that may be one implementation...but essentially the current .gitignores list exclusionary filters for the "git add ." command. The suggestion was to augment it to also include exclusionary filters for the proposed "git checkout -clean" command.  By perhaps prefixing "+" and "-" symbols to the listed elements you can designate each filter's participation in the "do not add" and "do not delete" activities, respectively. However, this suggest was with the presumption that the work tree was the committable document, but clearly it is not.

> Who is pruning after a commit?  Once nice thing about checkout is that it will refuse to move to a 
> different commit if there are files that will get trashed.  Then you can say 'oops, I should 
> stash/commit/nuke that stuff before I change HEAD.

Not trashing files is a nice thing by checkout. However, are you referring to changes added to the index or changes made in the working tree but not yet added to the index. Base on my current understanding of the functional model, you would be referring to the index since the working tree is little more than a scratch pad. The pruning comment was in recognition that the working tree was not expected to be committable in its entirety.

George.

Thanks again for your input and if you have the time I welcome your response.

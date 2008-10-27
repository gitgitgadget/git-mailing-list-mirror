From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 10:41:53 +0100
Message-ID: <200810271041.54511.jnareb@gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <200810270252.23392.jnareb@gmail.com> <200810270850.09696.arne_bab@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, SLONIK.AZ@gmail.com, git@vger.kernel.org
To: "Arne Babenhauserheide" <arne_bab@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 27 10:43:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuOdB-00083n-AX
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 10:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbYJ0JmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 05:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYJ0JmL
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 05:42:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:22464 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYJ0JmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 05:42:10 -0400
Received: by nf-out-0910.google.com with SMTP id d3so626318nfc.21
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 02:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QXS7qgDtTMBKFE45o7lpoKNhrPQ2s4PI8htxOoGCAKE=;
        b=mt1hbxiC/IZLP9Wx6pgBZXisD0wPxIjvltoxGR+eIkv9B6dDJB1q7YDuUJ5W1l5OGw
         l7kS8QDg5JV+WKcBAZf6AMiEcfxAwTnjH0+1eRgCFKZ0frTkes2+7VRz19AFAlfxVJ75
         e27TZ5U3LB3NM/FuV4ZoGR8TtmdpmIdaEARiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jOQ+IhFHfxzPBFWcRgu45R0g8Fa+IKozg5wLyE4fgpFeEmuHeyLTWW2Umclr/9UI3G
         qSMEY4AHR45yRurSHHg2UThRzMCrtKfMYdD9JDImuOT/SBvaEYKkvnJ85E+jTCrzxK+q
         76+BWn2cVvHF49S51RD+jIdYGCX6RCQJQHNe4=
Received: by 10.210.46.12 with SMTP id t12mr6385047ebt.114.1225100527958;
        Mon, 27 Oct 2008 02:42:07 -0700 (PDT)
Received: from ?192.168.1.11? (abvq236.neoplus.adsl.tpnet.pl [83.8.214.236])
        by mx.google.com with ESMTPS id d24sm23769647nfh.16.2008.10.27.02.42.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Oct 2008 02:42:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200810270850.09696.arne_bab@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99219>

On Mon, 27 Oct 2008, Arne Babenhauserheide wrote:
> Am Montag 27 Oktober 2008 02:52:22 schrieb Jakub Narebski:
>> On Mon, 27 Oct 2008, Arne Babenhauserheide wrote:
>>> Am Sonntag 26 Oktober 2008 19:55:09 schrieb Jakub Narebski:
>>>>
>>>> I agree, and I think it is at least partially because of Git having
>>>> cleaner design, even if you have to understand more terms at first.
>>>
>>> What do you mean by "cleaner design"?

>>> From what I see (and in my definition of "design"), Mercurial is designed
>>> as VCS with very clear and clean design, which even keeps things like
>>> streaming disk access in mind.
>>
>> I have read description of Mercurial's repository format, and it is not
>> very clear in my opinion. File changesets, bound using manifest, bound
>> using changerev / changelog.
> 
> This grows very simple if you keep common filesystem layout in mind. 
> 
> inodes and datanodes (the files in the store), organized in directories which 
> keep many files (manifests) bound in changesets which keep additional data. 

Well, for you it might be simple, for others it is binding things
together with duct tape and spit. (I am exaggerating here).

What Mercurial repository design did not get correctly, in my opinion
is its handling of tags and [named] branches.
 
>> I don't quite understand comment about streaming disk access...
> 
> If you tell a disk "give me files a, b, c, d, e, f (of the whole abc)", it is 
> faster then if you tell it "give me files a k p q s t", because the filesystem 
> can easier optimize that call. 

I would expect _good_ filesystem to be able to optimize this call as
well. As I said it looks like Mercurial and Git are optimized for
different cases: Git relies on filesystem for caching, and optimizes
for warm cache performance.

> 
> That's why for example Mercurial avoids hashing filenames. 

First, git does not hash filenames. The hash is contents, not of name.
You can say it stores objects (in loose format) in hash-based filenames.
 
Second, in packed repository you don't have to ask filesystem to "give
me files a, k, p, q, s, t (of the whole abc)"; you ask filesystem to
mmap a _single_ pack file (well, almost, there is also pack index to
mmap).

Yes, that means that you should periodically repack for better
performance... but currently git tries to use packed format as much
as possible, keeping packs from network if they are not too small,
repacking if creating large number of objects, etc.

>> Well, they have to a lot less than they used to, and there is
>> "git gc --auto" that can be put in crontab safely.
> 
> relying on crontab which might not be available in all systems (I only use 
> GNU/Linux, but what about friends of mine who have to use Windows?)

So they would have to either periodically repack by hand, or use some
crontab equivalent on MS Windows.

But that doesn't matter in the context of this discussion, which is
DragonflyBSD; worse or better support for MS Windows doesn't matter
here, does it?

> 
>> Explicit garbage collection was a design _decision_, not a sign of not
>> clear design. We can argue if it was good or bad decision, but one
>> should consider the following issues:
>>
>>  * Rolling back last commit to correct it, or equivalently amending
>>    last commit (for example because we forgot some last minute change,
>>    or forgot to signoff a commit), or backing out of changes to the
>>    last commit in Mercurial relies on transactions (and locking) and
>>    correct O_TRUNC, while in Git it leaves dangling objects to be
>>    garbage collected later.
> 
> As far as I know the only problem with O_TRUNC was that it sadly had bugs in 
> Linux.
> 
>>  * Mercurial relies on transaction support. Git relies on atomic write
>>    support and on the fact that objects are immutable; those that are
>>    not needed are garbage collected later. Beside IIRC some of ways of
>>    implementing transaction in databases leads to garbage collecting.
> 
> But Mercurial normally works on standard filesystems, so this isn't the case 
> for normal operations.

Mercurial implements transactions as a way to keeping operations atomic.
So I don't know what you mean by "normally works on standard filesystem"
here.

> 
> You could say, though, that git implements a very simple transaction model: 
> Keep all old data until it gets purged explicitely.

Git just uses different way to keep operations atomic, different way
of implementing transactions.

I'm not sure if I should have mentioned transactions in databases here.
Oh, well... Note however that there are advanced way of doing
transactions in relational databases which lead to dangling things
to be purged when transaction is interrupted. But this is not to the
point...

> 
>>  * Explicit packing and having two repository "formats": loose and
>>    packed is a bit of historical reason: at the beginning there was
>>    only loose format. Pack format was IIRC invented for network
>>    transport, and was used for on disk storage (the same format!) for
>>    better I/O patterns[1]. Having packs as 'rewrite to pack' instead
>>    of 'append to pack' allows to prefer recency order, which result in
>>    faster access as objects from newer commits are earlier in delta
>>    chain and reduction in size in usual case of size growing with time
>>    as recency order allows to use delete deltas. Also _choosing_ base
>>    object allows further reduce size, especially in presence of
>>    nonlinear history.
> 
> So having multiple packs is equivalent to the automatic snapshot system in 
> Mercurial which doesn't need user interaction. 

Snapshot system doesn't change the fact that Mercurial (from what I
understand) implements forward deltas, from older version to never
version, and not from newer version to older.

Also from what I remember Mercurial didn't implement deltification
right from the start; it had problems with nonlinear history (it used
delta from last version appended, not from the parent version).

>>  * From what I understand Mercurial by default uses packed format for
>>    branches and tags; Git uses "loose" format for recent branches
>>    (meaning one file per branch), while packing older references.
>>    Using loose affects performance (and size) only for insane number of
>>    references, and only for some operations like listing all references,
>>    while using packed format is IMHO a bit error prone when updating.
> 
> As far as I know, Mercurial got that "using packed format" right from the 
> beginning. 

And probably requires transactions and locks for that. Git simply uses
atomic write solution for atomic update of references.

> 
>>  * Git has reflogs which are pruned (expired) during garbage collecting
>>    to not grow them without bounds; AFAIK Mercurial doesn't have
>>    equivalent of this feature.
>>
>>    (Reflogs store _local_ history of branch tip, noting commits,
>>    fetches, merges, rewinding branch, switching branches, etc._
> 
> As far as I know Mercurial only tracks the state of the working directory, so 
> it doesn't track your whole local history. 
> 
> But others can better tell you more about that in greater detail. 

Reflogs are very useful, and are natural extension of simple rollback
last transaction Mercurial has (which Git had equivalent from the very
beginning in the form of ORIG_HEAD). They allow for example for you
go back to the state before incorrect rewinding a branch, or before
applying series of patches from email, etc.

>> [1] You wrote about "streaming disk access". Git relies (for reading)
>> on good mmap implementation.
>>
>>> In git is has to check all changesets which affect the file.
>>
>> I don't understand you here... if I understand correctly above,
>> then you are wrong about Git.
> 
> Might be that I remember incorrectly about what git does. 
> 
> Are its commits "the whole changed file" or "the diff of the changes"? 
> 
> If the latter, it needs to walk back all commits to the snapshot revision to 
> get the file data. 

Git is snapshot based SCM, although 'behind the scenes' it uses deltas
in the pack format. So to get file data at given revision (i.e. to do
something like "git show <revision>:<filename>") it needs to access
<revision>, access its tree, and access contents of a file (blob).

Behind the scenes, at a lower level, Git does necessary delta resolving.
Delta chains in packs have limited length (as they have in Mercurial).

> One story I experienced with that: 
> 
> My amd64 GNU/Linux box suffers from performance problems when it gets high 
> levels of disk activity (something about the filesystem layer doesn't play 
> well with amd64 - reported by others, too). 
> 
> When I pulled a the Linux kernel repository with git half a year ago, my disk 
> started klicking and the whole computer slowed down to a crawl. 
> 
> When I pulled the same repository data from a Mercurial repository, the 
> computer kept running smooth, the disk stayed silent and happily wrote the 
> data. 
> 
> Mercurial felt smooth, while git felt damn clumsy (though not slow). 

The answer usually is: did you have this repository packed? I admit
that it might be considered one of disadvantages of git, this having
to do garbage collection from time to time... just like in C ;-)

>>> 1) Hg is easy to understand
>>
>> Because it is simple... and less feature rich, c.f. multiple local
>> branches in single repository.
> 
> That works quite well. People just don't use it very often, because the 
> workflow of having multiple repositories is easier with hg. 

Workflow of having multiple repositories, or one branch per repository,
is IMHO as simple in Git as in Mercurial, and as in Bazaar-NG.

>>> 2) You don't have to understand it to use it
>>
>> You don't have to understand details of Git design (pack format, index,
>> stages, refs,...) to use it either.
> 
> I remember that to have been incorrect about half a year ago, when I stumbled 
> over many problems in git whenever I tried to do something a bit nonstandard. 
> 
> It took me hours (and in the end asking a friend) to find out about 
> 
> "git checkout ."
> 
> just to get back my deleted files. 
> 
> The answer I got when I asked why it's done that way was "this is because of 
> the inner workings of git. You should know them if you use it". 

Well, understanding "git checkout ." doesn't require understanding
inner workings of git. Your friend was incorrect here. I'll agree
though that it is a bit of quirk in UI[1] (but I use usually 
"git reset --hard" to reset to last committed state).

[1] Having git-checkout behave very differently with and without
pathname parameter, and overloading of git-checkout.

>>> And both are indications of a good design, the first of the core, the
>>> second of the UI.
>>
>> Well, Git is built around concept of DAG of commits and branches as
>> references to it. Without it you can use Git, but it is hard. But
>> if you understand it, you can understand easily most advanced Git
>> features.
>>
>> I agree that Mercurial UI is better; as usually in "Worse is Better"
>> case... :-)
> 
> What do you mean with that? 

Just Google for "Worse is Better". But what I actually mean that Git
feature set and UI has evolved from very bare-bones plumbing, adding
features and UI _as needed_, instead of being designed according to
what designer thought it was needed.

For example in http://gitster.livejournal.com/9970.html Junio C Hamano
(git maintainer) writes:

  By the time the basic structure as we currently know has stabilized,
  we had help from literally dozens of contributors to add many things
  on top of the very original version:
  [...]
  
  * We did not envision that multiple branches in a single repository
    would turn out to be such a useful way to work, and did not have
    support for switching branches.
  [...]
  
  It still is amazing that all of these were done without having to go
  back to the drawing board.  It shows how sound the initial conceptual
  design was.

P.S. See "Innovations in git", http://gitster.livejournal.com/16077.html
-- 
Jakub Narebski
Poland

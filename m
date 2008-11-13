From: Andreas Ericsson <ae@op5.se>
Subject: Re: git integration with monodevelop
Date: Thu, 13 Nov 2008 08:55:28 +0100
Message-ID: <491BDD70.1080701@op5.se>
References: <491AAE6D.8030304@op5.se>
	<aec34c770811121556y34465436i9ffb5e29dbf203a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: monodevelop-list@lists.ximian.com, Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Michael Hutchinson <m.j.hutchinson@gmail.com>
X-From: monodevelop-list-bounces@lists.ximian.com Thu Nov 13 08:56:51 2008
Return-path: <monodevelop-list-bounces@lists.ximian.com>
Envelope-to: gcgmm-monodevelop-list@m.gmane.org
Received: from galactus.ximian.com ([130.57.169.22] helo=lists.ximian.com)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0X4M-0000gK-MO
	for gcgmm-monodevelop-list@m.gmane.org; Thu, 13 Nov 2008 08:56:50 +0100
Received: from galactus.ximian.com (localhost.localdomain [127.0.0.1])
	by lists.ximian.com (Postfix) with ESMTP id DF9411CFBAA;
	Thu, 13 Nov 2008 02:55:39 -0500 (EST)
X-Original-To: monodevelop-list@lists.ximian.com
Delivered-To: monodevelop-list@lists.ximian.com
Received: from herald.ximian.com (frontgate.ximian.com [130.57.169.19])
	by lists.ximian.com (Postfix) with ESMTP id BC3F61CFB80
	for <monodevelop-list@lists.ximian.com>;
	Thu, 13 Nov 2008 02:55:37 -0500 (EST)
Received: by herald.ximian.com (Postfix, from userid 2601)
	id A6CDB70060; Thu, 13 Nov 2008 02:55:37 -0500 (EST)
Received: from mail.op5.se (mail.op5.se [193.201.96.20])
	by herald.ximian.com (Postfix) with ESMTP id 9B0F17002B
	for <monodevelop-list@lists.ximian.com>;
	Thu, 13 Nov 2008 02:55:35 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 66C5C1B80005;
	Thu, 13 Nov 2008 08:49:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0MRkwKQ3NSyv; Thu, 13 Nov 2008 08:49:53 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id A957224B0002;
	Thu, 13 Nov 2008 08:49:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <aec34c770811121556y34465436i9ffb5e29dbf203a7@mail.gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	frontgate.ximian.com
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=5.0 tests=AWL,MY_OBFUT,MY_OBFUZ 
	version=3.0.3
X-BeenThere: monodevelop-list@lists.ximian.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: MonoDevelop discussion mailing list
	<monodevelop-list.lists.ximian.com>
List-Unsubscribe: <http://lists.ximian.com/mailman/listinfo/monodevelop-list>, 
	<mailto:monodevelop-list-request@lists.ximian.com?subject=unsubscribe>
List-Archive: <http://lists.ximian.com/pipermail/monodevelop-list>
List-Post: <mailto:monodevelop-list@lists.ximian.com>
List-Help: <mailto:monodevelop-list-request@lists.ximian.com?subject=help>
List-Subscribe: <http://lists.ximian.com/mailman/listinfo/monodevelop-list>,
	<mailto:monodevelop-list-request@lists.ximian.com?subject=subscribe>
Sender: monodevelop-list-bounces@lists.ximian.com
Errors-To: monodevelop-list-bounces@lists.ximian.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100857>

Michael Hutchinson wrote:
> On Wed, Nov 12, 2008 at 5:22 AM, Andreas Ericsson <ae@op5.se> wrote:
>> Recently, I've started learning C#. More for fun than anything else,
>> but one of the mono core devs sniffed me out and said they've been
>> thinking of porting jgit to C# to get a working IDE integration in
>> monodevelop. Currently, the only option available (with IDE
>> integration anyways) to the poor C# devs is either Microsoft's
>> crappy VSS, or the less crappy but still far from fantastic
>> Subversion.
> 
> I'm glad you're interested :-)
> 
> We do have an interface in MD for integrating VCS providers, and
> although the only existing one is SVN, I believe some users are
> working on bzr and perforce addins. I'd prefer to see git get
> established as the default (D)VCS ...
> 
> Currently, to implement  a VCS provider one needs to subclass
> VersionControlSystem, as demonstrated by the SVN provider:
> http://anonsvn.mono-project.com/viewvc/trunk/monodevelop/main/src/addins/VersionControl/MonoDevelop.VersionControl.Subversion/MonoDevelop.VersionControl.Subversion.addin.xml?view=markup.
> We may need to extend the interfaces in order to expose more
> DVCS-specific features, but I think it's best to find and fix these as
> needed rather than speculatively implementing things.
> 

I'll look into it. One thing I'd love to see is a "bisect" command
from within the IDE. That's one of those things that would make the
first IDE implementing it simply sell itself to hackers and suits
alike. Besides, "bisect", once learned, is such an awesome tool that
coders will start to adapt their workflow just to get full benefit
from it.

>> So in an effort to learn C#, I've decided to play along with this
>> (hopefully with some help from the MonoDevelop team), but it seems
>> to me that the best place to start is the fledgling libgit2 and link
>> that with git-sharp. The primary reason for this is ofcourse that I
>> think it'd be a terrible waste to have yet another from-scratch
>> implementation of git in a new language (ruby, java, C#, C...). The
>> secondary reason is that it would be neat to have more OSS projects
>> use my favourite scm.
> 
> That's actually one of the reasons we'd like a full managed
> implementation --it'd be trivial to include to with cross-platform
> Mono-based apps without worrying about architecture, C dependencies,
> etc. For example, Tomboy could use git to store its notes, so users
> would have a versioned history and better synch/merge. Then, for
> example, you could build a Silverlight version that would have full
> history in local storage.
> 

What's considered "unmanaged"? (remember I'm a C# newbie here). Is it
stuff marked as "unsafe"? If so, there's a whole platoon of stuff to
re-implement, which is quite nuts. Iiuc, a "safe" way of implementing
unmanaged code is to always write to objects passed as parameters in
libgit2, like so:

    int git_commit_get(git_commit *commit, git_oid *oid);

instead of

    git_commit *git_commit_get(git_oid *oid);

as one can let git_commit be a class that gets instantiated and also
gc'd the normal way. libgit just has to make sure not to leak memory
and avoid side-effects, but that's good library design anyways, so
it's not as if C# integration would hurt libgit design.

I really think this would be a better approach that could make the C#
implementation stay on top of new features (such as the up-and-coming
v4 pack) a lot better than writing it from scratch.

libgit2 is intended to be portable to all unices as well as Windows
and Mac OS X, so there's no real problem there

>> Besides, getting something to rely on libgit2 early on is probably
>> the best way to get more people interested in making development of
>> it proceed rapidly.
>>
>> Thoughts anyone?
> 
> I hadn't heard of libgit2 (it looks pretty recent)

It is.

> but it looks
> interesting -- at least stable APIs would no longer be a worry.
> However, I think fully managed is the way to go, from the point of
> view of much easier dependencies (on windows, mac, silverlight and
> older linux distros) and licensing.
> 

But who's going to write (and separately maintain) the 50k or so LoC
that will make up the git core lib in C#? It really is a waste of
resources, imo. Especially since libgit will get a lot of exercise,
whereas the C# code will get that of C#-based integrations only. I
have a feeling this would lead to bugs (or limitations) in the C#
implementation that the git community would be expected to deal with.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

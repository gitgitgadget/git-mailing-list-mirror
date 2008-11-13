From: "Christian Hergert" <christian.hergert@gmail.com>
Subject: Re: git integration with monodevelop
Date: Thu, 13 Nov 2008 01:28:38 -0800
Message-ID: <6d4a25b10811130128r4ebf60a4s5679d06961b92450@mail.gmail.com>
References: <491AAE6D.8030304@op5.se>
	<aec34c770811121556y34465436i9ffb5e29dbf203a7@mail.gmail.com>
	<491BDD70.1080701@op5.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2087043969=="
Cc: monodevelop-list@lists.ximian.com, Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: monodevelop-list-bounces@lists.ximian.com Thu Nov 13 10:29:59 2008
Return-path: <monodevelop-list-bounces@lists.ximian.com>
Envelope-to: gcgmm-monodevelop-list@m.gmane.org
Received: from galactus.ximian.com ([130.57.169.22] helo=lists.ximian.com)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0YWR-0001u3-2U
	for gcgmm-monodevelop-list@m.gmane.org; Thu, 13 Nov 2008 10:29:59 +0100
Received: from galactus.ximian.com (localhost.localdomain [127.0.0.1])
	by lists.ximian.com (Postfix) with ESMTP id 637061CFC0F;
	Thu, 13 Nov 2008 04:28:44 -0500 (EST)
X-Original-To: monodevelop-list@lists.ximian.com
Delivered-To: monodevelop-list@lists.ximian.com
Received: from herald.ximian.com (frontgate.ximian.com [130.57.169.19])
	by lists.ximian.com (Postfix) with ESMTP id C51611CFB80
	for <monodevelop-list@lists.ximian.com>;
	Thu, 13 Nov 2008 04:28:42 -0500 (EST)
Received: by herald.ximian.com (Postfix, from userid 2601)
	id B5F0770060; Thu, 13 Nov 2008 04:28:42 -0500 (EST)
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.242])
	by herald.ximian.com (Postfix) with ESMTP id F181C70030
	for <monodevelop-list@lists.ximian.com>;
	Thu, 13 Nov 2008 04:28:39 -0500 (EST)
Received: by hs-out-0708.google.com with SMTP id n78so449913hsc.4
	for <monodevelop-list@lists.ximian.com>;
	Thu, 13 Nov 2008 01:28:39 -0800 (PST)
Received: by 10.65.112.18 with SMTP id p18mr9754879qbm.87.1226568518291;
	Thu, 13 Nov 2008 01:28:38 -0800 (PST)
Received: by 10.64.47.3 with HTTP; Thu, 13 Nov 2008 01:28:38 -0800 (PST)
In-Reply-To: <491BDD70.1080701@op5.se>
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on 
	frontgate.ximian.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=5.0 tests=AWL,DNS_FROM_RFC_POST,
	HTML_20_30,HTML_MESSAGE,MY_OBFUT,MY_OBFUZ,RCVD_BY_IP,SPF_HELO_PASS,
	SPF_PASS version=3.0.3
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100860>

--===============2087043969==
Content-Type: multipart/alternative; 
	boundary="----=_Part_1666_2226784.1226568518278"

------=_Part_1666_2226784.1226568518278
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

By unmanaged, he means the [DllImport] which you would need to do the call
to the extern in the shared library.

Everyone that has chimed in has considered doing the git code before,
believe us when we say we've thought about wrapping C.  In this case, it
will be far more flexible in C#.  Especially since tools like silverlight do
not allow DllImport's.

However, its your time, and I'd love to see git support happen any way
possible.

-- Christian

On Wed, Nov 12, 2008 at 11:55 PM, Andreas Ericsson <ae@op5.se> wrote:

> Michael Hutchinson wrote:
> > On Wed, Nov 12, 2008 at 5:22 AM, Andreas Ericsson <ae@op5.se> wrote:
> >> Recently, I've started learning C#. More for fun than anything else,
> >> but one of the mono core devs sniffed me out and said they've been
> >> thinking of porting jgit to C# to get a working IDE integration in
> >> monodevelop. Currently, the only option available (with IDE
> >> integration anyways) to the poor C# devs is either Microsoft's
> >> crappy VSS, or the less crappy but still far from fantastic
> >> Subversion.
> >
> > I'm glad you're interested :-)
> >
> > We do have an interface in MD for integrating VCS providers, and
> > although the only existing one is SVN, I believe some users are
> > working on bzr and perforce addins. I'd prefer to see git get
> > established as the default (D)VCS ...
> >
> > Currently, to implement  a VCS provider one needs to subclass
> > VersionControlSystem, as demonstrated by the SVN provider:
> >
> http://anonsvn.mono-project.com/viewvc/trunk/monodevelop/main/src/addins/VersionControl/MonoDevelop.VersionControl.Subversion/MonoDevelop.VersionControl.Subversion.addin.xml?view=markup
> .
> > We may need to extend the interfaces in order to expose more
> > DVCS-specific features, but I think it's best to find and fix these as
> > needed rather than speculatively implementing things.
> >
>
> I'll look into it. One thing I'd love to see is a "bisect" command
> from within the IDE. That's one of those things that would make the
> first IDE implementing it simply sell itself to hackers and suits
> alike. Besides, "bisect", once learned, is such an awesome tool that
> coders will start to adapt their workflow just to get full benefit
> from it.
>
> >> So in an effort to learn C#, I've decided to play along with this
> >> (hopefully with some help from the MonoDevelop team), but it seems
> >> to me that the best place to start is the fledgling libgit2 and link
> >> that with git-sharp. The primary reason for this is ofcourse that I
> >> think it'd be a terrible waste to have yet another from-scratch
> >> implementation of git in a new language (ruby, java, C#, C...). The
> >> secondary reason is that it would be neat to have more OSS projects
> >> use my favourite scm.
> >
> > That's actually one of the reasons we'd like a full managed
> > implementation --it'd be trivial to include to with cross-platform
> > Mono-based apps without worrying about architecture, C dependencies,
> > etc. For example, Tomboy could use git to store its notes, so users
> > would have a versioned history and better synch/merge. Then, for
> > example, you could build a Silverlight version that would have full
> > history in local storage.
> >
>
> What's considered "unmanaged"? (remember I'm a C# newbie here). Is it
> stuff marked as "unsafe"? If so, there's a whole platoon of stuff to
> re-implement, which is quite nuts. Iiuc, a "safe" way of implementing
> unmanaged code is to always write to objects passed as parameters in
> libgit2, like so:
>
>    int git_commit_get(git_commit *commit, git_oid *oid);
>
> instead of
>
>    git_commit *git_commit_get(git_oid *oid);
>
> as one can let git_commit be a class that gets instantiated and also
> gc'd the normal way. libgit just has to make sure not to leak memory
> and avoid side-effects, but that's good library design anyways, so
> it's not as if C# integration would hurt libgit design.
>
> I really think this would be a better approach that could make the C#
> implementation stay on top of new features (such as the up-and-coming
> v4 pack) a lot better than writing it from scratch.
>
> libgit2 is intended to be portable to all unices as well as Windows
> and Mac OS X, so there's no real problem there
>
> >> Besides, getting something to rely on libgit2 early on is probably
> >> the best way to get more people interested in making development of
> >> it proceed rapidly.
> >>
> >> Thoughts anyone?
> >
> > I hadn't heard of libgit2 (it looks pretty recent)
>
> It is.
>
> > but it looks
> > interesting -- at least stable APIs would no longer be a worry.
> > However, I think fully managed is the way to go, from the point of
> > view of much easier dependencies (on windows, mac, silverlight and
> > older linux distros) and licensing.
> >
>
> But who's going to write (and separately maintain) the 50k or so LoC
> that will make up the git core lib in C#? It really is a waste of
> resources, imo. Especially since libgit will get a lot of exercise,
> whereas the C# code will get that of C#-based integrations only. I
> have a feeling this would lead to bugs (or limitations) in the C#
> implementation that the git community would be expected to deal with.
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
> _______________________________________________
> Monodevelop-list mailing list
> Monodevelop-list@lists.ximian.com
> http://lists.ximian.com/mailman/listinfo/monodevelop-list
>

------=_Part_1666_2226784.1226568518278
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

By unmanaged, he means the [DllImport] which you would need to do the call to the extern in the shared library.<br><br>Everyone that has chimed in has considered doing the git code before, believe us when we say we&#39;ve thought about wrapping C.&nbsp; In this case, it will be far more flexible in C#.&nbsp; Especially since tools like silverlight do not allow DllImport&#39;s.<br>
<br>However, its your time, and I&#39;d love to see git support happen any way possible.<br><br>-- Christian<br><br><div class="gmail_quote">On Wed, Nov 12, 2008 at 11:55 PM, Andreas Ericsson <span dir="ltr">&lt;<a href="mailto:ae@op5.se">ae@op5.se</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">Michael Hutchinson wrote:<br>
&gt; On Wed, Nov 12, 2008 at 5:22 AM, Andreas Ericsson &lt;<a href="mailto:ae@op5.se">ae@op5.se</a>&gt; wrote:<br>
&gt;&gt; Recently, I&#39;ve started learning C#. More for fun than anything else,<br>
&gt;&gt; but one of the mono core devs sniffed me out and said they&#39;ve been<br>
&gt;&gt; thinking of porting jgit to C# to get a working IDE integration in<br>
&gt;&gt; monodevelop. Currently, the only option available (with IDE<br>
&gt;&gt; integration anyways) to the poor C# devs is either Microsoft&#39;s<br>
&gt;&gt; crappy VSS, or the less crappy but still far from fantastic<br>
&gt;&gt; Subversion.<br>
&gt;<br>
&gt; I&#39;m glad you&#39;re interested :-)<br>
&gt;<br>
&gt; We do have an interface in MD for integrating VCS providers, and<br>
&gt; although the only existing one is SVN, I believe some users are<br>
&gt; working on bzr and perforce addins. I&#39;d prefer to see git get<br>
&gt; established as the default (D)VCS ...<br>
&gt;<br>
&gt; Currently, to implement &nbsp;a VCS provider one needs to subclass<br>
&gt; VersionControlSystem, as demonstrated by the SVN provider:<br>
&gt; <a href="http://anonsvn.mono-project.com/viewvc/trunk/monodevelop/main/src/addins/VersionControl/MonoDevelop.VersionControl.Subversion/MonoDevelop.VersionControl.Subversion.addin.xml?view=markup" target="_blank">http://anonsvn.mono-project.com/viewvc/trunk/monodevelop/main/src/addins/VersionControl/MonoDevelop.VersionControl.Subversion/MonoDevelop.VersionControl.Subversion.addin.xml?view=markup</a>.<br>

&gt; We may need to extend the interfaces in order to expose more<br>
&gt; DVCS-specific features, but I think it&#39;s best to find and fix these as<br>
&gt; needed rather than speculatively implementing things.<br>
&gt;<br>
<br>
</div>I&#39;ll look into it. One thing I&#39;d love to see is a &quot;bisect&quot; command<br>
from within the IDE. That&#39;s one of those things that would make the<br>
first IDE implementing it simply sell itself to hackers and suits<br>
alike. Besides, &quot;bisect&quot;, once learned, is such an awesome tool that<br>
coders will start to adapt their workflow just to get full benefit<br>
from it.<br>
<div class="Ih2E3d"><br>
&gt;&gt; So in an effort to learn C#, I&#39;ve decided to play along with this<br>
&gt;&gt; (hopefully with some help from the MonoDevelop team), but it seems<br>
&gt;&gt; to me that the best place to start is the fledgling libgit2 and link<br>
&gt;&gt; that with git-sharp. The primary reason for this is ofcourse that I<br>
&gt;&gt; think it&#39;d be a terrible waste to have yet another from-scratch<br>
&gt;&gt; implementation of git in a new language (ruby, java, C#, C...). The<br>
&gt;&gt; secondary reason is that it would be neat to have more OSS projects<br>
&gt;&gt; use my favourite scm.<br>
&gt;<br>
&gt; That&#39;s actually one of the reasons we&#39;d like a full managed<br>
&gt; implementation --it&#39;d be trivial to include to with cross-platform<br>
&gt; Mono-based apps without worrying about architecture, C dependencies,<br>
&gt; etc. For example, Tomboy could use git to store its notes, so users<br>
&gt; would have a versioned history and better synch/merge. Then, for<br>
&gt; example, you could build a Silverlight version that would have full<br>
&gt; history in local storage.<br>
&gt;<br>
<br>
</div>What&#39;s considered &quot;unmanaged&quot;? (remember I&#39;m a C# newbie here). Is it<br>
stuff marked as &quot;unsafe&quot;? If so, there&#39;s a whole platoon of stuff to<br>
re-implement, which is quite nuts. Iiuc, a &quot;safe&quot; way of implementing<br>
unmanaged code is to always write to objects passed as parameters in<br>
libgit2, like so:<br>
<br>
 &nbsp; &nbsp;int git_commit_get(git_commit *commit, git_oid *oid);<br>
<br>
instead of<br>
<br>
 &nbsp; &nbsp;git_commit *git_commit_get(git_oid *oid);<br>
<br>
as one can let git_commit be a class that gets instantiated and also<br>
gc&#39;d the normal way. libgit just has to make sure not to leak memory<br>
and avoid side-effects, but that&#39;s good library design anyways, so<br>
it&#39;s not as if C# integration would hurt libgit design.<br>
<br>
I really think this would be a better approach that could make the C#<br>
implementation stay on top of new features (such as the up-and-coming<br>
v4 pack) a lot better than writing it from scratch.<br>
<br>
libgit2 is intended to be portable to all unices as well as Windows<br>
and Mac OS X, so there&#39;s no real problem there<br>
<div class="Ih2E3d"><br>
&gt;&gt; Besides, getting something to rely on libgit2 early on is probably<br>
&gt;&gt; the best way to get more people interested in making development of<br>
&gt;&gt; it proceed rapidly.<br>
&gt;&gt;<br>
&gt;&gt; Thoughts anyone?<br>
&gt;<br>
&gt; I hadn&#39;t heard of libgit2 (it looks pretty recent)<br>
<br>
</div>It is.<br>
<div class="Ih2E3d"><br>
&gt; but it looks<br>
&gt; interesting -- at least stable APIs would no longer be a worry.<br>
&gt; However, I think fully managed is the way to go, from the point of<br>
&gt; view of much easier dependencies (on windows, mac, silverlight and<br>
&gt; older linux distros) and licensing.<br>
&gt;<br>
<br>
</div>But who&#39;s going to write (and separately maintain) the 50k or so LoC<br>
that will make up the git core lib in C#? It really is a waste of<br>
resources, imo. Especially since libgit will get a lot of exercise,<br>
whereas the C# code will get that of C#-based integrations only. I<br>
have a feeling this would lead to bugs (or limitations) in the C#<br>
implementation that the git community would be expected to deal with.<br>
<div class="Ih2E3d"><br>
--<br>
Andreas Ericsson &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="mailto:andreas.ericsson@op5.se">andreas.ericsson@op5.se</a><br>
OP5 AB &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="http://www.op5.se" target="_blank">www.op5.se</a><br>
Tel: +46 8-230225 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Fax: +46 8-230231<br>
_______________________________________________<br>
</div><div><div></div><div class="Wj3C7c">Monodevelop-list mailing list<br>
<a href="mailto:Monodevelop-list@lists.ximian.com">Monodevelop-list@lists.ximian.com</a><br>
<a href="http://lists.ximian.com/mailman/listinfo/monodevelop-list" target="_blank">http://lists.ximian.com/mailman/listinfo/monodevelop-list</a><br>
</div></div></blockquote></div><br>

------=_Part_1666_2226784.1226568518278--

--===============2087043969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Monodevelop-list mailing list
Monodevelop-list@lists.ximian.com
http://lists.ximian.com/mailman/listinfo/monodevelop-list

--===============2087043969==--

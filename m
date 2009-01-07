From: "Tim Visher" <tim.visher@gmail.com>
Subject: Re: Comments on Presentation Notes Request.
Date: Wed, 7 Jan 2009 11:11:43 -0500
Message-ID: <c115fd3c0901070811x323e51e4r1aae3021e6f431aa@mail.gmail.com>
References: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com>
	 <alpine.DEB.1.10.0901070030320.31038@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_156845_33074955.1231344703704"
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Wed Jan 07 17:13:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKb1u-0006ZD-Tj
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 17:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbZAGQLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 11:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbZAGQLu
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 11:11:50 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:24449 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZAGQLr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 11:11:47 -0500
Received: by an-out-0708.google.com with SMTP id d40so2719263and.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 08:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=qxSW+z7QeYm5nuJHo2n5VSwGH8832U48n96kkohDJv0=;
        b=sgDLRVnw5Y+YrPSyEETsr4y4OgbS5/xFs7u9tu0EJHuaHH3ZBW57k0onPQt7vsZodL
         7k85SHWfPOIDnjTPRFjEZf+AG0veafO4FP3TPx8rdsR/A0s1oUKuJgI547JdF4KT4eea
         7TIEjslYwFTRhDL7DYwvrY28XRr6ZZTx+JYVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=VZsr70ck/HwpqMwJvOWmApUaYtdimWJ3YlvSEuTUaRtRk4RwPrgwDx3f1FFm/UivYn
         cjzOswOW+ut413ufmfxgk1jw7U9v1lqMm+hgLa9n+aOKIjdDbdbQtCd43DJEwcapYi+/
         QXNqEti4sRumXycafm6Nhar16/cc5+TvyROhM=
Received: by 10.100.191.9 with SMTP id o9mr12545670anf.63.1231344703695;
        Wed, 07 Jan 2009 08:11:43 -0800 (PST)
Received: by 10.100.33.9 with HTTP; Wed, 7 Jan 2009 08:11:43 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.0901070030320.31038@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104808>

------=_Part_156845_33074955.1231344703704
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for the suggestions so far.  I've updated the notes.

@Peff: Thanks especially for pointing me towards Junio's
presentatation.  That's an excellent source.

Here's the patch for your suggestions:

diff --git a/scmOutline.txt b/scmOutline.txt
index 1791fa0..d25198c 100644
--- a/scmOutline.txt
+++ b/scmOutline.txt
@@ -1,4 +1,4 @@
-SCM: Distributed, Centralized, and Everything in Between.

+SCM: Centralized, Distributed, and Everything in Between.



 * What is SCM and Why is it Useful?



@@ -20,7 +20,11 @@ Not only is it unlimited, but it's random access.
If you changed a function a w


 Many people can edit the same code base at the same time and know,
without a doubt, that when they pull all those changes together, the
system will merge the content intelligently or inform you of the
conflict and let you merge it.  You don't need to lock files.
Obviously, if there is bad coordination then the possibilities of
conflicts rise, but this should not happen regularly.



-*** Diff Debugging

+*** Software Archeology

+

+With a proper SCMS, it becomes a somewhat trivial operation to
discover the author and reasons for a given change.  This is because
of the rich metadata associated with commits (author, date, complete
change set, diffs, and commentary).  So rather than wandering asking
if anyone remembers doing something and why, you simply commit that
information into the system and then refer to it when you need to.

+

+**** Diff Debugging



 You can find where a bug was introduced by learning how to reproduce
the bug and then doing a binary chop search back through the History
to come to the exact commit that introduced the bug.



@@ -30,11 +34,11 @@ You can find where a bug was introduced by
learning how to reproduce the bug and


 The more you commit, the more fine grained control you have over the
undo feature of SCM.  Most documents that I have read suggested a TDD
approach wherein you commit whenever you have written just enough code
for your test to pass. But...



-** Don't Commit Broken Code (To the Public Tree)

+** Don't _Publish_ Broken Code



 Of primary concern is the fact that your central HEAD should _always_
build.  This is why practices like Continuous Integration and TDD are
so important.  TDD gives you the freedom to be sure that a change you
made hasn't broken anything you weren't expecting it to break.
Continuous Integration allows you to be sure that your whole system
will build every time.  Thus, you should _never_ commit broken code to
the (public) tree.



-Of course, in a centralized system, committing is intrinsically
public.  Even on branches, every time you commit any sort of change,
everyone is able to see it and so you could be breaking the build for
someone (even if it's just yourself and the build system).  One of the
nice features of a distributed system is that your public/private
ontology is much richer and thus allows you to have broken code in
your SCMS.

+Of course, in a centralized system, committing is intrinsically
public.  Even on branches, every time you commit any sort of change,
everyone is able to see it and so you could be breaking the build for
someone (even if it's just yourself and the build system).  One of the
nice features of a distributed system is that your public/private
ontology is much richer and thus allows you to have broken code in
your SCMS, so long as you haven't published it, at no penalty to
anyone but yourself.



 ** Whole Hog



@@ -130,7 +134,9 @@ Once you've published, however, not much changes.
Almost everything except upda


 *** Natural Backup



-Because every developer has a copy of the repository, every developer
you add adds an extra failure point.  The more developers you have,
the more backups you have of the repository.

+Because every developer has a copy of the repository, every developer
you add adds an extra layer of redundancy.  The more developers you
have, the more backups you have of the repository.

+

+An important point to make clear here is that you only are backing up
what everyone is duplicating.  If you have 10 unpublished branches
that no one else has cloned, then those are obviously not backed up.
However, the idea here would be that anything that is being developed
actively by multiple people is backed up by as many developers.  Other
than that, your private data must be backed up by you (which is what
you do anyway, right? ;).



 *** Must Learn New Work Flows.



@@ -148,6 +154,8 @@ This bears some explanation.  Within a distributed
system, you can have a single


 Git's implementation just happens to be wickedly fast.  It's faster
than mercurial, it's faster than bazaar, etc.  Everything, committing,
merging, viewing history, branching, and even updating and and pushing
are all faster.



+This is much more important than just shaving a few seconds off the
operations.  Because Git is so much faster, you begin to do things
differently because of how fast it is.  Git's blazing fast branching
and merging wouldn't matter at all if you never branched and merged
(which is possible), but because their blazing fast you _should_ begin
to branch and merge much more often, which __does__ fundamentally
change the way you develop your code (hopefully for the better).

+

 ** Tracks Content, not Files



 Git tracks content, not files, and it's the only SCMS at the moment
that does this.  This has many effects internally, but the most
apparent effect I know of is that for the first time Git can easily
tell you the history of even a function in a file because Git can tell
you which files that function existed (or does exist) in over the
course of development.

@@ -171,9 +179,9 @@ This is very powerful yet somewhat awkward to
grasp.  Basically, the upshot of t


 I've found this to be particularly useful when working with an
existing code base that was not properly formatted.  Often, I'll come
to a file that has a bunch of wonky white space choices and improperly
indented logical constructs and I'll just quickly run through it
correcting that stuff before continuing with the feature I was working
on.  Afterwords, I'll stage the formatting and commit it, and then
stage the feature I was working on and commit that.  You may not want
that kind of control (and if you don't, you don't need to use it), but
I like it.



-** Excellent Merge algorithms

+** Stupid but _Fast_ Merge Algorithms



-Git has excellent merge algorithms.  This is widely attributed and
doesn't require much explanation.  It was one of Git's original design
goals, and it has been proven by Git's implementation.  Merging in Git
is _much_ less painful than in other systems.

+Merging in Git is _much_ less painful than in other systems.  This is
mainly because of how fast it is and how much data it remembers when
it does a merge.  As opposed to CVS which can't merge a branch twice
because it doesn't remember where the last merge happened, Git keeps
track of that information so you can merge between branches as much as
you want.  Git's philosophy is to make merging as fast and painless as
possible so that you merge early and often enough to not develop
really bad conflicts that are nearly impossible to resolve.



 ** Has powerful 'maintainer tools'



@@ -196,3 +204,4 @@ Git guarantees absolutely that if corruption
happens, you will know about it.  I
 - <http://svnbook.red-bean.com/> - Rolling publish book on
Subversion.  Chapter 1 is a good introduction to general centralized
SCM concepts and principles.

 - <http://www.perforce.com/perforce/bestpractices.html> - An
excellent set of best practices from the Perforce team.  Some of it
(especially the branches) has a distinct centralized lean, but most of
it is quite good.

 - <http://www.bobev.com/PresentationsAndPapers/Common%20SCM%20Patterns.pdf>
- Interesting presentation by Pretzel Logic from 2001 attempting to
outline some common SCM best practices as Patterns.

+- <http://members.cox.net/junkio/200607-ols.pdf> - A presentation by
Junio Hamano (the Git maintainer) at a Linux symposium on what Git is
with some tutorials.


I've also attached it as a file.  It was generated by `git diff -p`.

I'm also looking for anyplace where I'm technically inaccurate.
Unfortunately, I've written a lot of this from things that I've either
read or heard.  I'm mainly experienced with VSS and Subversion (and
both of those to a very small degree), and making a lot of progress
with Git.  I've kind of been swept away by all the energy surrounding
git right now, though, so I'm sure my judgement is somewhat clouded.

Thanks again for your help!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail

------=_Part_156845_33074955.1231344703704
Content-Type: application/octet-stream; name=suggestionsPatch01
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fpo6u2mn0
Content-Disposition: attachment; filename=suggestionsPatch01

ZGlmZiAtLWdpdCBhL3NjbU91dGxpbmUudHh0IGIvc2NtT3V0bGluZS50eHQKaW5kZXggMTc5MWZh
MC4uZDI1MTk4YyAxMDA2NDQKLS0tIGEvc2NtT3V0bGluZS50eHQKKysrIGIvc2NtT3V0bGluZS50
eHQKQEAgLTEsNCArMSw0IEBACi1TQ006IERpc3RyaWJ1dGVkLCBDZW50cmFsaXplZCwgYW5kIEV2
ZXJ5dGhpbmcgaW4gQmV0d2Vlbi4NCitTQ006IENlbnRyYWxpemVkLCBEaXN0cmlidXRlZCwgYW5k
IEV2ZXJ5dGhpbmcgaW4gQmV0d2Vlbi4NCiANCiAqIFdoYXQgaXMgU0NNIGFuZCBXaHkgaXMgaXQg
VXNlZnVsPw0KIA0KQEAgLTIwLDcgKzIwLDExIEBAIE5vdCBvbmx5IGlzIGl0IHVubGltaXRlZCwg
YnV0IGl0J3MgcmFuZG9tIGFjY2Vzcy4gIElmIHlvdSBjaGFuZ2VkIGEgZnVuY3Rpb24gYSB3CiAN
CiBNYW55IHBlb3BsZSBjYW4gZWRpdCB0aGUgc2FtZSBjb2RlIGJhc2UgYXQgdGhlIHNhbWUgdGlt
ZSBhbmQga25vdywgd2l0aG91dCBhIGRvdWJ0LCB0aGF0IHdoZW4gdGhleSBwdWxsIGFsbCB0aG9z
ZSBjaGFuZ2VzIHRvZ2V0aGVyLCB0aGUgc3lzdGVtIHdpbGwgbWVyZ2UgdGhlIGNvbnRlbnQgaW50
ZWxsaWdlbnRseSBvciBpbmZvcm0geW91IG9mIHRoZSBjb25mbGljdCBhbmQgbGV0IHlvdSBtZXJn
ZSBpdC4gIFlvdSBkb24ndCBuZWVkIHRvIGxvY2sgZmlsZXMuICBPYnZpb3VzbHksIGlmIHRoZXJl
IGlzIGJhZCBjb29yZGluYXRpb24gdGhlbiB0aGUgcG9zc2liaWxpdGllcyBvZiBjb25mbGljdHMg
cmlzZSwgYnV0IHRoaXMgc2hvdWxkIG5vdCBoYXBwZW4gcmVndWxhcmx5Lg0KIA0KLSoqKiBEaWZm
IERlYnVnZ2luZw0KKyoqKiBTb2Z0d2FyZSBBcmNoZW9sb2d5DQorDQorV2l0aCBhIHByb3BlciBT
Q01TLCBpdCBiZWNvbWVzIGEgc29tZXdoYXQgdHJpdmlhbCBvcGVyYXRpb24gdG8gZGlzY292ZXIg
dGhlIGF1dGhvciBhbmQgcmVhc29ucyBmb3IgYSBnaXZlbiBjaGFuZ2UuICBUaGlzIGlzIGJlY2F1
c2Ugb2YgdGhlIHJpY2ggbWV0YWRhdGEgYXNzb2NpYXRlZCB3aXRoIGNvbW1pdHMgKGF1dGhvciwg
ZGF0ZSwgY29tcGxldGUgY2hhbmdlIHNldCwgZGlmZnMsIGFuZCBjb21tZW50YXJ5KS4gIFNvIHJh
dGhlciB0aGFuIHdhbmRlcmluZyBhc2tpbmcgaWYgYW55b25lIHJlbWVtYmVycyBkb2luZyBzb21l
dGhpbmcgYW5kIHdoeSwgeW91IHNpbXBseSBjb21taXQgdGhhdCBpbmZvcm1hdGlvbiBpbnRvIHRo
ZSBzeXN0ZW0gYW5kIHRoZW4gcmVmZXIgdG8gaXQgd2hlbiB5b3UgbmVlZCB0by4NCisNCisqKioq
IERpZmYgRGVidWdnaW5nDQogDQogWW91IGNhbiBmaW5kIHdoZXJlIGEgYnVnIHdhcyBpbnRyb2R1
Y2VkIGJ5IGxlYXJuaW5nIGhvdyB0byByZXByb2R1Y2UgdGhlIGJ1ZyBhbmQgdGhlbiBkb2luZyBh
IGJpbmFyeSBjaG9wIHNlYXJjaCBiYWNrIHRocm91Z2ggdGhlIEhpc3RvcnkgdG8gY29tZSB0byB0
aGUgZXhhY3QgY29tbWl0IHRoYXQgaW50cm9kdWNlZCB0aGUgYnVnLg0KIA0KQEAgLTMwLDExICsz
NCwxMSBAQCBZb3UgY2FuIGZpbmQgd2hlcmUgYSBidWcgd2FzIGludHJvZHVjZWQgYnkgbGVhcm5p
bmcgaG93IHRvIHJlcHJvZHVjZSB0aGUgYnVnIGFuZAogDQogVGhlIG1vcmUgeW91IGNvbW1pdCwg
dGhlIG1vcmUgZmluZSBncmFpbmVkIGNvbnRyb2wgeW91IGhhdmUgb3ZlciB0aGUgdW5kbyBmZWF0
dXJlIG9mIFNDTS4gIE1vc3QgZG9jdW1lbnRzIHRoYXQgSSBoYXZlIHJlYWQgc3VnZ2VzdGVkIGEg
VEREIGFwcHJvYWNoIHdoZXJlaW4geW91IGNvbW1pdCB3aGVuZXZlciB5b3UgaGF2ZSB3cml0dGVu
IGp1c3QgZW5vdWdoIGNvZGUgZm9yIHlvdXIgdGVzdCB0byBwYXNzLiBCdXQuLi4NCiANCi0qKiBE
b24ndCBDb21taXQgQnJva2VuIENvZGUgKFRvIHRoZSBQdWJsaWMgVHJlZSkNCisqKiBEb24ndCBf
UHVibGlzaF8gQnJva2VuIENvZGUNCiANCiBPZiBwcmltYXJ5IGNvbmNlcm4gaXMgdGhlIGZhY3Qg
dGhhdCB5b3VyIGNlbnRyYWwgSEVBRCBzaG91bGQgX2Fsd2F5c18gYnVpbGQuICBUaGlzIGlzIHdo
eSBwcmFjdGljZXMgbGlrZSBDb250aW51b3VzIEludGVncmF0aW9uIGFuZCBUREQgYXJlIHNvIGlt
cG9ydGFudC4gIFRERCBnaXZlcyB5b3UgdGhlIGZyZWVkb20gdG8gYmUgc3VyZSB0aGF0IGEgY2hh
bmdlIHlvdSBtYWRlIGhhc24ndCBicm9rZW4gYW55dGhpbmcgeW91IHdlcmVuJ3QgZXhwZWN0aW5n
IGl0IHRvIGJyZWFrLiAgQ29udGludW91cyBJbnRlZ3JhdGlvbiBhbGxvd3MgeW91IHRvIGJlIHN1
cmUgdGhhdCB5b3VyIHdob2xlIHN5c3RlbSB3aWxsIGJ1aWxkIGV2ZXJ5IHRpbWUuICBUaHVzLCB5
b3Ugc2hvdWxkIF9uZXZlcl8gY29tbWl0IGJyb2tlbiBjb2RlIHRvIHRoZSAocHVibGljKSB0cmVl
Lg0KIA0KLU9mIGNvdXJzZSwgaW4gYSBjZW50cmFsaXplZCBzeXN0ZW0sIGNvbW1pdHRpbmcgaXMg
aW50cmluc2ljYWxseSBwdWJsaWMuICBFdmVuIG9uIGJyYW5jaGVzLCBldmVyeSB0aW1lIHlvdSBj
b21taXQgYW55IHNvcnQgb2YgY2hhbmdlLCBldmVyeW9uZSBpcyBhYmxlIHRvIHNlZSBpdCBhbmQg
c28geW91IGNvdWxkIGJlIGJyZWFraW5nIHRoZSBidWlsZCBmb3Igc29tZW9uZSAoZXZlbiBpZiBp
dCdzIGp1c3QgeW91cnNlbGYgYW5kIHRoZSBidWlsZCBzeXN0ZW0pLiAgT25lIG9mIHRoZSBuaWNl
IGZlYXR1cmVzIG9mIGEgZGlzdHJpYnV0ZWQgc3lzdGVtIGlzIHRoYXQgeW91ciBwdWJsaWMvcHJp
dmF0ZSBvbnRvbG9neSBpcyBtdWNoIHJpY2hlciBhbmQgdGh1cyBhbGxvd3MgeW91IHRvIGhhdmUg
YnJva2VuIGNvZGUgaW4geW91ciBTQ01TLg0KK09mIGNvdXJzZSwgaW4gYSBjZW50cmFsaXplZCBz
eXN0ZW0sIGNvbW1pdHRpbmcgaXMgaW50cmluc2ljYWxseSBwdWJsaWMuICBFdmVuIG9uIGJyYW5j
aGVzLCBldmVyeSB0aW1lIHlvdSBjb21taXQgYW55IHNvcnQgb2YgY2hhbmdlLCBldmVyeW9uZSBp
cyBhYmxlIHRvIHNlZSBpdCBhbmQgc28geW91IGNvdWxkIGJlIGJyZWFraW5nIHRoZSBidWlsZCBm
b3Igc29tZW9uZSAoZXZlbiBpZiBpdCdzIGp1c3QgeW91cnNlbGYgYW5kIHRoZSBidWlsZCBzeXN0
ZW0pLiAgT25lIG9mIHRoZSBuaWNlIGZlYXR1cmVzIG9mIGEgZGlzdHJpYnV0ZWQgc3lzdGVtIGlz
IHRoYXQgeW91ciBwdWJsaWMvcHJpdmF0ZSBvbnRvbG9neSBpcyBtdWNoIHJpY2hlciBhbmQgdGh1
cyBhbGxvd3MgeW91IHRvIGhhdmUgYnJva2VuIGNvZGUgaW4geW91ciBTQ01TLCBzbyBsb25nIGFz
IHlvdSBoYXZlbid0IHB1Ymxpc2hlZCBpdCwgYXQgbm8gcGVuYWx0eSB0byBhbnlvbmUgYnV0IHlv
dXJzZWxmLg0KIA0KICoqIFdob2xlIEhvZw0KIA0KQEAgLTEzMCw3ICsxMzQsOSBAQCBPbmNlIHlv
dSd2ZSBwdWJsaXNoZWQsIGhvd2V2ZXIsIG5vdCBtdWNoIGNoYW5nZXMuICBBbG1vc3QgZXZlcnl0
aGluZyBleGNlcHQgdXBkYQogDQogKioqIE5hdHVyYWwgQmFja3VwDQogDQotQmVjYXVzZSBldmVy
eSBkZXZlbG9wZXIgaGFzIGEgY29weSBvZiB0aGUgcmVwb3NpdG9yeSwgZXZlcnkgZGV2ZWxvcGVy
IHlvdSBhZGQgYWRkcyBhbiBleHRyYSBmYWlsdXJlIHBvaW50LiAgVGhlIG1vcmUgZGV2ZWxvcGVy
cyB5b3UgaGF2ZSwgdGhlIG1vcmUgYmFja3VwcyB5b3UgaGF2ZSBvZiB0aGUgcmVwb3NpdG9yeS4g
IA0KK0JlY2F1c2UgZXZlcnkgZGV2ZWxvcGVyIGhhcyBhIGNvcHkgb2YgdGhlIHJlcG9zaXRvcnks
IGV2ZXJ5IGRldmVsb3BlciB5b3UgYWRkIGFkZHMgYW4gZXh0cmEgbGF5ZXIgb2YgcmVkdW5kYW5j
eS4gIFRoZSBtb3JlIGRldmVsb3BlcnMgeW91IGhhdmUsIHRoZSBtb3JlIGJhY2t1cHMgeW91IGhh
dmUgb2YgdGhlIHJlcG9zaXRvcnkuICANCisNCitBbiBpbXBvcnRhbnQgcG9pbnQgdG8gbWFrZSBj
bGVhciBoZXJlIGlzIHRoYXQgeW91IG9ubHkgYXJlIGJhY2tpbmcgdXAgd2hhdCBldmVyeW9uZSBp
cyBkdXBsaWNhdGluZy4gIElmIHlvdSBoYXZlIDEwIHVucHVibGlzaGVkIGJyYW5jaGVzIHRoYXQg
bm8gb25lIGVsc2UgaGFzIGNsb25lZCwgdGhlbiB0aG9zZSBhcmUgb2J2aW91c2x5IG5vdCBiYWNr
ZWQgdXAuICBIb3dldmVyLCB0aGUgaWRlYSBoZXJlIHdvdWxkIGJlIHRoYXQgYW55dGhpbmcgdGhh
dCBpcyBiZWluZyBkZXZlbG9wZWQgYWN0aXZlbHkgYnkgbXVsdGlwbGUgcGVvcGxlIGlzIGJhY2tl
ZCB1cCBieSBhcyBtYW55IGRldmVsb3BlcnMuICBPdGhlciB0aGFuIHRoYXQsIHlvdXIgcHJpdmF0
ZSBkYXRhIG11c3QgYmUgYmFja2VkIHVwIGJ5IHlvdSAod2hpY2ggaXMgd2hhdCB5b3UgZG8gYW55
d2F5LCByaWdodD8gOykuDQogDQogKioqIE11c3QgTGVhcm4gTmV3IFdvcmsgRmxvd3MuDQogDQpA
QCAtMTQ4LDYgKzE1NCw4IEBAIFRoaXMgYmVhcnMgc29tZSBleHBsYW5hdGlvbi4gIFdpdGhpbiBh
IGRpc3RyaWJ1dGVkIHN5c3RlbSwgeW91IGNhbiBoYXZlIGEgc2luZ2xlCiANCiBHaXQncyBpbXBs
ZW1lbnRhdGlvbiBqdXN0IGhhcHBlbnMgdG8gYmUgd2lja2VkbHkgZmFzdC4gIEl0J3MgZmFzdGVy
IHRoYW4gbWVyY3VyaWFsLCBpdCdzIGZhc3RlciB0aGFuIGJhemFhciwgZXRjLiAgRXZlcnl0aGlu
ZywgY29tbWl0dGluZywgbWVyZ2luZywgdmlld2luZyBoaXN0b3J5LCBicmFuY2hpbmcsIGFuZCBl
dmVuIHVwZGF0aW5nIGFuZCBhbmQgcHVzaGluZyBhcmUgYWxsIGZhc3Rlci4NCiANCitUaGlzIGlz
IG11Y2ggbW9yZSBpbXBvcnRhbnQgdGhhbiBqdXN0IHNoYXZpbmcgYSBmZXcgc2Vjb25kcyBvZmYg
dGhlIG9wZXJhdGlvbnMuICBCZWNhdXNlIEdpdCBpcyBzbyBtdWNoIGZhc3RlciwgeW91IGJlZ2lu
IHRvIGRvIHRoaW5ncyBkaWZmZXJlbnRseSBiZWNhdXNlIG9mIGhvdyBmYXN0IGl0IGlzLiAgR2l0
J3MgYmxhemluZyBmYXN0IGJyYW5jaGluZyBhbmQgbWVyZ2luZyB3b3VsZG4ndCBtYXR0ZXIgYXQg
YWxsIGlmIHlvdSBuZXZlciBicmFuY2hlZCBhbmQgbWVyZ2VkICh3aGljaCBpcyBwb3NzaWJsZSks
IGJ1dCBiZWNhdXNlIHRoZWlyIGJsYXppbmcgZmFzdCB5b3UgX3Nob3VsZF8gYmVnaW4gdG8gYnJh
bmNoIGFuZCBtZXJnZSBtdWNoIG1vcmUgb2Z0ZW4sIHdoaWNoIF9fZG9lc19fIGZ1bmRhbWVudGFs
bHkgY2hhbmdlIHRoZSB3YXkgeW91IGRldmVsb3AgeW91ciBjb2RlIChob3BlZnVsbHkgZm9yIHRo
ZSBiZXR0ZXIpLg0KKw0KICoqIFRyYWNrcyBDb250ZW50LCBub3QgRmlsZXMNCiANCiBHaXQgdHJh
Y2tzIGNvbnRlbnQsIG5vdCBmaWxlcywgYW5kIGl0J3MgdGhlIG9ubHkgU0NNUyBhdCB0aGUgbW9t
ZW50IHRoYXQgZG9lcyB0aGlzLiAgVGhpcyBoYXMgbWFueSBlZmZlY3RzIGludGVybmFsbHksIGJ1
dCB0aGUgbW9zdCBhcHBhcmVudCBlZmZlY3QgSSBrbm93IG9mIGlzIHRoYXQgZm9yIHRoZSBmaXJz
dCB0aW1lIEdpdCBjYW4gZWFzaWx5IHRlbGwgeW91IHRoZSBoaXN0b3J5IG9mIGV2ZW4gYSBmdW5j
dGlvbiBpbiBhIGZpbGUgYmVjYXVzZSBHaXQgY2FuIHRlbGwgeW91IHdoaWNoIGZpbGVzIHRoYXQg
ZnVuY3Rpb24gZXhpc3RlZCAob3IgZG9lcyBleGlzdCkgaW4gb3ZlciB0aGUgY291cnNlIG9mIGRl
dmVsb3BtZW50Lg0KQEAgLTE3MSw5ICsxNzksOSBAQCBUaGlzIGlzIHZlcnkgcG93ZXJmdWwgeWV0
IHNvbWV3aGF0IGF3a3dhcmQgdG8gZ3Jhc3AuICBCYXNpY2FsbHksIHRoZSB1cHNob3Qgb2YgdAog
DQogSSd2ZSBmb3VuZCB0aGlzIHRvIGJlIHBhcnRpY3VsYXJseSB1c2VmdWwgd2hlbiB3b3JraW5n
IHdpdGggYW4gZXhpc3RpbmcgY29kZSBiYXNlIHRoYXQgd2FzIG5vdCBwcm9wZXJseSBmb3JtYXR0
ZWQuICBPZnRlbiwgSSdsbCBjb21lIHRvIGEgZmlsZSB0aGF0IGhhcyBhIGJ1bmNoIG9mIHdvbmt5
IHdoaXRlIHNwYWNlIGNob2ljZXMgYW5kIGltcHJvcGVybHkgaW5kZW50ZWQgbG9naWNhbCBjb25z
dHJ1Y3RzIGFuZCBJJ2xsIGp1c3QgcXVpY2tseSBydW4gdGhyb3VnaCBpdCBjb3JyZWN0aW5nIHRo
YXQgc3R1ZmYgYmVmb3JlIGNvbnRpbnVpbmcgd2l0aCB0aGUgZmVhdHVyZSBJIHdhcyB3b3JraW5n
IG9uLiAgQWZ0ZXJ3b3JkcywgSSdsbCBzdGFnZSB0aGUgZm9ybWF0dGluZyBhbmQgY29tbWl0IGl0
LCBhbmQgdGhlbiBzdGFnZSB0aGUgZmVhdHVyZSBJIHdhcyB3b3JraW5nIG9uIGFuZCBjb21taXQg
dGhhdC4gIFlvdSBtYXkgbm90IHdhbnQgdGhhdCBraW5kIG9mIGNvbnRyb2wgKGFuZCBpZiB5b3Ug
ZG9uJ3QsIHlvdSBkb24ndCBuZWVkIHRvIHVzZSBpdCksIGJ1dCBJIGxpa2UgaXQuDQogDQotKiog
RXhjZWxsZW50IE1lcmdlIGFsZ29yaXRobXMNCisqKiBTdHVwaWQgYnV0IF9GYXN0XyBNZXJnZSBB
bGdvcml0aG1zDQogDQotR2l0IGhhcyBleGNlbGxlbnQgbWVyZ2UgYWxnb3JpdGhtcy4gIFRoaXMg
aXMgd2lkZWx5IGF0dHJpYnV0ZWQgYW5kIGRvZXNuJ3QgcmVxdWlyZSBtdWNoIGV4cGxhbmF0aW9u
LiAgSXQgd2FzIG9uZSBvZiBHaXQncyBvcmlnaW5hbCBkZXNpZ24gZ29hbHMsIGFuZCBpdCBoYXMg
YmVlbiBwcm92ZW4gYnkgR2l0J3MgaW1wbGVtZW50YXRpb24uICBNZXJnaW5nIGluIEdpdCBpcyBf
bXVjaF8gbGVzcyBwYWluZnVsIHRoYW4gaW4gb3RoZXIgc3lzdGVtcy4NCitNZXJnaW5nIGluIEdp
dCBpcyBfbXVjaF8gbGVzcyBwYWluZnVsIHRoYW4gaW4gb3RoZXIgc3lzdGVtcy4gIFRoaXMgaXMg
bWFpbmx5IGJlY2F1c2Ugb2YgaG93IGZhc3QgaXQgaXMgYW5kIGhvdyBtdWNoIGRhdGEgaXQgcmVt
ZW1iZXJzIHdoZW4gaXQgZG9lcyBhIG1lcmdlLiAgQXMgb3Bwb3NlZCB0byBDVlMgd2hpY2ggY2Fu
J3QgbWVyZ2UgYSBicmFuY2ggdHdpY2UgYmVjYXVzZSBpdCBkb2Vzbid0IHJlbWVtYmVyIHdoZXJl
IHRoZSBsYXN0IG1lcmdlIGhhcHBlbmVkLCBHaXQga2VlcHMgdHJhY2sgb2YgdGhhdCBpbmZvcm1h
dGlvbiBzbyB5b3UgY2FuIG1lcmdlIGJldHdlZW4gYnJhbmNoZXMgYXMgbXVjaCBhcyB5b3Ugd2Fu
dC4gIEdpdCdzIHBoaWxvc29waHkgaXMgdG8gbWFrZSBtZXJnaW5pbmcgYXMgZmFzdCBhbmQgcGFp
bmxlc3MgYXMgcG9zc2libGUgc28gdGhhdCB5b3UgbWVyZ2UgZWFybHkgYW5kIG9mdGVuIGVub3Vn
aCB0byBub3QgZGV2ZWxvcCByZWFsbHkgYmFkIGNvbmZsaWN0cyB0aGF0IGFyZSBuZWFybHkgaW1w
b3NzaWJsZSB0byByZXNvbHZlLg0KIA0KICoqIEhhcyBwb3dlcmZ1bCAnbWFpbnRhaW5lciB0b29s
cycNCiANCkBAIC0xOTYsMyArMjA0LDQgQEAgR2l0IGd1YXJhbnRlZXMgYWJzb2x1dGVseSB0aGF0
IGlmIGNvcnJ1cHRpb24gaGFwcGVucywgeW91IHdpbGwga25vdyBhYm91dCBpdC4gIEkKIC0gPGh0
dHA6Ly9zdm5ib29rLnJlZC1iZWFuLmNvbS8+IC0gUm9sbGluZyBwdWJsaXNoIGJvb2sgb24gU3Vi
dmVyc2lvbi4gIENoYXB0ZXIgMSBpcyBhIGdvb2QgaW50cm9kdWN0aW9uIHRvIGdlbmVyYWwgY2Vu
dHJhbGl6ZWQgU0NNIGNvbmNlcHRzIGFuZCBwcmluY2lwbGVzLg0KIC0gPGh0dHA6Ly93d3cucGVy
Zm9yY2UuY29tL3BlcmZvcmNlL2Jlc3RwcmFjdGljZXMuaHRtbD4gLSBBbiBleGNlbGxlbnQgc2V0
IG9mIGJlc3QgcHJhY3RpY2VzIGZyb20gdGhlIFBlcmZvcmNlIHRlYW0uICBTb21lIG9mIGl0IChl
c3BlY2lhbGx5IHRoZSBicmFuY2hlcykgaGFzIGEgZGlzdGluY3QgY2VudHJhbGl6ZWQgbGVhbiwg
YnV0IG1vc3Qgb2YgaXQgaXMgcXVpdGUgZ29vZC4NCiAtIDxodHRwOi8vd3d3LmJvYmV2LmNvbS9Q
cmVzZW50YXRpb25zQW5kUGFwZXJzL0NvbW1vbiUyMFNDTSUyMFBhdHRlcm5zLnBkZj4gLSBJbnRl
cmVzdGluZyBwcmVzZW50YXRpb24gYnkgUHJldHplbCBMb2dpYyBmcm9tIDIwMDEgYXR0ZW1wdGlu
ZyB0byBvdXRsaW5lIHNvbWUgY29tbW9uIFNDTSBiZXN0IHByYWN0aWNlcyBhcyBQYXR0ZXJucy4N
CistIDxodHRwOi8vbWVtYmVycy5jb3gubmV0L2p1bmtpby8yMDA2MDctb2xzLnBkZj4gLSBBIHBy
ZXNlbnRhdGlvbiBieSBKdW5pbyBIYW1hbm8gKHRoZSBHaXQgbWFpbnRhaW5lcikgYXQgYSBMaW51
eCBzeW1wb3NpdW0gb24gd2hhdCBHaXQgaXMgd2l0aCBzb21lIHR1dG9yaWFscy4NCg==
------=_Part_156845_33074955.1231344703704--

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 2/1] fixup! Documentation: start to explain what git
 replace is for
Date: Fri, 14 Jan 2011 02:49:03 -0600
Message-ID: <20110114084903.GD11343@burratino>
References: <746745466.20110111134101@mail.ru>
 <m3lj2rbmq5.fsf@localhost.localdomain>
 <20110112000812.GA31950@burratino>
 <loom.20110112T232501-316@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Aleksey Shumkin <zapped@mail.ru>
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Fri Jan 14 09:49:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdfLc-0003dU-GA
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 09:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757391Ab1ANItY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jan 2011 03:49:24 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33802 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab1ANItW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 03:49:22 -0500
Received: by gwj20 with SMTP id 20so1029190gwj.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 00:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ezPwU/IACMqsoQJGCjWBYv3mw0Y9TXz0XvEWZ1NTOMA=;
        b=JCRZrls5I4tejHhxPSdxjqvxWiIlYnNMyVu+97AFDkNTbmqmoEuHRFOc3csu/x5hSj
         YpOnyqeh4I/5/NuPsugfIi6LKlIbv6m0QhQnIRzt4cdrM0tcLaPDcGw4A9PScytW9EI3
         MUQQLXCGCVl3HxzYBYsMPlZOVCLWpsru0LJqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AUroFCOfYiGK27Pq2HaJd+rQym3a0pYIgi4aN7lK7w7UIhIR7qLzKY56tlaaPk2HKC
         vXD2sIhqh/aH3zeo5ipMb+p1QZNNSK5A4Pf3n1t5SMr/7zUG4RbOA+Sarpf6iwyzbdTH
         pOMJ2zkIBOFgkxLWHWUHpBJDDjV9AeTlTKVgg=
Received: by 10.236.103.37 with SMTP id e25mr1050345yhg.25.1294994961798;
        Fri, 14 Jan 2011 00:49:21 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id a79sm647676yhd.45.2011.01.14.00.49.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 00:49:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20110112T232501-316@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165081>

Some tweaks suggested by Maaartin:

- use a transliteration for Aleksey's name. =20
- clarify that there will only be one parentless commit in a typical
  branch
- use variables so the recipe is easier to test by copy and paste
- remove unintended "-i" argument to sed

While at it, make a few miscellaneous grammar tweaks and make sure
each line of the example raw commit appears on a separate line.
The formatting is still not great for that --- there is too much
space between lines.

Still to do: check whether this actually works and add a test script
to make sure it keeps working.

Improved-by: Maaartin <grajcar1@seznam.cz>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Can be tested with

	make -C Documentation git-replace.1
	man Documentation/git-replace.1

=2E

Maaartin wrote:
> Jonathan Nieder writes:
[side note: please do not prune the cc list; I only stumbled on this
message in the online archive by luck]

>> +. The following example comes from ??????? ??????:
>
> I know unicode exists already for many years, but in cygwin I get jus=
t a bunch=20
> of question marks instead of the name. So I'd suggest to replace "=D0=
=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9=20
> =D0=A8=D1=83=D0=BC=D0=BA=D0=B8=D0=BD" by "Alexej Shumkin" or whatever=
 his preferred transcription is.

Makes sense.

>> +<1> Find all parentless commits in the 'master' branch;
>> +for 'master' read the branch holding v2.5 history.
>
> Aren't you later calling it "FIRST" and assuming there's only one?

Hmm.  I want to say that there _could_ be multiple parentless commits
in the v2.5 history and we are treating one of them as its root (just
like git master has multiple parentless ancestors but e83c5163 is
conventionally considered its beginning).  Not sure how to write that
clearly.

> Isn't the combination of "-i" (=3Din-place edit) with redirection wro=
ng?

Good catch (the "-i" is a typo).

> +$ objectId=3D$(git hash-object -t commit -w new)
> +$ git replace FIRST $objectId
>
> This is easier for people just willing to use it without much thinkin=
g, and=20
> also for those having no idea that git-hash-object creates a new obje=
ct.

Right, thanks.

 Documentation/git-replace.txt |   40 ++++++++++++++++++++++-----------=
-------
 1 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.=
txt
index 02e5de8..5829901 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -68,16 +68,17 @@ $ git cat-file commit foo                      <3>
 <2> show information about the true commit 'foo'
 <3> show information about the replacement commit 'bar'
=20
-. The following example comes from =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=
=D0=B9 =D0=A8=D1=83=D0=BC=D0=BA=D0=B8=D0=BD:
+. The following example comes from Aleksey Shumkin:
 +
 1.5 years ago I had sources of a project in another version control
 system.  And I had two branches: v2.4 and v2.5.
-They differed enough at that moment and laid in two different folders.
+They differed enough at that moment and lay in two different folders.
 Then I learned about Git and I decided to try to use this DVCS.
 I created two git repositories: one for each branch.
-So v2.4 has its own git repo and v2.5 (and above) has another one.
+So v2.4 has one git repo and v2.5 (and above) has another one.
 +
-Now I'd like to merge them as v2.5 was a continuous branch from v2.4,
+Now I'd like to merge them as if v2.5 were a continuous development
+from v2.4,
 but without rebasing (i.e. without a global change to the v2.5
 repository, which already has other branches).  It should look like
 the last commit of from the v2.4 branch is a parent of the first
@@ -89,25 +90,28 @@ use the more modern replace mechanism.  Below are u=
ntested step-by-step
 instructions.
 +
 --------------------------------------------------
-$ git rev-list master --parents | grep -v ' '    <1>
-$ git rev-parse v2.4                             <2>
-$ git cat-file commit FIRST >tmp                 <3>
-$ sed -i "/^tree / a \\
-parent $(git rev-parse v2.4)" <tmp >new          <4>
-$ git hash-object -t commit -w new               <5>
-$ git replace FIRST <object id from hash-object> <6>
-$ git show FIRST
-$ git log --graph --oneline -3 FIRST             <7>
+$ git rev-list master --parents | grep -v ' '
+$ first=3D$(git rev-list master --parents | grep -v ' ') <1>
+$ git rev-parse v2.4                                   <2>
+$ git cat-file commit $first >tmp                      <3>
+$ sed "/^tree / a \\
+parent $(git rev-parse v2.4)" <tmp >new                <4>
+$ new_commit=3D$(git hash-object -t commit -w new)       <5>
+$ git replace $first $new_commit                       <6>
+$ git show $first
+$ git log --graph --oneline -3 $first                  <7>
 --------------------------------------------------
 +
-<1> Find all parentless commits in the 'master' branch;
-for 'master' read the branch holding v2.5 history.
+<1> List all parentless commits in the 'master' branch and
+call the appropriate one (in this case the only one) $first.
+Instead of 'master' one would use the branch holding v2.5
+history.
 <2> Find the last commit of v2.4.
 <3> Save the current state of the first commit of v2.5 to a file.
 <4> Edit this file, adding 'parent' line between 'tree' and 'author'
-headers, so the header of this file looks like the following:
-  tree 13d050266e05f7c66000240814199fcf3b559d43
-  parent ada9983c4256f5a7bac1f7f0e29d52011741d6aa
+headers, so the header of this file looks like the following: +
+  tree 13d050266e05f7c66000240814199fcf3b559d43 +
+  parent ada9983c4256f5a7bac1f7f0e29d52011741d6aa +
   author Jakub Narebski <jnareb@gmail.com> 1294231771 +0100
 <5> Add the newly created object to the repository.
 <6> Use it as a replacement.
--=20
1.7.4.rc2

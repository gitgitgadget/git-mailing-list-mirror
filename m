From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] Documentation: clarify branch creation
Date: Fri, 9 Oct 2009 13:34:08 -0500
Message-ID: <20091009183408.GB2477@progeny.tock>
References: <20091009101400.GA16549@progeny.tock>
 <20091009101940.GG16558@progeny.tock>
 <BLU0-SMTP425A9541141B09D790814EAECB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Fri Oct 09 20:29:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwKDt-0003Cy-DG
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 20:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761240AbZJIS0h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 14:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761151AbZJIS0g
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 14:26:36 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:38020 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759101AbZJIS0g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 14:26:36 -0400
Received: by bwz6 with SMTP id 6so1802331bwz.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1zbR7RBmjWsvfg9s/3fHco5GL9mF0rr1LWA2ZmVupJo=;
        b=ACceHHJfW5v1Ba1vajhWGkAK7yysC0Vazst3tnFb/47xh7D6whCDA2Ay9OWNYavXE5
         SaqZQnfsTzTRMDWEU5gjanHOmdxG+v5bDYOqO6fWwve/IE0TIZyaqfEhJPrwsYRvSyFs
         YtCGMUfrPbraHBzsdrg2spKm9iAcNQcV3cHIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=h1SKsMnhRwBDqMwm10IjWeVheS+p8xiOM1GIOyWuQgT5QKqWtrKmw83n7d+LwJ64NR
         779OtJwIsH+FJEgkFmStGuzD4sNJD+M/vGRFb0pjw4f6oNnVCW2OPQ0PHeAEhBB363+1
         U1JO518WNJAvbZt4xp3u8mTNa5eTSGVDCjg6Q=
Received: by 10.103.84.32 with SMTP id m32mr1249102mul.33.1255112758608;
        Fri, 09 Oct 2009 11:25:58 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id y6sm536832mug.40.2009.10.09.11.25.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 11:25:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP425A9541141B09D790814EAECB0@phx.gbl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129829>

Sean Estabrooks wrote:
> On Fri, 9 Oct 2009 05:19:40 -0500
> Jonathan Nieder <jrnieder@gmail.com> wrote:
>=20
> > +In the command's second form, creates a new branch named <branchna=
me>.
> > +The branch will start out with head pointing to the commit
> > +<start-point>.  If no <start-point> is given, the branch will star=
t
> > +out with head pointing to the tip of the currently checked out bra=
nch,
> > +or the currently checked out commit if no branch is checked out.
>=20
> The first sentence here doesn't quite work, perhaps drop the "In".  B=
ut
> the whole thing is a bit verbose, what about just:
>=20
> The command's second form creates a new branch named <branchname> whi=
ch
> points to the current HEAD or <start-point> if given.

Makes sense.  I modified this slightly to =E2=80=9Cnew branch head=E2=80=
=9D since the
branch itself does not point to anything.

> >  <start-point>::
> > -	The new branch will be created with a HEAD equal to this.  It may
> > -	be given as a branch name, a commit-id, or a tag.  If this option
> > -	is omitted, the current branch is assumed.
> > +	The new branch head will point to this commit.  It may be
> > +	given as a branch name, a commit-id, or a tag.  If this
> > +	option is omitted, the currently checked out branch head
> > +	is used, or the current commit if no branch is checked
> > +	out.
>=20
> Maybe it's not worth worrying about, but couldn't the last sentence
> be just:
>=20
>    If this option is omitted, the current HEAD will be used instead.

That sounds better, thanks.  The reader that does not know what HEAD is
probably needs to read the relevant section of the user manual for othe=
r
reasons anyway.

So this page should probably point to the what-is-a-branch section of
the User's Manual.  Maybe something like this?

-- %< --
Subject: Documentation: clarify branch creation

The documentation seems to assume that the starting point for a new
branch is the tip of an existing (ordinary) branch, but that is not
the most common case.  More often, "git branch" is used to begin
a branch from a remote-tracking branch, a tag, or an interesting
commit (e.g. origin/pu^2).  Clarify the language so it can apply
to these cases.  Thanks to Sean Estabrooks for the wording.

Also add a pointer to the user's manual for the bewildered.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-branch.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index e8b32a2..f766b4d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -30,10 +30,8 @@ commit) will be listed.  With `--no-merged` only bra=
nches not merged into
 the named commit will be listed.  If the <commit> argument is missing =
it
 defaults to 'HEAD' (i.e. the tip of the current branch).
=20
-In the command's second form, a new branch named <branchname> will be =
created.
-It will start out with a head equal to the one given as <start-point>.
-If no <start-point> is given, the branch will be created with a head
-equal to that of the currently checked out branch.
+The command's second form creates a new branch head named <branchname>
+which points to the current 'HEAD', or <start-point> if given.
=20
 Note that this will create the new branch, but it will not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
@@ -149,9 +147,9 @@ start-point is either a local or remote branch.
 	may restrict the characters allowed in a branch name.
=20
 <start-point>::
-	The new branch will be created with a HEAD equal to this.  It may
-	be given as a branch name, a commit-id, or a tag.  If this option
-	is omitted, the current branch is assumed.
+	The new branch head will point to this commit.  It may be
+	given as a branch name, a commit-id, or a tag.  If this
+	option is omitted, the current HEAD will be used instead.
=20
 <oldbranch>::
 	The name of an existing branch to rename.
@@ -216,7 +214,9 @@ SEE ALSO
 --------
 linkgit:git-check-ref-format[1],
 linkgit:git-fetch[1],
-linkgit:git-remote[1].
+linkgit:git-remote[1],
+link:user-manual.html#what-is-a-branch[``Understanding history: What i=
s
+a branch?''] in the Git User's Manual.
=20
 Author
 ------
--=20
1.6.5.rc1.199.g596ec

From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: git instaweb - share all project files
Date: Sat, 13 Apr 2013 17:21:54 +0200
Message-ID: <51697812.6020106@gmail.com>
References: <CAMg8Y2pFXrbh8cz6m5z=LsksRijLVcV4fTk-TBx+9yaQTtAzpA@mail.gmail.com> <51659B5B.6000707@gmail.com> <CAMg8Y2qm9FuuMZh7jsAEyr=joUbsp=5V_zU5U86sW0Y=f2OVBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: "Trenton D. Adams" <trenton.d.adams@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 17:22:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR2HD-0006KQ-Gj
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 17:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114Ab3DMPV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Apr 2013 11:21:59 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:62130 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab3DMPV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 11:21:58 -0400
Received: by mail-ea0-f177.google.com with SMTP id q14so1577378eaj.36
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=x9oui713VYUIg0DFyy7AdKwpXi4bVXr50F1N0dm7+2o=;
        b=dgcs/N9Oo/jg5wWKJLrWwSkGn2LDX5gvAgy0PFp42uBCGqHwmLeqi2AsQfEa3YfzI6
         fXaGmZD7ECWnGBM7avVjF4NGRS82xRNvM2xYZfiEQvYqk3DB2hdaWzT/HpPHXm6djrWC
         Ma5D+W/IAvJ+9MCtIUr5EYMfiAJDk02dhkPgseosbyJ1TGipOydoq8RfS5ndPavhgRJL
         UTRae06qFp4fzco7EHQ/ogkxokCgVZKBHFSArdDcYXjIsdIFH/7IoL6pHTkmky0fGi+f
         mznnueT81WHbtO7fz81YeYInaPlOmBLfrJcbK4Tq0a1dLHaRykS7OTH9kZ9LDqcoLeak
         y6vQ==
X-Received: by 10.15.81.136 with SMTP id x8mr40956680eey.9.1365866517276;
        Sat, 13 Apr 2013 08:21:57 -0700 (PDT)
Received: from [192.168.1.14] (deh97.neoplus.adsl.tpnet.pl. [83.23.111.97])
        by mx.google.com with ESMTPS id t4sm16977323eel.0.2013.04.13.08.21.55
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Apr 2013 08:21:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAMg8Y2qm9FuuMZh7jsAEyr=joUbsp=5V_zU5U86sW0Y=f2OVBA@mail.gmail.com>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221064>

Please do not top-post.

On 11.04.2013, Trenton D. Adams wrote:

> #1 would actually work.  Though long term it would be cool to view it
> with all the most recent commit information, kind of like github does=
=2E
>  You know, showing "updated 4 days ago".
>=20
> On Wed, Apr 10, 2013 at 11:03 AM, Jakub Nar=C4=99bski <jnareb@gmail.c=
om> wrote:
>> W dniu 07.04.2013 05:02, Trenton D. Adams pisze:
>>
>>> On that first page that shows up, it shows the .git folder.  It wou=
ld
>>> be kind of nice if it shared out both the git repo and the actual
>>> current project files.  I frequently have stuff I'd like to see in =
a
>>> web browser, and even requires one (i.e. Navigating to
>>> file:///home/blah/blah doesn't work; ajax requests for example)
>>
>> There are a few possible solutions, from simplest to most complicate=
d:
>>
>> 1. Configure gitweb ran by git-instaweb to have 'worktree' link in
>>    the action bar pointing to 'file:///path/to/repo' (or rather
>>    'file:///path/to/workdir') via 'actions' feature, adding e.g.
>>
>>      $feature{'actions'}{'default'} =3D
>>         [('worktree', 'file:///path/to/repo', 'summary')];
>>
>>    to gitweb_config.perl / gitweb.conf used by git-instaweb's gitweb=
=2E
>>
>>    This of course works only for local use, so either git-instaweb
>>    or gitweb (in config) should check that we use it locally
>>    (e.g. if hostname is 'localhost' or equivalent).
[...]

Unfortunately it turns out such simple solution doesn't really work.

=46irst, for some reason Firefox 20.0 refuses to follow file:/// link,
even though it shows correctly worktree if copy'n'pasted as URL in new
window / new tab.

Second, it would work only for the top git repository.  There can be
repositories being submodules, or in untracked subdirectories (like
e.g. 't/trash directory.tNNNN*/.git' in git/.git), and said 'worktree'
link would always lead to top git repository workdir.

But anyway, here you have it:
-- >8 --
Subject: [PATCH] git-instaweb: Show project files... kind of (WIP)

On first page that git-instaweb shows, it shows the .git folder.  It
would be kind of nice if it shared out both the git repo and the
actual current project files (i.e. current worktree). [...]

[...]

This commit implements solution 1.), with git-instaweb enabling it
only for local use, which means when it is run with `--local` option.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 git-instaweb.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 01a1b05..43ae255 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -22,6 +22,13 @@ restart        restart the web server
 . git-sh-setup
=20
 fqgitdir=3D"$GIT_DIR"
+if test x"$(git rev-parse --is-bare-repository)" =3D xfalse
+then
+	fqworktree=3D"$(git rev-parse --show-toplevel)"
+else
+	fqworktree=3D""
+fi
+
 local=3D"$(git config --bool --get instaweb.local)"
 httpd=3D"$(git config --get instaweb.httpd)"
 root=3D"$(git config --get instaweb.gitwebdir)"
@@ -588,6 +595,13 @@ our \$projects_list =3D \$projectroot;
=20
 \$feature{'remote_heads'}{'default'} =3D [1];
 EOF
+	test x"$fqworktree" !=3D x &&
+	test x"$local" =3D xtrue &&
+	cat >>"$fqgitdir/gitweb/gitweb_config.perl" <<EOF
+\$feature{'actions'}{'default'} =3D [
+	('worktree', 'file://$fqworktree', 'summary')
+];
+EOF
 }
=20
 configure_httpd() {
--=20
1.8.2.1.367.geafc030.dirty

From: Lars Hjemli <hjemli@gmail.com>
Subject: [ANNOUNCE] CGIT 0.8.3
Date: Sun, 13 Sep 2009 23:00:17 +0200
Message-ID: <8c5c35580909131400r18b37ec7wa938e3fc136bd149@mail.gmail.com>
References: <8c5c35580909131355n78d817e0x67c15a1e19beb8c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 13 23:08:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmwJ4-0004kO-PI
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 23:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbZIMVIN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Sep 2009 17:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbZIMVIN
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 17:08:13 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:50063 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbZIMVIM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 17:08:12 -0400
Received: by ywh4 with SMTP id 4so3471091ywh.5
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=lfAaA2GTS3V67duaA22qtlGbf2IaZmkx4JAflrD4RcY=;
        b=sW6M+HxgqOOUw8Zz8HbCOjxNfswbrIuKo91ICmRWhU5GAo81InJDadg0N3Wu2IWqgp
         UVfGtiAGAof1GVHm5m9jSRoJDCnxZ3qKs1MKpXJlC6rOyZ46/TRUepwSqaCroCuo58KA
         hU6uHe9BPvTur9sRTWlzlVBwzPu3oawmaaAw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=LgLNW1//vAbdlfpmNNCdg61ZBgYQgzBVUOGOYf1sGAOIyrZ99fwOUEIq/2FWYUYRGs
         g/Pyhjlg1EKOkOGF4ho1pWW1OfhJhCemn97IfejA1BXNugU7BU3MmAhCqN/0rkUvqixW
         0I2ZIx7W2mf96p61HulQzHNtXfKD+THCWM/E8=
Received: by 10.150.103.21 with SMTP id a21mr8808221ybc.54.1252875617196; Sun, 
	13 Sep 2009 14:00:17 -0700 (PDT)
In-Reply-To: <8c5c35580909131355n78d817e0x67c15a1e19beb8c3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128414>

A new feature-release of cgit, a fast webinterface for git, is now
available for cloning from git://hjemli.net/pub/git/cgit (or browsing
on http://hjemli.net/git/cgit).

Some release highlights:
* support for output filters, e.g. syntax highlighting and bugtracker
 =C2=A0integration - check subdirectory "filters" for examples
* support for automatic scanning for repositories and caching of the
 =C2=A0resulting list
* improved support for mimetypes in "plain" view
* improved support for lightweight tags
* improved support for embedding cgit in site-specific layouts
* option to avoid printing author/committer/tagger email
* support for styling treeview based on filename extension (i.e. icons)
* lots of bugfixes

Thanks to everyone who contributed code and/or feedback.


Shortlog v0.8.2.1..v0.8.2.2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Lars Hjemli (4):
=C2=A0 =C2=A0 =C2=A0ui-tag.c: do not segfault when id is missing from q=
uery-string
=C2=A0 =C2=A0 =C2=A0cgit.c: do not segfault on unexpected query-string =
format
=C2=A0 =C2=A0 =C2=A0ui-plain.c: only return the blob with the specified=
 path
=C2=A0 =C2=A0 =C2=A0CGIT 0.8.2.2

Matthew Metnetsky (1):
=C2=A0 =C2=A0 =C2=A0ui-shared: don't print header <img/> if there isn't=
 a logo defined


Shortlog v0.8.2.2..v0.8.3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Simon Arlott (1):
=C2=A0 =C2=A0 =C2=A0truncate buffer before reading empty files

Diego Ongaro (2):
=C2=A0 =C2=A0 =C2=A0add cgit_httpscheme() -> http:// or https://
=C2=A0 =C2=A0 =C2=A0use cgit_httpscheme() for atom feed

=46lorian Pritz (2):
=C2=A0 =C2=A0 =C2=A0ui-tree.c: show line numbers when highlighting
=C2=A0 =C2=A0 =C2=A0Add 'linenumbers' config option

Lars Hjemli (62):
=C2=A0 =C2=A0 =C2=A0Add support for an 'embedded' option in cgitrc
=C2=A0 =C2=A0 =C2=A0cgitrc.5.txt: make the cgitrc options a valid ascii=
doc labeled list
=C2=A0 =C2=A0 =C2=A0cgitrc.5.txt: wrap the example file in an asciidoc =
LiteralBlock
=C2=A0 =C2=A0 =C2=A0cgitrc.5.txt: un-indent the name section
=C2=A0 =C2=A0 =C2=A0Add cgit-doc.css
=C2=A0 =C2=A0 =C2=A0Makefile: add doc-related targets
=C2=A0 =C2=A0 =C2=A0Add support for ETag in 'plain' view
=C2=A0 =C2=A0 =C2=A0Add support for HEAD requests
=C2=A0 =C2=A0 =C2=A0Fix doc-related glitches in Makefile and .gitignore
=C2=A0 =C2=A0 =C2=A0Return http statuscode 404 on unknown branch
=C2=A0 =C2=A0 =C2=A0ui-blob: return 'application/octet-stream' for bina=
ry blobs
=C2=A0 =C2=A0 =C2=A0cgitrc.5.txt: document 'head-include'
=C2=A0 =C2=A0 =C2=A0Add support for 'noheader' option
=C2=A0 =C2=A0 =C2=A0cgitrc.5.txt: document 'embedded' and 'noheader'
=C2=A0 =C2=A0 =C2=A0cgit.h: keep config flags sorted
=C2=A0 =C2=A0 =C2=A0Add support for mime type registration and lookup
=C2=A0 =C2=A0 =C2=A0Add generic filter/plugin infrastructure
=C2=A0 =C2=A0 =C2=A0ui-snapshot: use cgit_{open|close}_filter() to exec=
ute compressors
=C2=A0 =C2=A0 =C2=A0ui-tree: add support for source-filter option
=C2=A0 =C2=A0 =C2=A0ui-commit: add support for 'commit-filter' option
=C2=A0 =C2=A0 =C2=A0Add support for repo.commit-filter and repo.source-=
filter
=C2=A0 =C2=A0 =C2=A0cgit.c: allow repo.*-filter options to unset the cu=
rrent default
=C2=A0 =C2=A0 =C2=A0ui-summary: enable arbitrary paths below repo.readm=
e
=C2=A0 =C2=A0 =C2=A0Add 'about-filter' and 'repo.about-filter' options
=C2=A0 =C2=A0 =C2=A0Add some example filter scripts
=C2=A0 =C2=A0 =C2=A0Cleanup handling of environment variables
=C2=A0 =C2=A0 =C2=A0ui-shared: add support for NO_HTTP=3D1/--nohttp
=C2=A0 =C2=A0 =C2=A0cgit.css: align commit message with subject in expa=
nded log listing
=C2=A0 =C2=A0 =C2=A0cgit.c: make '/cgit.png' the default value for 'log=
o' option
=C2=A0 =C2=A0 =C2=A0cgitrc.5.txt: describe where/how cgit will locate c=
gitrc
=C2=A0 =C2=A0 =C2=A0ui-shared: add support for header/footer options wh=
en embedded=3D1
=C2=A0 =C2=A0 =C2=A0Use GIT-1.6.3.4
=C2=A0 =C2=A0 =C2=A0ui-log.c: handle lightweight tags when printing com=
mit decorations
=C2=A0 =C2=A0 =C2=A0Add and use a common readfile() function
=C2=A0 =C2=A0 =C2=A0cgit.c: fix caching keyed on PATH_INFO with no QUER=
Y_STRING
=C2=A0 =C2=A0 =C2=A0Rename "linenumbers" to "enable-tree-linenumbers", =
change default to "1"
=C2=A0 =C2=A0 =C2=A0cgit.css: make the blob display in tree view a bit =
prettier
=C2=A0 =C2=A0 =C2=A0cgitrc.5.txt: fix description and markup for 'snaps=
hots' option
=C2=A0 =C2=A0 =C2=A0scan-tree: detect non-bare repository and stop scan=
ning early
=C2=A0 =C2=A0 =C2=A0cgit.c: add support for cgitrc option 'repo.scan'
=C2=A0 =C2=A0 =C2=A0cache.h: export hash_str()
=C2=A0 =C2=A0 =C2=A0cgit.c: make print_repolist() and print_repo() reus=
able for caching
=C2=A0 =C2=A0 =C2=A0cgit.c: add support for caching autodetected reposi=
tories
=C2=A0 =C2=A0 =C2=A0cgitrc.5.txt: document repo.scan and cache-scanrc-t=
tl
=C2=A0 =C2=A0 =C2=A0Rename 'repo.scan' to 'scan-path'
=C2=A0 =C2=A0 =C2=A0Add support for --scan-path command line option
=C2=A0 =C2=A0 =C2=A0Introduce 'section' as canonical spelling for 'repo=
=2Egroup'
=C2=A0 =C2=A0 =C2=A0Add config option 'repo.section'
=C2=A0 =C2=A0 =C2=A0ui-repolist.c: sort by section name, repo name as d=
efault
=C2=A0 =C2=A0 =C2=A0cgit.c: refactor repo_config() from config_cb()
=C2=A0 =C2=A0 =C2=A0Add support for repo-local cgitrc file
=C2=A0 =C2=A0 =C2=A0ui-repolist: handle empty sections similar to NULL =
sections
=C2=A0 =C2=A0 =C2=A0cgitrc.5.txt: fix markup errors
=C2=A0 =C2=A0 =C2=A0Add config option 'enable-filter-overrides'
=C2=A0 =C2=A0 =C2=A0shared.c: initialize cgit_repo structs properly
=C2=A0 =C2=A0 =C2=A0cgit.c: add missing options to print_repo()
=C2=A0 =C2=A0 =C2=A0cgit.c: generate repo.snapshots in print_repo()
=C2=A0 =C2=A0 =C2=A0Add and use cgit_find_stats_periodname() in print_r=
epo()
=C2=A0 =C2=A0 =C2=A0cgit.c: only print first line of repo.desc in print=
_repo()
=C2=A0 =C2=A0 =C2=A0cgit.c: respect repo-local 'snapshots' option for -=
-scan-path
=C2=A0 =C2=A0 =C2=A0Use GIT-1.6.4.3
=C2=A0 =C2=A0 =C2=A0CGIT 0.8.3

Mark Lodato (1):
=C2=A0 =C2=A0 =C2=A0Add head-include configuration option.

Martin Szulecki (2):
=C2=A0 =C2=A0 =C2=A0Introduce noplainemail option to hide email adresse=
s from spambots
=C2=A0 =C2=A0 =C2=A0Expose file extension in tree lists as class to all=
ow nicer tree styling

Matt McCormick (thewtex) (1):
=C2=A0 =C2=A0 =C2=A0make cgitrc.5.txt asciidoc manpage compatible

Remko Tron=C3=A7on (1):
=C2=A0 =C2=A0 =C2=A0ui-plain: Return 'application/octet-stream' for bin=
ary files.

Stefan B=C3=BChler (1):
=C2=A0 =C2=A0 =C2=A0ui-refs.c: improve handling of lightweight tags

Stefan Naewe (1):
=C2=A0 =C2=A0 =C2=A0scan-tree: split the pw_gecos field at the ',' to g=
et the real name

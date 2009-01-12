From: Morgan Christiansson <git@mog.se>
Subject: Re: git-svn: File was not found in commit
Date: Mon, 12 Jan 2009 01:04:28 +0100
Message-ID: <496A890C.8080208@mog.se>
References: <49678705.4040506@mog.se> <20090111215526.GA15533@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 01:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMAJj-0002vb-7N
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 01:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbZALAEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jan 2009 19:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754000AbZALAEl
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 19:04:41 -0500
Received: from mog.vm.bytemark.co.uk ([80.68.94.200]:52847 "EHLO mog.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753696AbZALAEk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 19:04:40 -0500
Received: from [192.168.1.182] (81-226-238-170-no61.tbcn.telia.com [81.226.238.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mog.se (Postfix) with ESMTP id ADDDE80CC5
	for <git@vger.kernel.org>; Mon, 12 Jan 2009 00:04:38 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
In-Reply-To: <20090111215526.GA15533@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105257>

Bj=F6rn Steinbrink wrote:
> On 2009.01.09 18:19:01 +0100, Morgan Christiansson wrote:
>  =20
>> --------------------------------------------------------------------=
----
>> r10577 | morgan | 2008-11-28 18:31:00 +0000 (Fri, 28 Nov 2008) | 3 l=
ines
>> Changed paths:
>>   A /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/FETCH_H=
EAD
>>   M /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/config
>>   M /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/index
>>   M /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/logs/HE=
AD
>>   M /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/logs/re=
fs/heads/master=20
>> # -- THIS FILE --
>>    =20
> Unless I totally misread that line, SVN reports that the file was
> _modified_, not added. For the file to be modified, it seems reasonab=
le
> to expect that it existed in the previous commit.
>
> Is there anything "special" about how that file came into existence i=
n
> that branch? Without further knowledge, that looks like a svn bug, bu=
t
> hey, it's svn, it might do funny stuff on purpose ;-)
>
> Maybe you could provide a small test case/repo?
>
> Bj=F6rn
>  =20
Something odd happened when "git svn fetch" was adding r10559 to git:

        A       rails/vendor/plugins/acts_as_xapian/README.txt
        A       rails/vendor/plugins/acts_as_xapian/.cvsignore
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/refs/heads/maste=
r
Ignoring path=20
rails/vendor/plugins/acts_as_xapian/.git/refs/remotes/origin/HEAD
Ignoring path=20
rails/vendor/plugins/acts_as_xapian/.git/refs/remotes/origin/master
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/HEAD
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/description
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/hooks/update
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/hooks/post-recei=
ve
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/hooks/post-updat=
e
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/hooks/pre-rebase
Ignoring path=20
rails/vendor/plugins/acts_as_xapian/.git/hooks/prepare-commit-msg
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/hooks/applypatch=
-msg
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/hooks/pre-applyp=
atch
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/hooks/post-commi=
t
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/hooks/commit-msg
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/hooks/pre-commit
Ignoring path=20
rails/vendor/plugins/acts_as_xapian/.git/logs/refs/heads/master
Ignoring path=20
rails/vendor/plugins/acts_as_xapian/.git/logs/refs/remotes/origin/HEAD
Ignoring path=20
rails/vendor/plugins/acts_as_xapian/.git/logs/refs/remotes/origin/maste=
r
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/logs/HEAD
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/config
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/index
Ignoring path=20
rails/vendor/plugins/acts_as_xapian/.git/objects/pack/pack-570449ffe8ce=
399eca81f286cf942e51ace03448.pack
Ignoring path=20
rails/vendor/plugins/acts_as_xapian/.git/objects/pack/pack-570449ffe8ce=
399eca81f286cf942e51ace03448.idx
Ignoring path rails/vendor/plugins/acts_as_xapian/.git/info/exclude
W: +empty_dir:=20
branches/rails/rails/vendor/plugins/acts_as_xapian/.git/branches
W: +empty_dir:=20
branches/rails/rails/vendor/plugins/acts_as_xapian/.git/objects/info
W: +empty_dir:=20
branches/rails/rails/vendor/plugins/acts_as_xapian/.git/refs/tags
r10559 =3D 4f33ee36a5d933a62081a76c7788fb46a9e6f0e8 (rails)


The "Ignoring path" message appears to be coming from git which is=20
refusing to commit the .git directory. Which leads to git-svn being=20
unaware of the files being ignored and giving an error when it can't=20
find them.


#The following commands will create a repository that has this problem:
cd ~
rm -rf gittest*
svnadmin create gittest-repo
svn co file:///$HOME/gittest-repo gittest-checkout
cd gittest-checkout
mkdir -p .git
touch .git/file
svn add .git
svn commit -m "Create .git/file"
echo 1 > .git/file
svn commit -m "Modify .git/file"

# The following will try to import the repository, which fails.
cd ~
mkdir gittest
cd gittest
git svn init file:///$HOME/gittest-repo
git svn fetch

# Output:
$ git svn fetch
    A    .git/file
Ignoring path .git/file
r1 =3D ccc56451d54315bd253b65c514351e996fbe880e (git-svn)
=2Egit/file was not found in commit=20
ccc56451d54315bd253b65c514351e996fbe880e (r1)


# Cleanup
rm -rf gittest gittest-repo gittest-checkout



I'm personally fine with these files being ignored by git, but git-svn=20
needs to be aware that they are not added to the repository.

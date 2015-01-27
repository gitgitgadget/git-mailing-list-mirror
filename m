From: Albert Akhriev <albert_akhriev@ie.ibm.com>
Subject: bug report
Date: Tue, 27 Jan 2015 14:43:31 +0000
Message-ID: <OF166CC5C9.21C21E8C-ON80257DDA.005038FD-80257DDA.0050E350@ie.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 15:43:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG7Mm-00029k-Hh
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 15:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbbA0Onl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 09:43:41 -0500
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:53573 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644AbbA0Oni (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 09:43:38 -0500
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <albert_akhriev@ie.ibm.com>;
	Tue, 27 Jan 2015 14:43:36 -0000
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
	by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Tue, 27 Jan 2015 14:43:33 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 16C8C1B0805F
	for <git@vger.kernel.org>; Tue, 27 Jan 2015 14:43:37 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com [9.149.37.247])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0REhXYr10093022
	for <git@vger.kernel.org>; Tue, 27 Jan 2015 14:43:33 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0REhWOu006519
	for <git@vger.kernel.org>; Tue, 27 Jan 2015 07:43:32 -0700
Received: from d06ml092.portsmouth.uk.ibm.com (d06ml092.portsmouth.uk.ibm.com [9.149.104.88])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t0REhV9U006388
	for <git@vger.kernel.org>; Tue, 27 Jan 2015 07:43:31 -0700
X-KeepSent: 166CC5C9:21C21E8C-80257DDA:005038FD;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1FP2 August  03, 2014
X-MIMETrack: Serialize by Router on D06ML092/06/M/IBM(Release 9.0.1FP2|August  03, 2014) at
 27/01/2015 14:43:30
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15012714-0017-0000-0000-000002D61BFF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263066>


Hi All,

My system:                      RedHat 6.5/64-bit (gcc 4.4.7)
My configuration options:  ./configure --prefix=/home/albert/soft

Compilation of git 2.2.2 itself was fine, but some tests failed.
I presume, there might be some network communication restrictions here in
the lab
(gitweb had failed as can be seen in the listing below):

1..14
*** t9400-git-cvsserver-server.sh ***
1..0 # SKIP skipping git-cvsserver tests, Perl SQLite interface unavailable
*** t9401-git-cvsserver-crlf.sh ***
1..0 # SKIP skipping git-cvsserver tests, Perl SQLite interface unavailable
*** t9402-git-cvsserver-refs.sh ***
1..0 # SKIP skipping git-cvsserver tests, Perl SQLite interface unavailable
*** t9500-gitweb-standalone-no-errors.sh ***
not ok 1 - no commits: projects_list (implicit)
#	gitweb_run
not ok 2 - no commits: projects_index
#	gitweb_run "a=project_index"
not ok 3 - no commits: .git summary (implicit)
#	gitweb_run "p=.git"
not ok 4 - no commits: .git commit (implicit HEAD)
#	gitweb_run "p=.git;a=commit"
not ok 5 - no commits: .git commitdiff (implicit HEAD)
#	gitweb_run "p=.git;a=commitdiff"
not ok 6 - no commits: .git tree (implicit HEAD)
#	gitweb_run "p=.git;a=tree"
not ok 7 - no commits: .git heads
#	gitweb_run "p=.git;a=heads"
not ok 8 - no commits: .git tags
#	gitweb_run "p=.git;a=tags"
ok 9 - Make initial commit
not ok 10 - projects_list (implicit)
#	gitweb_run
not ok 11 - projects_index
#	gitweb_run "a=project_index"
not ok 12 - .git summary (implicit)
#	gitweb_run "p=.git"
not ok 13 - .git commit (implicit HEAD)
#	gitweb_run "p=.git;a=commit"
not ok 14 - .git commitdiff (implicit HEAD, root commit)
#	gitweb_run "p=.git;a=commitdiff"
not ok 15 - .git commitdiff_plain (implicit HEAD, root commit)
#	gitweb_run "p=.git;a=commitdiff_plain"
not ok 16 - .git commit (HEAD)
#	gitweb_run "p=.git;a=commit;h=HEAD"
not ok 17 - .git tree (implicit HEAD)
#	gitweb_run "p=.git;a=tree"
not ok 18 - .git blob (file)
#	gitweb_run "p=.git;a=blob;f=file"
not ok 19 - .git blob_plain (file)
#	gitweb_run "p=.git;a=blob_plain;f=file"
not ok 20 - .git commit (non-existent)
#	gitweb_run "p=.git;a=commit;h=non-existent"
not ok 21 - .git commitdiff (non-existent)
#	gitweb_run "p=.git;a=commitdiff;h=non-existent"
not ok 22 - .git commitdiff (non-existent vs HEAD)
#	gitweb_run "p=.git;a=commitdiff;hp=non-existent;h=HEAD"
not ok 23 - .git tree (0000000000000000000000000000000000000000)
#	gitweb_run "p=.git;a=tree;h=0000000000000000000000000000000000000000"
not ok 24 - .git tag (0000000000000000000000000000000000000000)
#	gitweb_run "p=.git;a=tag;h=0000000000000000000000000000000000000000"
not ok 25 - .git blob (non-existent)
#	gitweb_run "p=.git;a=blob;f=non-existent"
not ok 26 - .git blob_plain (non-existent)
#	gitweb_run "p=.git;a=blob_plain;f=non-existent"
not ok 27 - commitdiff(0): root
#	gitweb_run "p=.git;a=commitdiff"
not ok 28 - commitdiff(0): file added
#	echo "New file" > new_file &&
#		 git add new_file &&
#		 git commit -a -m "File added." &&
#		 gitweb_run "p=.git;a=commitdiff"
not ok 29 - commitdiff(0): mode change
#	test_chmod +x new_file &&
#		 git commit -a -m "Mode changed." &&
#		 gitweb_run "p=.git;a=commitdiff"
not ok 30 - commitdiff(0): file renamed
#	git mv new_file renamed_file &&
#		 git commit -a -m "File renamed." &&
#		 gitweb_run "p=.git;a=commitdiff"
not ok 31 - commitdiff(0): file to symlink
#	rm renamed_file &&
#		 test_ln_s_add file renamed_file &&
#		 git commit -a -m "File to symlink." &&
#		 gitweb_run "p=.git;a=commitdiff"
not ok 32 - commitdiff(0): file deleted
#	git rm renamed_file &&
#		 rm -f renamed_file &&
#		 git commit -a -m "File removed." &&
#		 gitweb_run "p=.git;a=commitdiff"
not ok 33 - commitdiff(0): file copied / new file
#	cp file file2 &&
#		 git add file2 &&
#		 git commit -a -m "File copied." &&
#		 gitweb_run "p=.git;a=commitdiff"
not ok 34 - commitdiff(0): mode change and modified
#	echo "New line" >> file2 &&
#		 test_chmod +x file2 &&
#		 git commit -a -m "Mode change and modification." &&
#		 gitweb_run "p=.git;a=commitdiff"
not ok 35 - commitdiff(0): renamed and modified
#	cat >file2<<EOF &&
#	Dominus regit me,
#	et nihil mihi deerit.
#	In loco pascuae ibi me collocavit,
#	super aquam refectionis educavit me;
#	animam meam convertit,
#	deduxit me super semitas jusitiae,
#	propter nomen suum.
#	EOF
#		 git commit -a -m "File added." &&
#		 git mv file2 file3 &&
#		 echo "Propter nomen suum." >> file3 &&
#		 git commit -a -m "File rename and modification." &&
#		 gitweb_run "p=.git;a=commitdiff"
not ok 36 - commitdiff(0): renamed, mode change and modified
#	git mv file3 file2 &&
#		 echo "Propter nomen suum." >> file2 &&
#		 test_chmod +x file2 &&
#		 git commit -a -m "File rename, mode change and modification."
&&
#		 gitweb_run "p=.git;a=commitdiff"
ok 37 - setup typechange commits
not ok 38 - commitdiff(2): file renamed from foo to foo/baz
#	gitweb_run
"p=.git;a=commitdiff;hp=initial;h=foo-baz-renamed-from-foo"
not ok 39 - commitdiff(2): file renamed from foo/baz to foo
#	gitweb_run
"p=.git;a=commitdiff;hp=foo-baz-renamed-from-foo;h=initial"
not ok 40 - commitdiff(2): directory becomes file
#	gitweb_run "p=.git;a=commitdiff;hp=foo-becomes-a-directory;h=initial"
not ok 41 - commitdiff(2): file becomes directory
#	gitweb_run "p=.git;a=commitdiff;hp=initial;h=foo-becomes-a-directory"
not ok 42 - commitdiff(2): file becomes symlink
#	gitweb_run "p=.git;a=commitdiff;hp=initial;h=foo-symlinked-to-bar"
not ok 43 - commitdiff(2): symlink becomes file
#	gitweb_run
"p=.git;a=commitdiff;hp=foo-symlinked-to-bar;h=foo-back-to-file"
not ok 44 - commitdiff(2): symlink becomes directory
#	gitweb_run
"p=.git;a=commitdiff;hp=foo-symlinked-to-bar;h=foo-becomes-a-directory"
not ok 45 - commitdiff(2): directory becomes symlink
#	gitweb_run
"p=.git;a=commitdiff;hp=foo-becomes-a-directory;h=foo-symlinked-to-bar"
ok 46 - setup incomplete lines
not ok 47 - commitdiff(1): addition of incomplete line
#
#		gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_add"
#
not ok 48 - commitdiff(1): incomplete line as context line
#
#		gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_ctx"
#
not ok 49 - commitdiff(1): change incomplete line
#
#		gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_chg"
#
not ok 50 - commitdiff(1): removal of incomplete line
#
#		gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_rem"
#
ok 51 - Create a merge
not ok 52 - commit(0): merge commit
#	gitweb_run "p=.git;a=commit"
not ok 53 - commitdiff(0): merge commit
#	gitweb_run "p=.git;a=commitdiff"
ok 54 - Prepare large commit
not ok 55 - commit(1): large commit
#	gitweb_run "p=.git;a=commit;h=b"
not ok 56 - commitdiff(1): large commit
#	gitweb_run "p=.git;a=commitdiff;h=b"
not ok 57 - side-by-side: addition of incomplete line
#
#		gitweb_run
"p=.git;a=commitdiff;h=incomplete_lines_add;ds=sidebyside"
#
not ok 58 - side-by-side: incomplete line as context line
#
#		gitweb_run
"p=.git;a=commitdiff;h=incomplete_lines_ctx;ds=sidebyside"
#
not ok 59 - side-by-side: changed incomplete line
#
#		gitweb_run
"p=.git;a=commitdiff;h=incomplete_lines_chg;ds=sidebyside"
#
not ok 60 - side-by-side: removal of incomplete line
#
#		gitweb_run
"p=.git;a=commitdiff;h=incomplete_lines_rem;ds=sidebyside"
#
not ok 61 - side-by-side: merge commit
#
#		gitweb_run "p=.git;a=commitdiff;h=merge_commit;ds=sidebyside"
#
not ok 62 - tags: list of different types of tags
#	git checkout master &&
#		 git tag -a -m "Tag commit object" tag-commit HEAD &&
#		 git tag -a -m "" tag-commit-nomessage HEAD &&
#		 git tag -a -m "Tag tag object" tag-tag tag-commit &&
#		 git tag -a -m "Tag tree object" tag-tree HEAD^{tree} &&
#		 git tag -a -m "Tag blob object" tag-blob HEAD:file &&
#		 git tag lightweight/tag-commit HEAD &&
#		 git tag lightweight/tag-tag tag-commit &&
#		 git tag lightweight/tag-tree HEAD^{tree} &&
#		 git tag lightweight/tag-blob HEAD:file &&
#		 gitweb_run "p=.git;a=tags"
not ok 63 - tag: Tag to commit object
#	gitweb_run "p=.git;a=tag;h=tag-commit"
not ok 64 - tag: on lightweight tag (invalid)
#	gitweb_run "p=.git;a=tag;h=lightweight/tag-commit"
not ok 65 - logs: log (implicit HEAD)
#	gitweb_run "p=.git;a=log"
not ok 66 - logs: shortlog (implicit HEAD)
#	gitweb_run "p=.git;a=shortlog"
not ok 67 - logs: history (implicit HEAD, file)
#	gitweb_run "p=.git;a=history;f=file"
not ok 68 - logs: history (implicit HEAD, non-existent file)
#	gitweb_run "p=.git;a=history;f=non-existent"
not ok 69 - logs: history (implicit HEAD, deleted file)
#	git checkout master &&
#		 echo "to be deleted" > deleted_file &&
#		 git add deleted_file &&
#		 git commit -m "Add file to be deleted" &&
#		 git rm deleted_file &&
#		 git commit -m "Delete file" &&
#		 gitweb_run "p=.git;a=history;f=deleted_file"
not ok 70 - path_info: project
#	gitweb_run "" "/.git"
not ok 71 - path_info: project/branch
#	gitweb_run "" "/.git/b"
not ok 72 - path_info: project/branch:file
#	gitweb_run "" "/.git/master:file"
not ok 73 - path_info: project/branch:dir/
#	gitweb_run "" "/.git/master:foo/"
not ok 74 - path_info: project/branch (non-existent)
#	gitweb_run "" "/.git/non-existent"
not ok 75 - path_info: project/branch:filename (non-existent branch)
#	gitweb_run "" "/.git/non-existent:non-existent"
not ok 76 - path_info: project/branch:file (non-existent)
#	gitweb_run "" "/.git/master:non-existent"
not ok 77 - path_info: project/branch:dir/ (non-existent)
#	gitweb_run "" "/.git/master:non-existent/"
not ok 78 - path_info: project/branch:/file
#	gitweb_run "" "/.git/master:/file"
not ok 79 - path_info: project/:/file (implicit HEAD)
#	gitweb_run "" "/.git/:/file"
not ok 80 - path_info: project/:/ (implicit HEAD, top tree)
#	gitweb_run "" "/.git/:/"
not ok 81 - feeds: OPML
#	gitweb_run "a=opml"
not ok 82 - feed: RSS
#	gitweb_run "p=.git;a=rss"
not ok 83 - feed: Atom
#	gitweb_run "p=.git;a=atom"
not ok 84 - encode(commit): utf8
#	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
#		 test_when_finished "GIT_AUTHOR_NAME=\"A U Thor\"" &&
#		 test_when_finished "GIT_COMMITTER_NAME=\"C O Mitter\"" &&
#		 echo "UTF-8" >> file &&
#		 git add file &&
#		 git commit -F "$TEST_DIRECTORY"/t3900/1-UTF-8.txt &&
#		 gitweb_run "p=.git;a=commit"
not ok 85 - encode(commit): iso-8859-1
#	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
#		 test_when_finished "GIT_AUTHOR_NAME=\"A U Thor\"" &&
#		 test_when_finished "GIT_COMMITTER_NAME=\"C O Mitter\"" &&
#		 echo "ISO-8859-1" >> file &&
#		 git add file &&
#		 test_config i18n.commitencoding ISO-8859-1 &&
#		 git commit -F "$TEST_DIRECTORY"/t3900/ISO8859-1.txt &&
#		 gitweb_run "p=.git;a=commit"
not ok 86 - encode(log): utf-8 and iso-8859-1
#	gitweb_run "p=.git;a=log"
not ok 87 - opt: log --no-merges
#	gitweb_run "p=.git;a=log;opt=--no-merges"
not ok 88 - opt: atom --no-merges
#	gitweb_run "p=.git;a=log;opt=--no-merges"
not ok 89 - opt: "file" history --no-merges
#	gitweb_run "p=.git;a=history;f=file;opt=--no-merges"
not ok 90 - opt: log --no-such-option (invalid option)
#	gitweb_run "p=.git;a=log;opt=--no-such-option"
not ok 91 - opt: tree --no-merges (invalid option for action)
#	gitweb_run "p=.git;a=tree;opt=--no-merges"
not ok 92 - URL: no project URLs, no base URL
#	gitweb_run "p=.git;a=summary"
not ok 93 - URL: project URLs via gitweb.url
#	git config --add gitweb.url git://example.com/git/trash.git &&
#	        git config --add gitweb.url http://example.com/git/trash.git
&&
#	        gitweb_run "p=.git;a=summary"
not ok 94 - URL: project URLs via cloneurl file
#	gitweb_run "p=.git;a=summary"
not ok 95 - config override: projects list (implicit)
#	gitweb_run
not ok 96 - config override: tree view, features not overridden in repo
config
#	gitweb_run "p=.git;a=tree"
not ok 97 - config override: tree view, features disabled in repo config
#	git config gitweb.blame no &&
#		 git config gitweb.snapshot none &&
#		 git config gitweb.avatar gravatar &&
#		 gitweb_run "p=.git;a=tree"
not ok 98 - config override: tree view, features enabled in repo config (1)
#	git config gitweb.blame yes &&
#		 git config gitweb.snapshot "zip,tgz, tbz2" &&
#		 gitweb_run "p=.git;a=tree"
not ok 99 - config override: tree view, features enabled in repo config (2)
#	gitweb_run "p=.git;a=tree"
ok 100 - search: preparation
not ok 101 - search: commit author
#	gitweb_run "p=.git;a=search;h=HEAD;st=author;s=A+U+Thor"
not ok 102 - search: commit message
#	gitweb_run "p=.git;a=search;h=HEAD;st=commitr;s=MATCH"
not ok 103 - search: grep
#	gitweb_run "p=.git;a=search;h=HEAD;st=grep;s=MATCH"
not ok 104 - search: pickaxe
#	gitweb_run "p=.git;a=search;h=HEAD;st=pickaxe;s=MATCH"
not ok 105 - search: projects
#	gitweb_run "a=project_list;s=.git"
not ok 106 - README.html with non-ASCII characters (utf-8)
#	echo "<b>UTF-8 example:</b><br />" > .git/README.html &&
#		 cat "$TEST_DIRECTORY"/t3900/1-UTF-8.txt >> .git/README.html &&
#		 gitweb_run "p=.git;a=summary"
Skipping syntax highlighting tests: 'highlight' not found
ok 107 # skip syntax highlighting (no highlight, unknown syntax) (missing
HIGHLIGHT)
ok 108 # skip syntax highlighting (highlighted, shell script) (missing
HIGHLIGHT)
ok 109 - forks: prepare
not ok 110 - forks: projects list
#	gitweb_run
not ok 111 - forks: forks action
#	gitweb_run "p=foo.git;a=forks"
not ok 112 - ctags: tag cloud in projects list
#	mkdir .git/ctags &&
#		 echo "2" > .git/ctags/foo &&
#		 echo "1" > .git/ctags/bar &&
#		gitweb_run
not ok 113 - ctags: search projects by existing tag
#	gitweb_run "by_tag=foo"
not ok 114 - ctags: search projects by non existent tag
#	gitweb_run "by_tag=non-existent"
not ok 115 - ctags: malformed tag weights
#	mkdir -p .git/ctags &&
#		 echo "not-a-number" > .git/ctags/nan &&
#		 echo "not-a-number-2" > .git/ctags/nan2 &&
#		 echo "0.1" >.git/ctags/floating-point &&
#		 gitweb_run
not ok 116 - categories: projects list, only default category
#	echo "\$projects_list_group_categories = 1;" >>gitweb_config.perl &&
#		 gitweb_run
not ok 117 - unborn HEAD: "summary" page (with "heads" subview)
#	git checkout orphan_branch || git checkout --orphan orphan_branch &&
#		 test_when_finished "git checkout master" &&
#		 gitweb_run "p=.git;a=summary"
# failed 108 among 117 test(s)
1..117
make[2]: *** [t9500-gitweb-standalone-no-errors.sh] Error 1
make[2]: Leaving directory
`/home/albert/work/info/install_ver2/git-2.2.2/t'
make[1]: *** [test] Error 2
make[1]: Leaving directory
`/home/albert/work/info/install_ver2/git-2.2.2/t'
make: *** [test] Error 2

Best regards,

Albert Akhriev, PhD
IBM Research - Ireland
Tech. Campus, Bldg 3,  | Mulhuddart, Dublin 15
http://researcher.ibm.com/person/ie-albert_akhriev
albert_akhriev@ie.ibm.com | +353 1 826 91 86

IBM Ireland Limited registered in Ireland under company number 16226.
Registered Office: IBM House, Shelbourne Rd., Ballsbridge, Dublin 4.

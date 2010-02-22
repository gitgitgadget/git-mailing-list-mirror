From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Use git_mkstemp_mode and xmkstemp_mode in
 odb_mkstemp, not chmod later.
Date: Mon, 22 Feb 2010 12:36:13 -0800
Message-ID: <7vsk8t9feq.fsf@alter.siamese.dyndns.org>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
 <1266597207-32036-5-git-send-email-Matthieu.Moy@imag.fr>
 <7vy6inekxq.fsf@alter.siamese.dyndns.org> <vpqfx4tln64.fsf@bauges.imag.fr>
 <7veikdau4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 22 21:36:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njf10-0002IO-Ua
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 21:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab0BVUgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 15:36:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462Ab0BVUgU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 15:36:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1ADF9C562;
	Mon, 22 Feb 2010 15:36:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v+iV5TbFNQd5J6P1V7wE3pVvv8E=; b=iIvt/z
	6PXT9vTlMAyhd878R8SRIf6l12Wkil9HTIcA/5hYkKr0p276nvEBgAwLQiFsGQnM
	oHJie5uHmCb2ARVY8NsMDCfI+Gxxp954wvalLec1pRf29Tr47fDeCm5IXAb45VkF
	UMuqnGe0j5ZgpDaLRd/uRdq9y/iRzRZpYkglo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VwJYcDdajnsuTUIi/AV0KXvcWdvIJT7k
	SZ8skKp6yLwMUqLp3AfjaOM9VVcZMi5KKcF1zh/SqXeRghQzw/qc02NdU8PeiEqz
	LMjKk6ZLe86ZFGnTYoZhCFPjd7wdqrPwTmK0YiKXAokpc1z06qdTOdGerOnOcPXQ
	UfdgeXSRAJE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 985CA9C561;
	Mon, 22 Feb 2010 15:36:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F9F49C560; Mon, 22 Feb
 2010 15:36:14 -0500 (EST)
In-Reply-To: <7veikdau4i.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 22 Feb 2010 12\:33\:01 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED746992-1FF1-11DF-8C1F-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140711>

--=-=-=

By the way, here is what the same command gets when run on FreeBSD 8.0


--=-=-=
Content-Disposition: inline; filename=fbsd80.log
Content-Description: sh -x t1304-default.acl.sh -i -v 2>&1

+ test_description='Test repository with default ACL'
+ . ./test-lib.sh
+ ORIGINAL_TERM=screen
+ LANG=C
+ LC_ALL=C
+ PAGER=cat
+ TZ=UTC
+ TERM=dumb
+ export LANG LC_ALL PAGER TERM TZ
+ EDITOR=:
+ unset VISUAL
+ unset GIT_EDITOR
+ unset AUTHOR_DATE
+ unset AUTHOR_EMAIL
+ unset AUTHOR_NAME
+ unset COMMIT_AUTHOR_EMAIL
+ unset COMMIT_AUTHOR_NAME
+ unset EMAIL
+ unset GIT_ALTERNATE_OBJECT_DIRECTORIES
+ unset GIT_AUTHOR_DATE
+ GIT_AUTHOR_EMAIL=author@example.com
+ GIT_AUTHOR_NAME='A U Thor'
+ unset GIT_COMMITTER_DATE
+ GIT_COMMITTER_EMAIL=committer@example.com
+ GIT_COMMITTER_NAME='C O Mitter'
+ unset GIT_DIFF_OPTS
+ unset GIT_DIR
+ unset GIT_WORK_TREE
+ unset GIT_EXTERNAL_DIFF
+ unset GIT_INDEX_FILE
+ unset GIT_OBJECT_DIRECTORY
+ unset GIT_CEILING_DIRECTORIES
+ unset SHA1_FILE_DIRECTORIES
+ unset SHA1_FILE_DIRECTORY
+ GIT_MERGE_VERBOSITY=5
+ export GIT_MERGE_VERBOSITY
+ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
+ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
+ export EDITOR
+ GIT_TEST_CMP='diff -u'
+ unset CDPATH
+ echo
+ tr '[A-Z]' '[a-z]'
+ _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+ [ xscreen != xdumb ]
+ TERM=screen
+ export TERM
+ [ -t 1 ]
+ test 2 -ne 0
+ immediate=t
+ shift
+ test 1 -ne 0
+ verbose=t
+ shift
+ test 0 -ne 0
+ test -n ''
+ test 'Test repository with default ACL' != ''
+ test '' = t
+ exec
+ test t = t
+ exec
+ test_failure=0
+ test_count=0
+ test_fixed=0
+ test_broken=0
+ test_success=0
+ GIT_EXIT_OK=''
+ trap die EXIT
+ satisfied=' '
+ pwd
+ TEST_DIRECTORY=/usr/home/junio/buildfarm/pu/t
+ test -n ''
+ test -n ''
+ git_bin_dir=/usr/home/junio/buildfarm/pu/t/../bin-wrappers
+ test -x /usr/home/junio/buildfarm/pu/t/../bin-wrappers/git
+ PATH=/usr/home/junio/buildfarm/pu/t/../bin-wrappers:/home/junio/g/FreeBSD-8.0-RELEASE-i386/git-active/bin:/home/junio/bin/common:/usr/local/bin:/sbin:/usr/sbin:/usr/bin:/bin
+ GIT_EXEC_PATH=/usr/home/junio/buildfarm/pu/t/..
+ test -n ''
+ pwd
+ GIT_TEMPLATE_DIR=/usr/home/junio/buildfarm/pu/t/../templates/blt
+ unset GIT_CONFIG
+ GIT_CONFIG_NOSYSTEM=1
+ GIT_CONFIG_NOGLOBAL=1
+ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
+ . ../GIT-BUILD-OPTIONS
+ SHELL_PATH=/bin/sh
+ PERL_PATH=/usr/bin/perl
+ TAR=tar
+ NO_CURL=''
+ NO_PERL=''
+ NO_PYTHON=''
+ pwd
+ pwd
+ GITPERLLIB=/usr/home/junio/buildfarm/pu/t/../perl/blib/lib:/usr/home/junio/buildfarm/pu/t/../perl/blib/arch/auto/Git
+ export GITPERLLIB
+ test -d ../templates/blt
+ test -z ''
+ test -z ''
+ pwd
+ GITPYTHONLIB=/usr/home/junio/buildfarm/pu/t/../git_remote_helpers/build/lib
+ export GITPYTHONLIB
+ test -d ../git_remote_helpers/build
+ test -x ../test-chmtime
+ basename t1304-default-acl.sh .sh
+ test='trash directory.t1304-default-acl'
+ test -n ''
+ TRASH_DIRECTORY='/usr/home/junio/buildfarm/pu/t/trash directory.t1304-default-acl'
+ test ! -z ''
+ remove_trash='/usr/home/junio/buildfarm/pu/t/trash directory.t1304-default-acl'
+ rm -fr 'trash directory.t1304-default-acl'
+ test_create_repo 'trash directory.t1304-default-acl'
+ test 1 = 1
+ pwd
+ owd=/usr/home/junio/buildfarm/pu/t
+ repo='trash directory.t1304-default-acl'
+ mkdir -p 'trash directory.t1304-default-acl'
+ cd 'trash directory.t1304-default-acl'
+ /usr/home/junio/buildfarm/pu/t/../git-init --template=/usr/home/junio/buildfarm/pu/t/../templates/blt/
Initialized empty Git repository in /usr/home/junio/buildfarm/pu/t/trash directory.t1304-default-acl/.git/
+ mv .git/hooks .git/hooks-disabled
+ cd /usr/home/junio/buildfarm/pu/t
+ cd -P 'trash directory.t1304-default-acl'
+ this_test=t1304-default-acl.sh
+ this_test=t1304
+ uname -s
+ test_set_prereq POSIXPERM
+ satisfied=' POSIXPERM '
+ test_set_prereq BSLASHPSPEC
+ satisfied=' POSIXPERM BSLASHPSPEC '
+ test_set_prereq EXECKEEPSPID
+ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID '
+ test -z ''
+ test_set_prereq PERL
+ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID PERL '
+ test -z ''
+ test_set_prereq PYTHON
+ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID PERL PYTHON '
+ ln -s x y
+ test -h y
+ test_set_prereq SYMLINKS
+ satisfied=' POSIXPERM BSLASHPSPEC EXECKEEPSPID PERL PYTHON SYMLINKS '
+ rm -f y
+ setfacl -Rm u:root:rwx .
setfacl: illegal option -- R
usage: setfacl [-bdhkn] [-m entries] [-M file] [-x entries] [-X file] [file ...]
+ say 'Skipping ACL tests: unable to use setfacl'
+ say_color info 'Skipping ACL tests: unable to use setfacl'
+ test -z info
+ shift
+ echo '* Skipping ACL tests: unable to use setfacl'
* Skipping ACL tests: unable to use setfacl
+ test_done
+ GIT_EXIT_OK=t
+ test_results_dir=/usr/home/junio/buildfarm/pu/t/test-results
+ mkdir -p /usr/home/junio/buildfarm/pu/t/test-results
+ test_results_path=/usr/home/junio/buildfarm/pu/t/test-results/t1304-default-acl-56364
+ echo 'total 0'
+ echo 'success 0'
+ echo 'fixed 0'
+ echo 'broken 0'
+ echo 'failed 0'
+ echo ''
+ test 0 != 0
+ test 0 != 0
+ msg='0 test(s)'
+ say_color pass 'passed all 0 test(s)'
+ test -z pass
+ shift
+ echo '* passed all 0 test(s)'
* passed all 0 test(s)
+ test -d '/usr/home/junio/buildfarm/pu/t/trash directory.t1304-default-acl'
+ dirname '/usr/home/junio/buildfarm/pu/t/trash directory.t1304-default-acl'
+ cd /usr/home/junio/buildfarm/pu/t
+ basename '/usr/home/junio/buildfarm/pu/t/trash directory.t1304-default-acl'
+ rm -rf 'trash directory.t1304-default-acl'
+ exit 0
+ die
+ code=0
+ test -n t
+ exit 0

--=-=-=--

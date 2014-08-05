From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Everyday contents (was Re: What's cooking in git.git (Jul 2014, #04; Tue, 22))
Date: Tue, 05 Aug 2014 13:26:57 -0700
Message-ID: <xmqqzjfiof72.fsf@gitster.dls.corp.google.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com>
	<B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley>
	<xmqqegxcdjzl.fsf@gitster.dls.corp.google.com>
	<7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley>
	<xmqqvbqm74v7.fsf@gitster.dls.corp.google.com>
	<xmqqegx95bxc.fsf@gitster.dls.corp.google.com>
	<xmqqvbqezs64.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 22:27:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XElKH-0002Oh-0y
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 22:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbaHEU1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 16:27:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50650 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbaHEU1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 16:27:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B062D2E3F0;
	Tue,  5 Aug 2014 16:27:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vO/DGB961MXOejCqvmXKv/GVti8=; b=F7gdXo
	GKobsTUl1djn0Jhw2LzmeH0vW8X7UXgqhjjEcHNG0O+rytmvXEbJ4W/+ufheS7Qm
	GgjGzWoCq0MxMjVMQZcuZpdrz7P9uhq7HlXieixxFvyFL2E2DeEI1Ht2LgAcp7rE
	jrFC3Gf9c+8LRejXN3ZU1SgiM4RYDjojC2L8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j9cFW9vG9lmWKia/JKE/9RJou5drQUwt
	IgfwOX1BW4vFBYsT5axpc4M4M4M7bHvDh37Jrl9T9WouX6kIIgjbjaFQnas470q3
	k3QcCs3IVxpVN5iqc0ZCCG0raA1GzzBqnrLg1jbV6X/wipfQ5KF2FLR0xIHTqn8J
	8yZ+jn78odY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A514F2E3EF;
	Tue,  5 Aug 2014 16:27:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 429982E3C8;
	Tue,  5 Aug 2014 16:27:00 -0400 (EDT)
In-Reply-To: <xmqqvbqezs64.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 30 Jul 2014 10:13:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DA901ADA-1CDE-11E4-9FF8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254824>

Continued: this message covers the last part.

| Repository Administration[[Repository Administration]]
| ------------------------------------------------------
| 
| A repository administrator uses the following tools to set up
| and maintain access to the repository by developers.
| 
|   * linkgit:git-daemon[1] to allow anonymous download from
|     repository.
| 
|   * linkgit:git-shell[1] can be used as a 'restricted login shell'
|     for shared central repository users.
| 
| link:howto/update-hook-example.html[update hook howto] has a good
| example of managing a shared central repository.

This part is fairly stale.  We only talk about allowing anonymous
fetching via git-daemon and pushing via git-over-ssh.  The readers
would want to be aware that they can set up their hosts for fetching
and pushing via git-over-http aka "Smart http", and browsing via
gitweb.  We should definitely at least mention these, and we may
even want to describe them at the same level of detail as the
existing examples.

I wonder if we also want to mention (but not describe, just make the
readers aware of) widely deployed hosting/browsing solutions such as
gitolite, gerrit code review, and cgit.

Do tasks that are described here have impact on the use of these
third-party tools?  For example, I understand gitolite does not
require one UNIX user per biological human user, but the vanilla
push-over-ssh described in these examples does.  I guess the burden
of telling the users to "unlearn everything you read about setting
up the vanilla git-over-ssh when you use gitolite" falls on gitolite
doc, so in that sense we shouldn't have to worry about doing any of
that here.

| Examples
| ~~~~~~~~
| We assume the following in /etc/services::
| +
| ------------
| $ grep 9418 /etc/services
| git		9418/tcp		# Git Version Control System
| ------------

OK.

| Run git-daemon to serve /pub/scm from inetd.::
| +
| ------------
| $ grep git /etc/inetd.conf
| git	stream	tcp	nowait	nobody \
|   /usr/bin/git-daemon git-daemon --inetd --export-all /pub/scm
| ------------
| +
| The actual configuration line should be on one line.

OK.

| Run git-daemon to serve /pub/scm from xinetd.::
| +
| ------------
| $ cat /etc/xinetd.d/git-daemon
| # default: off
| # description: The Git server offers access to Git repositories
| service git
| {
|         disable = no
|         type            = UNLISTED
|         port            = 9418
|         socket_type     = stream
|         wait            = no
|         user            = nobody
|         server          = /usr/bin/git-daemon
|         server_args     = --inetd --export-all --base-path=/pub/scm
|         log_on_failure  += USERID
| }
| ------------
| +
| Check your xinetd(8) documentation and setup, this is from a Fedora system.
| Others might be different.

OK, but which vintage of Fedora? ;-)

| Give push/pull only access to developers.::

This entry may mislead the readers if the "access" this section
talks about is to the git-daemon we just set up in the above.  We
should clarify that this is about git-over-ssh access, i.e. the
users will be doing this:

	$ git push/pull host.xz:/pub/scm/project

or

	$ git push/pull ssh://host.xz/pub/scm/project

or somesuch.

| +
| ------------
| $ grep git /etc/passwd <1>
| alice:x:1000:1000::/home/alice:/usr/bin/git-shell
| bob:x:1001:1001::/home/bob:/usr/bin/git-shell
| cindy:x:1002:1002::/home/cindy:/usr/bin/git-shell
| david:x:1003:1003::/home/david:/usr/bin/git-shell
| $ grep git /etc/shells <2>
| /usr/bin/git-shell
| ------------
| +
| <1> log-in shell is set to /usr/bin/git-shell, which does not
| allow anything but `git push` and `git pull`.  The users should
| get an ssh access to the machine.
| <2> in many distributions /etc/shells needs to list what is used
| as the login shell.

One possible mis-interpretation of <1> is "Thanks to these git-shell
entries, the users will get `push/pull` accesses to the box; they
separately need ssh access to the box (to do something more than
that, if desired)".

In reality, this configuration _requires_ them to have an ssh access
to the box and these entries restricts them to only run push/pull
against the host.  We may want to rephrase to clarify.

| CVS-style shared repository.::
| +
| ------------
| $ grep git /etc/group <1>
| git:x:9418:alice,bob,cindy,david
| $ cd /home/devo.git
| $ ls -l <2>
|   lrwxrwxrwx   1 david git    17 Dec  4 22:40 HEAD -> refs/heads/master
|   drwxrwsr-x   2 david git  4096 Dec  4 22:40 branches
|   -rw-rw-r--   1 david git    84 Dec  4 22:40 config
|   -rw-rw-r--   1 david git    58 Dec  4 22:40 description
|   drwxrwsr-x   2 david git  4096 Dec  4 22:40 hooks
|   -rw-rw-r--   1 david git 37504 Dec  4 22:40 index
|   drwxrwsr-x   2 david git  4096 Dec  4 22:40 info
|   drwxrwsr-x   4 david git  4096 Dec  4 22:40 objects
|   drwxrwsr-x   4 david git  4096 Nov  7 14:58 refs
|   drwxrwsr-x   2 david git  4096 Dec  4 22:40 remotes
| $ ls -l hooks/update <3>
|   -r-xr-xr-x   1 david git  3536 Dec  4 22:40 update
| $ cat info/allowed-users <4>
| refs/heads/master	alice\|cindy
| refs/heads/doc-update	bob
| refs/tags/v[0-9]*	david
| ------------
| +
| <1> place the developers into the same git group.
| <2> and make the shared repository writable by the group.
| <3> use update-hook example by Carl from Documentation/howto/
| for branch policy control.
| <4> alice and cindy can push into master, only bob can push into doc-update.
| david is the release manager and is the only person who can
| create and push version tags.

OK.

| HTTP server to support dumb protocol transfer.::
| +
| ------------
| dev$ git update-server-info <1>
| dev$ ftp user@isp.example.com <2>
| ftp> cp -r .git /home/user/myproject.git
| ------------
| +
| <1> make sure your info/refs and objects/info/packs are up-to-date
| <2> upload to public HTTP server hosted by your ISP.

This may want to be removed, for two reasons.  Nobody should be
using dumb HTTP anymore, and the "cp" implies that the repository is
not maintained at the isp.example.com site but is synchronized
manually from some other location with _only_ ftp access into it,
which is not a typical way to run your project (I admit I did this
myself in very early days of Git when Linus was still running the
project).

Thanks.

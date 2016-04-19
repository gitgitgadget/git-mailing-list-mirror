From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 09:34:27 +0200
Message-ID: <80FF3761-91CC-41B0-B3A1-0DC8EC348D0D@gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>
To: Jan Durovec <jan.durovec@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 09:34:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asQBI-0003n0-48
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 09:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbcDSHed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 03:34:33 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37357 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbcDSHeb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2016 03:34:31 -0400
Received: by mail-wm0-f50.google.com with SMTP id n3so14077738wmn.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 00:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Q802iJ6MNGxnvbHC5cX1cwOwo/JUKE6PBuS5u2wFCpI=;
        b=0yBcDL1Fpx00Uvl0cOZPpCw/mNKXjOZGiTuhVrUyJ5w6THjao+5RIURVcP8Ab7CneW
         gWa5BvyQobmAMPNDaz8OpfrH6i+2mtUC9CCGCgZhy89ebhmHGJY7Mu9Wihw3cS3tvr+L
         HTj2BKyQfWR0qkC5TUC33hFhe8GaGYXpitfqWi8NL8BI+ZJtQA78E9VQNzZNNcFDHR2X
         q+KHtCWK2g08d+tiN85JmcjWhgTZO70mXAlaqVAGqMzBhkxBnEgd3YZb7qzZsIoxIDzE
         c4hOoMMKviHyI8W2Lo15zs+AkfO2r1Qw3+s/CSZiadPE6tJYur09KWXbMhdpqldIFEWs
         CrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Q802iJ6MNGxnvbHC5cX1cwOwo/JUKE6PBuS5u2wFCpI=;
        b=PT0n1uuLUANCcBG0HDcH5Cdt1JwFbaXWpAxU97A0NNjhufMCityGO/cNW5bxp4wXLL
         0z7McQZHTN5Uj+8VkoFUU1XRj7gExZ61q3sHO17YDaCxFUNFAirLda8j/1X8RJZQrmfB
         QAKtoE7r0ITCuWZ0NiansisxHYJMHkoUvEN8duKy5lKOkgTcN7eVg83y1WDYFtRP9Uvh
         KnF31h24aTe3eZeZKDj5CtDyw57bgYbv8NisabLVwXCCZvnhXI218NMg88eKNX7DIr2A
         4rOocgMA8GgUD629GU3e8m95e3804mNZd3bz/nuGsfV70LAzEaCQdFoJyo4imo2xMBd7
         oVvw==
X-Gm-Message-State: AOPr4FXstJnfA5aV6OX1ZRu3aSgHxsH7F2HTCCetNm3e/AEj/LV5CGaseOAlwJcV61FA7Q==
X-Received: by 10.194.143.51 with SMTP id sb19mr1549228wjb.98.1461051269883;
        Tue, 19 Apr 2016 00:34:29 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BAC17.dip0.t-ipconnect.de. [80.139.172.23])
        by smtp.gmail.com with ESMTPSA id ck9sm62900736wjc.22.2016.04.19.00.34.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 00:34:29 -0700 (PDT)
In-Reply-To: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291850>


On 16 Apr 2016, at 21:58, Jan Durovec <jan.durovec@gmail.com> wrote:

> When migrating from Perforce to git the information about P4 jobs
> associated with P4 changelists is lost.
> 
> Having these jobs listed on messages of related git commits enables smooth
> migration for projects that take advantage of e.g. JIRA integration
> (which uses jobs on Perforce side and parses commit messages on git side).
> 
> The jobs are added to the message in the same format as is expected when
> migrating in the reverse direction.
> 
> Signed-off-by: Jan Durovec <jan.durovec@gmail.com>
> ---
> git-p4.py              | 12 ++++++
> t/lib-git-p4.sh        | 10 +++++
> t/t9829-git-p4-jobs.sh | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 121 insertions(+)
> create mode 100755 t/t9829-git-p4-jobs.sh
> 
> diff --git a/git-p4.py b/git-p4.py
> index 527d44b..8f869d7 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2320,6 +2320,15 @@ def extractFilesFromCommit(self, commit):
>             fnum = fnum + 1
>         return files
> 
> +    def extractJobsFromCommit(self, commit):
> +        jobs = []
> +        jnum = 0
> +        while commit.has_key("job%s" % jnum):
> +            job = commit["job%s" % jnum]
I tried to use the new format string syntax in the past. See:
https://pyformat.info/
https://docs.python.org/2/library/string.html#format-string-syntax

'job{}'.format(jnum)

@Luke: What do you prefer going forward?


> +            jobs.append(job)
> +            jnum = jnum + 1
> +        return jobs
> +
>     def stripRepoPath(self, path, prefixes):
>         """When streaming files, this is called to map a p4 depot path
>            to where it should go in git.  The prefixes are either
> @@ -2665,6 +2674,7 @@ def hasBranchPrefix(self, path):
>     def commit(self, details, files, branch, parent = ""):
>         epoch = details["time"]
>         author = details["user"]
> +        jobs = self.extractJobsFromCommit(details)
> 
>         if self.verbose:
>             print('commit into {0}'.format(branch))
> @@ -2692,6 +2702,8 @@ def commit(self, details, files, branch, parent = ""):
> 
>         self.gitStream.write("data <<EOT\n")
>         self.gitStream.write(details["desc"])
> +        if len(jobs) > 0:
> +            self.gitStream.write("\nJobs: %s" % (' '.join(jobs)))
You could use the new string syntax here, too. 
How long is an avg job string? Could it make sense to write them into
individual lines? Would it makes sense to add an extra new line after
the commit message? I assume not because your commit messages says
"same format as is expected when migrating"...


>         self.gitStream.write("\n[git-p4: depot-paths = \"%s\": change = %s" %
>                              (','.join(self.branchPrefixes), details["change"]))
>         if len(details['options']) > 0:
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index f9ae1d7..3907560 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -160,6 +160,16 @@ p4_add_user() {
> 	EOF
> }
> 
> +p4_add_job() {
> +	name=$1 &&
> +	p4 job -f -i <<-EOF
> +	Job: $name
> +	Status: open
> +	User: dummy
> +	Description:
> +	EOF
> +}
> +
> retry_until_success() {
> 	timeout=$(($(time_in_seconds) + $RETRY_TIMEOUT))
> 	until "$@" 2>/dev/null || test $(time_in_seconds) -gt $timeout
> diff --git a/t/t9829-git-p4-jobs.sh b/t/t9829-git-p4-jobs.sh
> new file mode 100755
> index 0000000..2b9c98c
> --- /dev/null
> +++ b/t/t9829-git-p4-jobs.sh
> @@ -0,0 +1,99 @@
> +#!/bin/sh
> +
> +test_description='git p4 retrieve job info'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'add p4 jobs' '
> +	(
> +		p4_add_job TESTJOB-A &&
> +		p4_add_job TESTJOB-B
> +	)
> +'
> +
> +test_expect_success 'add p4 files' '
> +	client_view "//depot/... //client/..." &&
> +	(
> +		cd "$cli" &&
> +		>file1 &&
> +		p4 add file1 &&
> +		p4 submit -d "Add file 1"
> +	)
> +'
> +
> +test_expect_success 'check log message of changelist with no jobs' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +		cat >expect <<-\EOF &&
> +Add file 1
> +[git-p4: depot-paths = "//depot/": change = 1]
> +
> +		EOF
> +		git log --format=%B >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'add TESTJOB-A to change 1' '
> +	(
> +		cd "$cli" &&
> +		p4 fix -c 1 TESTJOB-A
> +	)
> +'
> +
> +test_expect_success 'check log message of changelist with one job' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +		cat >expect <<-\EOF &&
> +Add file 1
> +Jobs: TESTJOB-A
> +[git-p4: depot-paths = "//depot/": change = 1]
> +
> +		EOF
> +		git log --format=%B >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'add TESTJOB-B to change 1' '
> +	(
> +		cd "$cli" &&
> +		p4 fix -c 1 TESTJOB-B
> +	)
> +'
> +
> +test_expect_success 'check log message of changelist with more jobs' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +		cat >expect <<-\EOF &&
> +Add file 1
> +Jobs: TESTJOB-A TESTJOB-B
> +[git-p4: depot-paths = "//depot/": change = 1]
> +
> +		EOF
> +		git log --format=%B >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
> 
> --
> https://github.com/git/git/pull/225
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

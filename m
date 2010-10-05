From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] Pull request from msysGit
Date: Tue, 05 Oct 2010 09:45:01 -0700
Message-ID: <7v8w2c7fn6.fsf@alter.siamese.dyndns.org>
References: <87ocb9zfbf.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 18:45:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Adm-0008MX-Al
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 18:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206Ab0JEQpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 12:45:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab0JEQpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 12:45:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64E08DC36C;
	Tue,  5 Oct 2010 12:45:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6Lok/4FtKyCgN7Ki+yvgL1nK7fw=; b=bzH9UfT4berDZydKDwMBWy3
	LsiPKIvv1D2GU9qbHmz1/sxl9mi1tcQVr2wRS5UjTJI+114WEdJq944vLoZXfP1i
	FvazUKZqlbqy+txTKgZKs0hDYFwrc2w///kMrl79ALSs7V70peAiBo7II7gLkvPz
	yb2EoqFRpf6aPtUijZjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=XhOkKYER0EgWS/JDFRnLK2KiLUC8GGIBSoedsfIltdUItwSOq
	Zgkr/7/2Fh7VWNIwinRhaWauXME9nachK9hgFr+/RV0bthANPYZrs1DKf/ic2nri
	SvqVJ9bIEXB4lUS9fcZ+t1A1vSjjXoq+dyJppWEIAqRuDoRo0UThyS/Sao=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31983DC367;
	Tue,  5 Oct 2010 12:45:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 506EADC35E; Tue,  5 Oct
 2010 12:45:03 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E8FD3222-D09F-11DF-9498-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158215>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> This follows up on the comments made for the previous pull request for
> patches from msysGit. This batch is restricted to those that passed
> review or have been modified as a result of the earlier review.
> I've added some Acked-by's resulting from comments made.
>
> The following changes since commit 1e633418479926bc85ed21a4f91c845a3dd3ad66:
>
>   Merge branch 'maint' (2010-09-30 14:59:53 -0700)
>
> are available in the git repository at:
>
>   git://repo.or.cz/git/mingw/4msysgit.git work/pt/for-junio
> or alternatively
>   http://repo.or.cz/w/git/mingw/4msysgit.git/shortlog/refs/heads/work/pt/for-junio

Thanks.

> 5debf9a Add MinGW-specific execv() override.
> 77df1f1 Fix Windows-specific macro redefinition warning.
> b248e95 Fix 'clone' failure at DOS root directory.
> 1a40420 mingw: do not crash on open(NULL, ...)
> 5e9677c git-am: fix detection of absolute paths for windows
> 36e035f Side-step MSYS-specific path "corruption" leading to t5560 failure.
> ca02ad3 Side-step sed line-ending "corruption" leading to t6038 failure.
> 97f2c33 Skip 'git archive --remote' test on msysGit
> a94114a Do not strip CR when grepping HTTP headers.
> 3ba9ba8 Skip t1300.70 and 71 on msysGit.
> 4e57baf merge-octopus: Work around environment issue on Windows
> 442dada MinGW: Report errors when failing to launch the html browser.
> 9b9784c MinGW: fix stat() and lstat() implementations for handling symlinks
> 4091bfc MinGW: Add missing file mode bit defines
> e7cf4e9 MinGW: Use pid_t more consequently, introduce uid_t for greater compatibility
>
>  abspath.c                        |    6 +++-
>  compat/mingw.c                   |   56 ++++++++++++++++++++++++++++++++-----
>  compat/mingw.h                   |   36 +++++++++++++++++++-----
>  git-am.sh                        |   12 ++++----
>  git-merge-octopus.sh             |    5 +++
>  git-sh-setup.sh                  |   15 ++++++++++
>  t/t1300-repo-config.sh           |    6 ++--
>  t/t5000-tar-tree.sh              |    2 +-
>  t/t5503-tagfollow.sh             |    9 +-----
>  t/t5560-http-backend-noserver.sh |    5 ++-
>  t/t6038-merge-text-auto.sh       |    4 ++-
>  t/test-lib.sh                    |    2 +
>  12 files changed, 122 insertions(+), 36 deletions(-)

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] svn pathnameencoding for git svn dcommit
Date: Mon, 15 Feb 2016 13:32:02 -0800
Message-ID: <xmqq4md9r771.fsf@gitster.mtv.corp.google.com>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
	<20160208225806.GA3487@dcvr.yhbt.net>
	<20160215005210.GA31141@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, alex.crezoff@gmail.com,
	Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:32:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQkc-0001xv-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbcBOVcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:32:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751120AbcBOVcE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:32:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AA2E45DA0;
	Mon, 15 Feb 2016 16:32:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P0lamGz6mI7hJxaJW0lp61SNcRU=; b=UDdI0Y
	MI5x8RVePIVFF6vm1KA27Moia1/6ig8yDFo6fwSiGLaPAQLylxKCWp2wz5G3AmaZ
	RvP3rRGzntq0ImlyWPq/Er5ZXY7whslt4oyRz7KqsfVp3GjvI3eqAiGif1Ckg9di
	xpNfRIusg9flCByvzLQ2T0mc5ct3+aiuB5+I0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GnqX48dG2g7KfXs9aLH6091n38O0qutW
	TFNaOQzCxrnJcF6nLRqsWfESTPhUHjjD1l2E79V1lnoWsYeJcLLvi6gDiZ9aUsI2
	hhSmsBZbZMT2GgiseVTCE/qCS7Cd+g48kEWCFZ3KKbRAjWLZVX+7PysLlFjVigwS
	+Ure9lgBNxA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41D2F45D9E;
	Mon, 15 Feb 2016 16:32:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B1FE245D9C;
	Mon, 15 Feb 2016 16:32:03 -0500 (EST)
In-Reply-To: <20160215005210.GA31141@dcvr.yhbt.net> (Eric Wong's message of
	"Mon, 15 Feb 2016 00:52:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E1A80F4-D42B-11E5-8EC5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286244>

Eric Wong <normalperson@yhbt.net> writes:

> I've amended tests to both commits, but the URL encoding one
> requires an HTTP server to test effectively.
>
> I couldn't find a test prereq for httpd, but perhaps it's good
> to test by default regardless in case a future SVN changes
> file:// behavior.  I've only tested this with SVN 1.6.17 under
> Debian wheezy.
>
> The following changes since commit 6faf27b4ff26804a07363078b238b5cfd3dfa976:
>
>   Merge branch 'tb/conversion' into next (2016-02-12 10:20:20 -0800)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn.git ks/svn-pathnameencoding
>
> for you to fetch changes up to dfee0cf8123e7f63268f05a02731ce82db136188:
>
>   git-svn: apply "svn.pathnameencoding" before URL encoding (2016-02-15 00:31:21 +0000)

Sorry, Eric, I cannot pull this.  You made your branch on top of
'next', there are many commits that are not ready.

>
> ----------------------------------------------------------------
> Kazutoshi Satoda (2):
>       git-svn: enable "svn.pathnameencoding" on dcommit
>       git-svn: apply "svn.pathnameencoding" before URL encoding
>
>  perl/Git/SVN/Editor.pm                   |  4 +++-
>  t/t9115-git-svn-dcommit-funky-renames.sh | 26 ++++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 3 deletions(-)

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] updates to gitk, git-gui and git-svn for 2.8?
Date: Tue, 15 Mar 2016 10:33:44 -0700
Message-ID: <xmqq7fh38x3b.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1qwaopd.fsf@gitster.mtv.corp.google.com>
	<20160315015726.GA25295@dcvr.yhbt.net>
	<20160315071839.GB24036@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Victor Leschuk <vleschuk@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	k_satoda Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 18:33:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afsqu-0001qM-D8
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 18:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934829AbcCORdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 13:33:49 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934833AbcCORdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 13:33:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22BA44D408;
	Tue, 15 Mar 2016 13:33:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JOduQ921bkTrQPUj5MroOaCrKuw=; b=C4tC3t
	8x7+cPFI5E8dNmFY0rdHMA+SW2nLFDCqzYJV896J1375uSH8xQ8vA2Bx8NMdRrcO
	pNPrEUFhtjm67pQWbcQTGqzE+0f0HBwF5mpbLw9pIZiCMd9u6BTnl3uXUeLhnroG
	uhSB74n4YdLhGlW7I9F1pZ6AlnSsv3BktY5k0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SkYoBhVbj3MwMiMaqpMXiBInid42JxxT
	w3P3/8VPgRK4NUmoMrYFom05WGnj0/3bTw1LiTekBfTAAlF5q2hFJQaVnXDBpONI
	KjMkqmhTevPy6TO6eXDTf3JlAeg52bqeDnpvLBgdezthNc39tpJaxv1KxOCOeDCQ
	b7M8h83uXHw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1AB354D407;
	Tue, 15 Mar 2016 13:33:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 839C74D406;
	Tue, 15 Mar 2016 13:33:45 -0400 (EDT)
In-Reply-To: <20160315071839.GB24036@dcvr.yhbt.net> (Eric Wong's message of
	"Tue, 15 Mar 2016 07:18:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 11BC8C2C-EAD4-11E5-B362-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288887>

Eric Wong <normalperson@yhbt.net> writes:

> Anyways, we'll let that cook a while and the other two patches
> can be had at:
>
> The following changes since commit db6696f653b917509dac1ac13b922e12773a84ff:
>
>   Merge branch 'mg/wt-status-mismarked-i18n' (2016-03-14 10:46:17 -0700)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn.git svn-glob
>
> for you to fetch changes up to 62335bbbc747c96636b5ce9917b156304c732eaf:
>
>   git-svn: shorten glob error message (2016-03-15 01:35:39 +0000)
>
> ----------------------------------------------------------------
> Eric Wong (1):
>       git-svn: shorten glob error message
>
> Victor Leschuk (1):
>       git-svn: loosen config globs limitations
>
>  Documentation/git-svn.txt                  |  12 ++
>  perl/Git/SVN/GlobSpec.pm                   |  18 ++-
>  t/t9108-git-svn-glob.sh                    |   9 +-
>  t/t9109-git-svn-multi-glob.sh              |   9 +-
>  t/t9168-git-svn-partially-globbed-names.sh | 223 +++++++++++++++++++++++++++++
>  5 files changed, 258 insertions(+), 13 deletions(-)
>  create mode 100755 t/t9168-git-svn-partially-globbed-names.sh

Thanks.  Pulled.

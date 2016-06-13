From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for 2.9.0 rc0
Date: Sun, 12 Jun 2016 18:01:11 -0700
Message-ID: <xmqqvb1ddhrc.fsf@gitster.mtv.corp.google.com>
References: <CANYiYbG_DaLX1ipRh4To2iPDtuYxRMMtxWrFbEY1GyrrRCbfdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Changwoo Ryu <cwryu@debian.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 03:01:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCGFm-0001Yw-PD
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 03:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933097AbcFMBBP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 21:01:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932986AbcFMBBP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2016 21:01:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8078624112;
	Sun, 12 Jun 2016 21:01:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=orUqZ/Lr62XI
	j7MupqIWo9hYh6U=; b=ygQMPP5bcMY7XaRLCE/KCpC3iAnUxg5G90qWjY7nZOsY
	8OPlFWV4HdTcy0D1MOrllYHvrzAU9hYWojh3G1vC068Bpbo1ssEP9Ipw+l4ZPAC5
	hopvC2K6Wj7NmXTk0Qur25TMVODWbaiWLJ7iWk1qHEJxLKK3QwkhiXbkrKTzmyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ya14mE
	9zBHXjMpfaWm0FjIlwk2RwQINrxXlA500u5TXWfzKOjLQ31QyQ0Nb6W5Y9voECH8
	yBQ/Rn6W072RJ1CGistWxANyrt1bMt76uJt+ZbrBZvAeZik9/yOph3T5J8Wnn3U2
	+1dPN/SaLR/Y81ngXgH1HYojGscEDr0qahFlY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C3DE24111;
	Sun, 12 Jun 2016 21:01:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE07224110;
	Sun, 12 Jun 2016 21:01:12 -0400 (EDT)
In-Reply-To: <CANYiYbG_DaLX1ipRh4To2iPDtuYxRMMtxWrFbEY1GyrrRCbfdA@mail.gmail.com>
	(Jiang Xin's message of "Sun, 12 Jun 2016 06:13:54 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 52C72CEE-3102-11E6-8249-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297147>

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull the following git l10n updates.
>
> The following changes since commit 3a0f269e7c82aa3a87323cb7ae04ac5f12=
9f036b:
>
>   Git 2.9-rc0 (2016-05-23 15:02:48 -0700)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.9.0-rc0
>
> for you to fetch changes up to ad583ebe0813c5d6a8e7c263d72d934770083d=
83:
>
>   l10n: ko.po: Update Korean translation (2016-06-12 01:25:58 +0900)

Thanks, will do.

>
> ----------------------------------------------------------------
> l10n-2.9.0-rc0
>
> ----------------------------------------------------------------
> Alexander Shopov (1):
>       l10n: Updated Bulgarian translation of git (2597t,0f,0u)
>
> Antonin (1):
>       l10n: fr.po Fixed grammar mistake
>
> Changwoo Ryu (1):
>       l10n: ko.po: Update Korean translation
>
> Dimitriy Ryazantcev (1):
>       l10n: ru.po: update Russian translation
>
> Jean-Noel Avila (1):
>       l10n: fr.po v2.9.0rnd1
>
> Jiang Xin (5):
>       l10n: git.pot: v2.9.0 round 1 (104 new, 37 removed)
>       Merge branch 'fix_fr' of git://github.com/jnavila/git
>       Merge branch 'v2.9.0_rnd1_fr' of git://github.com/jnavila/git
>       l10n: zh_CN: for git v2.9.0 l10n round 1
>       Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po=
-ru
>
> Peter Krefting (1):
>       l10n: sv.po: Update Swedish translation (2597t0f0u)
>
> Ralf Thielow (1):
>       l10n: de.po: translate 104 new messages
>
> Ray Chen (1):
>       l10n: zh_CN: review for git v2.9.0 l10n round 1
>
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
>       l10n: Updated Vietnamese translation (2597t)
>
> Vasco Almeida (3):
>       l10n: pt_PT: merge git.pot file
>       l10n: pt_PT: update according to git-gui glossary
>       l10n: pt_PT: update Portuguese translation
>
>  po/bg.po    | 4689 +++++++++++++++++++++++++++++++++----------------=
----------
>  po/de.po    | 3310 +++++++++++++++++++++++------------------
>  po/fr.po    | 3252 +++++++++++++++++++++++------------------
>  po/git.pot  | 3078 ++++++++++++++++++++++-----------------
>  po/ko.po    | 3192 ++++++++++++++++++++++------------------
>  po/pt_PT.po | 3893 +++++++++++++++++++++++++++----------------------
>  po/ru.po    | 3171 ++++++++++++++++++++++------------------
>  po/sv.po    | 3269 +++++++++++++++++++++++------------------
>  po/vi.po    | 3274 +++++++++++++++++++++++------------------
>  po/zh_CN.po | 3375 ++++++++++++++++++++++--------------------
>  10 files changed, 19378 insertions(+), 15125 deletions(-)
>
> --
> Jiang Xin

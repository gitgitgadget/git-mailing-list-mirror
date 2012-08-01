From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull git-l10n updates for git v1.7.12-rc0
Date: Wed, 01 Aug 2012 15:59:42 -0700
Message-ID: <7va9yedxr5.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHHBAOKw-5LMs_QgMaucdOH-sSRwrOX5Ad2RLvxJuWctQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOi?= =?utf-8?B?bg==?= 
	<vnwildman@gmail.com>, Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Riku <lu.riku@gmail.com>, Zhuang Ya <zhuangya@me.com>,
	Lian Cheng <rhythm.mail@gmail.com>,
	Yichao Yu <yyc1992@gmail.com>,
	ws3389 <willsmith3389@gmail.com>, Thynson <lanxingcan@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 01:00:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwhtZ-0002KY-E4
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 01:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676Ab2HAW7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 18:59:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157Ab2HAW7p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 18:59:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB5683EB;
	Wed,  1 Aug 2012 18:59:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XCTQnsPrVLot98q0AKBMMfUIrJU=; b=BtKQDL
	5sKBrcRLO5u+JcwhXbsuKKl7kgWud1L23AmtNOB9mYLKLeD/HBOL3GrLssb3r409
	rjwz5UcpiC6YrIdqFNmJlAd6/Kddn0jn3XpbqjInDe0jdc9rfWbavQVUZUSje+81
	amqBwYMPhGYTnBlMqo03emO+QEo8mcBdMEV04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pC9djE1U7YVemznJ1HCxgt5/+EdCcZLo
	2qFpq6zWiht/Ddm62nlJYqPgmFV9zPkDactdFpPLBQBnXGTN2tHgtr6pBN36Qqfv
	ZsAGpxIvSFVu8tL7wl8MH6q9NL3ov4PhomEZ3FFOCsZvZ2PFJNPfQBjGRoBLgiHh
	H/tsnoPcySA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9CEA83EA;
	Wed,  1 Aug 2012 18:59:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3939383E7; Wed,  1 Aug 2012
 18:59:44 -0400 (EDT)
In-Reply-To: <CANYiYbHHBAOKw-5LMs_QgMaucdOH-sSRwrOX5Ad2RLvxJuWctQ@mail.gmail.com> (Jiang
 Xin's message of "Thu, 2 Aug 2012 06:34:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 958132CA-DC2C-11E1-84CF-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202739>

Jiang Xin <worldhello.net@gmail.com> writes:

> The following changes since commit 9e2116adbe192f3090785bdf3412bf7e3e2767b7:
>
>   Update draft release notes to 1.7.12 (2012-07-27 22:25:19 -0700)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po master
>
> for you to fetch changes up to 9c87b0d28f05c8ffcfe28da32161827cf0bac8e7:
>
>   l10n: de.po: translate 4 new messages (2012-07-31 17:01:15 +0200)
>
> ----------------------------------------------------------------
> Jiang Xin (2):
>       l10n: Update git.pot (4 new, 3 removed messages)
>       l10n: zh_CN.po: translate 4 new messages
>
> Ralf Thielow (1):
>       l10n: de.po: translate 4 new messages
>
> Tran Ngoc Quan (1):
>       l10n: vi.po: translate 4 new messages
>
>  po/de.po    | 1000 ++++++++++++++++++++++++-----------------------
>  po/git.pot  |  953 ++++++++++++++++++++++----------------------
>  po/vi.po    | 1074 +++++++++++++++++++++++++-------------------------
>  po/zh_CN.po | 1259 ++++++++++++++++++++++++++++++++++++-----------------------
>  4 files changed, 2305 insertions(+), 1981 deletions(-)

Thanks, will do.

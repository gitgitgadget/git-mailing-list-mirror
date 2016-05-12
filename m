From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/7] i18n miscellaneous updates
Date: Thu, 12 May 2016 14:10:39 -0700
Message-ID: <xmqqposrc78w.fsf@gitster.mtv.corp.google.com>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
	<1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Thu May 12 23:10:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0xsh-0002vX-18
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 23:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbcELVKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 17:10:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751330AbcELVKo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 17:10:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DC361AADB;
	Thu, 12 May 2016 17:10:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LPeDrYScrSjFvkjW89l/o9RpkIw=; b=wM22YQ
	4UaTiuRrH9ClhDJ5/wq4br5udKvNVjY9BloR0FcoM5pbwIXKuRkXXAM2VxDbR4MU
	HfOe7pZUq0ww7ni86Ifuu0Med1QNPgdsjwBRsaSAXAyf3uOKP+d+Umsa0+ATVHIL
	pCZpyoSKHYxRsfTR30NPnnNi735/KoOa7zDbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PyvbL6hZ3a5HEpMTEU6eNWR3p/GKhUIJ
	TQgk3MuRfS2kXyPBeJTXffGrQwlBB7QOFyyEiaSsrvBHTXoACmgn2ybeRX2SRkuq
	25xjawcQ3fPH92GwAb06PIF3VIHKmuALRuP35Z3ZiTnf9K477PZtKyTqXcHiu246
	/8bKtoxEOro=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 46ADF1AADA;
	Thu, 12 May 2016 17:10:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF0131AAD7;
	Thu, 12 May 2016 17:10:42 -0400 (EDT)
In-Reply-To: <1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Thu, 12 May 2016 19:59:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FC896A48-1885-11E6-B95F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294478>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> This re-roll upadates patch
>   i18n: unpack-trees: mark strings for translation

Sorry, unfortunately you cannot take them back anymore.  These from
the previous round are already in 'next'.

    daf9f64 i18n: builtin/pull.c: split strings marked for translation
    8a0de58 i18n: builtin/pull.c: mark placeholders for translation
    045fac5 i18n: git-parse-remote.sh: mark strings for translation
    60ea78b i18n: branch: move comment for translators
    2010aab i18n: branch: unmark string for translation
    8ae51c4 i18n: builtin/rm.c: remove a comma ',' from string
    ed47fdf i18n: unpack-trees: mark strings for translation
    ab86885 i18n: builtin/branch.c: mark option for translation
    71d99b8 i18n: index-pack: use plural string instead of normal one

I think the update to unpack-trees.c (v4 2/7) makes more sense than
what was in ed47fdf, so perhaps you can send it in as an incremental
update (and others changes made since the commits listed above)?

Thanks.

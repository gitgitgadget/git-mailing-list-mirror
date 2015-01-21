From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: bundle: mark git-bundle usage for translation
Date: Wed, 21 Jan 2015 13:13:21 -0800
Message-ID: <xmqqiofzx2fi.fsf@gitster.dls.corp.google.com>
References: <1421867023-31730-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE2af-00051p-0f
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 22:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbbAUVNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 16:13:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752547AbbAUVNY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 16:13:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D8E6309C0;
	Wed, 21 Jan 2015 16:13:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dYHsBQqDPKcGT1RRZ/L2m6wp8ho=; b=m3vdDC
	SB5MD8V6jebUAU8sJlFThzQLznhGq8sYX4CSiYWNLHLsSJGoqxLM2QAezStTuwi6
	UMVq1JAugXQkTXaD7Kex+xygNGkOLLXjo9kHr128BSnIwustxquvLOcN8efiWrKa
	d+ZvlByRdPpFfOP6fnP65B14qxBBJPfY3aBm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QV5FdietzFsW4q+sN5mOpizV1rQ6X6vN
	ptTRVtTMbyTQMnXh/g8DM9eyC+XkvP6DFZCqRtl1mtVkvkriWSbvg52jDYBMPnbq
	m6W7/thHqQRPF2Yyrmvoqc8GzcbjtOw/4K0Y7wptcV+pwTTYWz2ZIz7n+n+HMcJL
	oWit4/f+EHw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 959E9309BF;
	Wed, 21 Jan 2015 16:13:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14DB8309BE;
	Wed, 21 Jan 2015 16:13:23 -0500 (EST)
In-Reply-To: <1421867023-31730-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Thu, 22 Jan 2015 01:03:43 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 550A387E-A1B2-11E4-BC1B-D3749F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262769>

Thanks, but please hold this off until the 2.3 final is tagged.

It is way too late for anything that is not a regression fix at this
point in this cycle, and changes that affect i18n are the last thing
we want to take late in the cycle because l10n people need time to
update the translations.

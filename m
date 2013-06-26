From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/5] Reroll patches against v1.8.3.1
Date: Wed, 26 Jun 2013 09:19:37 -0700
Message-ID: <7vehboyhd2.fsf@alter.siamese.dyndns.org>
References: <cover.1372149305.git.Alex.Crezoff@gmail.com>
	<cover.1372240998.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 18:19:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrsRd-000620-76
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 18:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab3FZQTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 12:19:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45197 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab3FZQTl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 12:19:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CBDD2ABAD;
	Wed, 26 Jun 2013 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bCyC6BzkioWAeqgGlifRALsHhR0=; b=dv3rv9
	KYR4cd/4m1rm76Q0AT9QbcUU8ap6aT5bp9ZVJqrS9xMciBD9jRcSNezvesJY7XVI
	tWscUwZZ1vNmtpU3WdcSpJYO7LmimtgLA8fWqunN/0aVjOto+aFgHsTRw425H4WD
	Pq1nlAi6qggSyBaZzoqpDZyq83Wb39t02L2oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vI/yLy+W27ocB1AxyJfmFsVHdDPMRdNP
	tUD8LtQDWwAvuKAja7hSSHgBLleTujXsoxT9HZKFhoOWAv3b9vleB9szHc0r0289
	HETo4San/aUvJmE0YUfGOF1HDPqZgR7D3rFShByaXzOymxZml+XYtR+NvG1BQ2Dv
	5Og6w7s+mkM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 515792ABAC;
	Wed, 26 Jun 2013 16:19:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E05AF2ABA7;
	Wed, 26 Jun 2013 16:19:38 +0000 (UTC)
In-Reply-To: <cover.1372240998.git.Alex.Crezoff@gmail.com> (Alexey Shumkin's
	message of "Wed, 26 Jun 2013 14:19:45 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 331BE762-DE7C-11E2-98BC-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229046>

Alexey Shumkin <Alex.Crezoff@gmail.com> writes:

> v7 of this patch series includes the following changes against v6:
> 1. [PATCH v7 1/5] t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs
> 	untouched
> 2. [PATCH v7 2/5] t7102 (reset): don't hardcode SHA-1 in expected outputs
> 	untouched
> 3. [PATCH v7 3/5] t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
> 	untouched
> 4. [PATCH v7 4/5] pretty: Add failing tests: --format output should honor logOutputEncoding
>     cp1251 encoding changed to iso-8859-1 encoding already used in tests
>     Test commit messages contain words ("changed" and "added") in German
>     (which is covered by iso-8859-1 encoding)
>     They are translated from English (verified in Russian) with Google Translate
> 5. [PATCH v7 5/5] pretty: --format output should honor logOutputEncoding
>     builtin/reset.c:
>         "const char ..., *msg;" declaration replaced with "char *msg;"
>         to avoid compiler warning on the line "logmsg_free(msg, commit);"
>
> P.S.
> It's all started here [http://thread.gmane.org/gmane.comp.version-control.git/177634]

Thanks for a quick reroll and reference to previous threads in the
cover letter.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: mark more index-pack strings for translation
Date: Fri, 31 Aug 2012 13:02:20 -0700
Message-ID: <7vfw72n837.fsf@alter.siamese.dyndns.org>
References: <1346415184-25685-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 22:02:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7XQI-0007Pm-2i
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 22:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015Ab2HaUCY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Aug 2012 16:02:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754974Ab2HaUCX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2012 16:02:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 275069BCD;
	Fri, 31 Aug 2012 16:02:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=l729M4t2H1Mh
	TcPYHcm+OKhG9QU=; b=De2KqU2lAIhETejU3TuL1qtKtHe6p4SVO6jfeLFJGyQ8
	qY+dIhY7hoy0apYJYp8I3UqE20YHpLxLQcO9TfT3pPUMrQlqRQtlHCCpM1/ov74m
	+FDo1UrKtT4apOrahjzfC9rUXRDF66IW/fsXOvz3yO8ZJ93kbNo0b6XGKwGwutM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=O3AsWD
	yX82I6l8HvR7So+1f7JxX5Rh14OWNxkmObxsUEehIdhcwxZ46oeQai+I4sr1I5eA
	DVq/sQTZylJ326Si3DqPyzhsaw92fjqL2CqHk5NVFS7Wkn+4SNkC807MP/t+Zpow
	h5PTnMxVYg01CJhSr5VWTK/DK1Onqxnp6SY7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 148CB9BCB;
	Fri, 31 Aug 2012 16:02:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8715E9BCA; Fri, 31 Aug 2012
 16:02:22 -0400 (EDT)
In-Reply-To: <1346415184-25685-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 31 Aug
 2012 19:13:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6F0A9A8-F3A6-11E1-9B06-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204608>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  The main string I'm after is "completed with %d local objects", whic=
h
>  is part of typical UI. The rest is just "while at there..."
>
>  To my surprise, (GNU) gettext does seem to know how to deal with
>  PRIu32 macro in the middle of the string.

;-)

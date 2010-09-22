From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 000/160] [PULL] Update ab/i18n (again)
Date: Wed, 22 Sep 2010 11:49:14 -0700
Message-ID: <7vsk11sjf9.fsf@alter.siamese.dyndns.org>
References: <1285015029-23103-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 20:49:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyUNn-0001Vc-Q2
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 20:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab0IVStY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 14:49:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab0IVStY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 14:49:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A4D1D8C90;
	Wed, 22 Sep 2010 14:49:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HSNMqy1r1evRdtt6Xr/f1AdmpT4=; b=uzUU+p
	/oNd9gDmgkXHefKnuybfPV4dlMVQHjbuBgba4eHYobk9RBoP1heNTGeq749I5K39
	KC/hqQ6rzTAhe/Pypt/eNvI6w+0LHd6qaRav7Vr254SXWiv4zMlsjfpuStb8p0LX
	KiZrPDC+IVlswYYCuKyC4VgvbSGrc+iMGoBDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GR0aTptaonjXpX6yHqkKg7U+oGqFORr/
	vEKNfj8cQ58E9trhZTjF/B/8flLupP7J4BnjItxy/Vb3RsTLMGuixB9bWLtfNLgF
	COOhNg3g1mcmeeeS/u6Ik3FQR8Fe+yuuipfg+t4Y+wjxgMjvKd08HIwVac4A5DQ9
	TlSf5g1ivUE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 372A0D8C8E;
	Wed, 22 Sep 2010 14:49:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DB22D8C8C; Wed, 22 Sep
 2010 14:49:16 -0400 (EDT)
In-Reply-To: <1285015029-23103-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 20 Sep
 2010 20\:37\:09 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1B5FEFA0-C67A-11DF-AA44-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156822>

$ make doc
make -C Documentation all
make[1]: Entering directory `/scratch/junio/buildfarm/pu/Documentation'
rm -f cmd-list.made && \
        /usr/bin/perl ./cmd-list.perl ../command-list.txt  && \
        date >cmd-list.made
No such file git-sh-i18n.txt at ./cmd-list.perl line 10.

Hmm?

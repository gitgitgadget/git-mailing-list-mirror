From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-revert doesn't run commit-msg hook
Date: Mon, 21 May 2012 15:13:35 -0700
Message-ID: <7vmx516v3k.fsf@alter.siamese.dyndns.org>
References: <CAGHpTBJBxVcSX_0qqfFv==qyP4cpoY+U5yK-SB1Firo_uwqX3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Orgad and Raizel Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 00:13:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWarH-0003Y1-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462Ab2EUWNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:13:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932283Ab2EUWNh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:13:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 016338D8D;
	Mon, 21 May 2012 18:13:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3iQpQ8/PmHRBLXnKdW3IVlexdlo=; b=HfNYIo
	ClFnVvhw2fKPRrKoickoR8wavYPtO2Pkz6VdcLu7GsSmo5tJ/GuOdPFPtEhNn7Ne
	SxDDoOqTR/zhWo7DVTA3FH72YSKx0P/j1KK9yOvy37XDNITAPu18RYfQHU0wp3Eb
	ZO5HX1jH+N7pzjvy8Yrp7Sd7VIPq6t8KPtwSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bqnX8lxbkIAFr/7Pp+XB0gdokHF4vGyC
	Kh4534UHZ61jGGcSOv3/s8cwHaKaVJJJyNtALdZtSpmQOZ1/B53gh+YzN+OP/0dd
	7oKDdFYkEWy7+B/aCG2O2zYWGuq0GWTsO1yoGqhmKL9eolD0QHRfPVduuQQ3eRdH
	hcJng9zUk+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED1418D8A;
	Mon, 21 May 2012 18:13:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8728E8D88; Mon, 21 May 2012
 18:13:36 -0400 (EDT)
In-Reply-To: <CAGHpTBJBxVcSX_0qqfFv==qyP4cpoY+U5yK-SB1Firo_uwqX3w@mail.gmail.com> (Orgad
 and Raizel Shaneh's message of "Mon, 21 May 2012 14:29:46 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3613A548-A392-11E1-A02A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198133>

Orgad and Raizel Shaneh <orgads@gmail.com> writes:

> Running git-revert opens commit editor, but doesn't run commit-msg
> hook afterwards.

Correct.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH 5/7] git-log.txt: rewrite note on why "--" may be required
Date: Mon, 29 Apr 2013 09:33:12 -0700
Message-ID: <7va9ohl2k7.fsf@alter.siamese.dyndns.org>
References: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
	<1366608631-21734-6-git-send-email-artagnon@gmail.com>
	<7vmwsn8ok4.fsf_-_@alter.siamese.dyndns.org>
	<CALkWK0m2__SZmpyQqLjkJuMWtPuD4=Oo7QrYovq_Fw6fpHEXXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 18:34:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWr1a-0005nC-QO
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 18:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274Ab3D2QdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 12:33:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757469Ab3D2QdO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 12:33:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37CFD19C68;
	Mon, 29 Apr 2013 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=JxGB4RxFzEsvmzm3s1f0AX7D4JE=; b=bEwkuoMuyUsMqGE8sMyN
	+GFfXaveXUsxQKc7apNQSTBgOuFtrPVYzwy2bteByb7GwLSnIdnIX4HSq/RyNiXV
	9oR+z+Ph4gFKAtPdgPYf4eAEn/TnupsKp/MM4Uhxj+KiiTUiDpbl2ZP8uOCOXE+W
	8L3Q8CtnZArmoExnTGdZ2j4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dS/CeJ7AE4l7Qy5glYD5Pt33xcP8NJ3YKFymI7v+QMo6lR
	6pbzNojLMWKO3XU8tS0ifwcaUG2Q8TpBIr3bjOr0Uk0FNNfrZgzUJtGR65oEqK6R
	CKssJRKY4ryRXY6zCuKnW4F6u3PTt437JhwKy//loI+CXxu4jwkxKbmigwSt0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C9D419C67;
	Mon, 29 Apr 2013 16:33:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6ABF19C66;
	Mon, 29 Apr 2013 16:33:13 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CC88F06-B0EA-11E2-B824-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222811>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I agree that the "confusion" paragraph after [--] [<path>] can be
> improved, but putting [--] in a paragraph of its own sounds like an
> overkill.  Apart from other things, it means that every single git
> command would need an identical [--] paragraph for consistency.

That is not a problem.  We need to say what command line argument X
(e.g. <path>, but not limited to it) does in all pages for commands
that pay attention to X anyway.

A more important reason to have them as separate entries is to avoid
giving a wrong impression that "--" is somehow related to <path>,
which is where the mistake in the synopsis "[[--] <path>...]" that
started this thread comes from.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: In tree object, Must the
Date: Mon, 09 Apr 2012 11:25:54 -0700
Message-ID: <7vobr0wyml.fsf@alter.siamese.dyndns.org>
References: <CAFT+Tg-+s5=pFNwY7ZMxem4z6YHu53kyOs0B_rkmphq=mEtpTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 09 20:26:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJHw-0003DN-TV
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757581Ab2DISZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 14:25:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757367Ab2DISZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 14:25:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BF73734E;
	Mon,  9 Apr 2012 14:25:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PzGM6rTSE6hacXP8VZVc4xRw6l0=; b=mGJdEj
	mTZpSSZjbvkMknw+nvyjS4DFaggkH48a92TBaJhaBSIzG4EjLEfFp3tjYRrCtPMQ
	E7jzbmipMhDfxA6GLRuXM35HtkKFu/NQN2xf4J8vE6c0ToKX4ILVoHnJB4ycde+r
	byeTr7w4vldqhkuhPQeED6CYjmEBl0wKsdBsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VA/CkxdIZgKaqsZmLuoIT/IXR7vDri8O
	JGaudqBoS6HH0pIroMd9ztkffD5lkF7puuFryCdVsgB+QZbr6uXTueSE9eeK/Xx+
	cRTnNT5pOPnwyGdL9qvC5lQ30Nw3i6b05s1HtxL3gChv+giKXDaCPQaOre8NvDBE
	pX6B0f1YgyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9235A734D;
	Mon,  9 Apr 2012 14:25:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53271734A; Mon,  9 Apr 2012
 14:25:57 -0400 (EDT)
In-Reply-To: <CAFT+Tg-+s5=pFNwY7ZMxem4z6YHu53kyOs0B_rkmphq=mEtpTg@mail.gmail.com> (EungJun
 Yi's message of "Sun, 8 Apr 2012 12:43:56 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7333A8DE-8271-11E1-BF37-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195022>

"Yi, EungJun" <semtlenori@gmail.com> writes:

> If it is true, what happens if it is not ordered?

"git diff-tree" and "git diff-index" (hence "git diff" frontend when it
walks the tree for comparison) will fail.

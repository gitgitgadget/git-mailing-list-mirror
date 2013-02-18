From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/15] user-manual: Update for
 receive.denyCurrentBranch=refuse
Date: Mon, 18 Feb 2013 13:26:29 -0800
Message-ID: <7vwqu59uuy.fsf@alter.siamese.dyndns.org>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <ba62167be6df7a6ba666373913bfd235bcc29c9d.1360508415.git.wking@tremily.us>
 <7vd2w7uajk.fsf@alter.siamese.dyndns.org>
 <20130210214621.GA8000@odin.tremily.us>
 <7v1ucnssnw.fsf@alter.siamese.dyndns.org>
 <7v4nhezpta.fsf@alter.siamese.dyndns.org>
 <CAM9Z-nm1WbJ0ZCVGuSuuC8kJADXUD3e-tjB51kAEerSfFxVVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 22:26:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7YEi-0002ug-FI
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 22:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab3BRV0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 16:26:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508Ab3BRV0c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 16:26:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDB7AB89E;
	Mon, 18 Feb 2013 16:26:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=btjPMJ51BNV3+Hx2s4UZ/KVMK24=; b=J90YUU
	iX9W3f01kJ5oed3f7etuEKWvffk5A3hakqy7//0Dj13Utws0XOlV4hgfYqLwJTGw
	6S/GxGAYDiN2i9ni7gpXRcOJLXEs/E4ELvGO1r7h4mfclCOWL637drfWfAXR2oT8
	Mpi3/rtIiDHU31bgTghpvKZb5nYr4m7YUgrJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pz0kiFWcWR088s98GwRbbenfziDyG5Hp
	24uHGxCds4+8THFKqz9VSivdNYIRBw3YwtNFS3E+OlKAlMYxqwGOWKuTPWsKnBwO
	11CazzMcwwGXDDWW3QXV8ZpI8ignUCxs/gR5ww6D6XkzE+WL67i1yPH8SIxXOZta
	0fojF+0yI8Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE23AB89D;
	Mon, 18 Feb 2013 16:26:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FA58B89C; Mon, 18 Feb 2013
 16:26:31 -0500 (EST)
In-Reply-To: <CAM9Z-nm1WbJ0ZCVGuSuuC8kJADXUD3e-tjB51kAEerSfFxVVLQ@mail.gmail.com> (Drew
 Northup's message of "Mon, 18 Feb 2013 08:00:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCCD98B6-7A11-11E2-B9C1-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216535>

Drew Northup <n1xim.email@gmail.com> writes:

> This looks safe to me, with the minor nit that "ofthe" ("of the")
> isn't one word.

Thanks; typo corrected.

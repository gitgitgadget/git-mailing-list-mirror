From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Autocompletion - commands no longer work as stand alone
Date: Mon, 30 Jan 2012 10:14:03 -0800
Message-ID: <7vliopcb2s.fsf@alter.siamese.dyndns.org>
References: <CAPx=Vfp_HVr5W1fFic_1k+JsKr2RAKd-RK=VkfSgo7qkb5GsAw@mail.gmail.com>
 <CAPx=Vfqj3UZuFv3Xmupy7k9arUxyZJyprm628p9QVKabdOz8cw@mail.gmail.com>
 <7vwr8mdvo8.fsf@alter.siamese.dyndns.org> <20120124232658.GD2256@goldbirke>
 <CAPx=Vfo20wWKOTeeKc=WM9dOpm85enTZHJsTnBL5uh8v0r6PRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Nathan Bullock <nathanbullock@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:14:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrvk4-0005wA-Rn
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab2A3SOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 13:14:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51943 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603Ab2A3SOG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:14:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BEE1666E;
	Mon, 30 Jan 2012 13:14:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ICViaPBrQddxTO7pWD989gPdViE=; b=Xi8Imb
	dMaKJYIfySDHKcij04IC2qFG30w2ZTxtXqRXD/dLFfeOl2OJNcQ6t3MrEcTFR+vP
	9zj962wq9EjSm1ALyxbB6+SzW2KUy0UKSI+ROJUIQmVvVHRokE3ImNq08hyZEiqH
	O/7Q+IZMp/Zv35k1FeoRVF3VoRRSg3aAvzIQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YgQe5MWh03yRoBm7xdcoSbeGIeiC73zB
	wUvz2HuLtU6lGU1Sx36wpdoviLr14ADSSozWG8idEKGNZ1xfzLxVZZGhJnsJOLrZ
	NIzjXj988Msvk1r26uRX3aa1PXKaIGRqF7DF7a7v3N/8ExZMc2ixIWmDiao7cEAC
	Rls7Dh4/OnQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5406C666D;
	Mon, 30 Jan 2012 13:14:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB13A666A; Mon, 30 Jan 2012
 13:14:05 -0500 (EST)
In-Reply-To: <CAPx=Vfo20wWKOTeeKc=WM9dOpm85enTZHJsTnBL5uh8v0r6PRQ@mail.gmail.com> (Nathan
 Bullock's message of "Mon, 30 Jan 2012 07:00:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 323BBA36-4B6E-11E1-BF9A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189386>

Nathan Bullock <nathanbullock@gmail.com> writes:

> ... There was a question if those could be included
> in the main git code base. Do you know if that is likely to happen?

It entirely is up to the author of the patch.

"I have this random code on Github so people can just copy and paste it in
their .bashrc" may be a good starting point to give hint to people who are
interested to come up with a good patch with a use example on a handful of
comment lines and a readable commit log message.

I didn't see it happen in that thread, so perhaps nobody was interested
back then.

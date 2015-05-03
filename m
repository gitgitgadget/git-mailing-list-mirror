From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fixing translation errors in gits error messages
Date: Sun, 03 May 2015 10:58:44 -0700
Message-ID: <xmqqh9rtv8yz.fsf@gitster.dls.corp.google.com>
References: <CAKB+oNsa5c3zwx03pm7P_FDO3Xdxgr+rBOncAAmAjQL4LLJOdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 19:58:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoyAF-0007e9-PX
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 19:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbbECR6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 13:58:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751140AbbECR6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 13:58:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 407174C2D9;
	Sun,  3 May 2015 13:58:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xBnjeYu4sAM+79sPv/QsgHR7wtc=; b=bPluE/
	q28k3XhDMVogUDvEhipQIJLXU3TNXWm7fSH3qCEpjDDkweQjpfLjc0Qm+D/x0qFP
	uwq7tm5NQlQbqYYfWnwG936hAsXXecCfhyHh1M1pO1/XfVF4vb8DoZyyuu/Efqt7
	gpfDnbUEi7cRSrolcZdS9Mkh4TLK0eoxYd6/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YEHW346sXyW8y76dzRbjo17MSWNl8akv
	rPKX4+pW9mGTd/xUyiUUt/Cnxh81yBlFMx4uPcFG6aIyY4lsOxz+Gr4m5umuQRqc
	q5BxTShtrYaOVj1GpXsRmdPfljGcGhzoHiavuYmmfZaW/tacMiBSbRB5pkxp1Gyz
	Sch9vxORZIM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3943C4C2D8;
	Sun,  3 May 2015 13:58:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACB9F4C2D7;
	Sun,  3 May 2015 13:58:45 -0400 (EDT)
In-Reply-To: <CAKB+oNsa5c3zwx03pm7P_FDO3Xdxgr+rBOncAAmAjQL4LLJOdg@mail.gmail.com>
	(Alangi Derick's message of "Sun, 3 May 2015 17:39:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0AEB259E-F1BE-11E4-96E0-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268281>

Alangi Derick <alangiderick@gmail.com> writes:

> I ran the command:
>  git grep --cached -F -e 'error("' > fix_translation.txt
> so that i can track all the files with the errors and fix them file
> after file manually.

That is a good first step to find candidates, but you have to be
careful to sift that output into ones that needs marking and others.
Some strings are for plumbing output that must never be translated.

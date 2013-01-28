From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/11] unify appending of sob
Date: Sun, 27 Jan 2013 21:49:16 -0800
Message-ID: <7v7gmxzwkj.fsf@alter.siamese.dyndns.org>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <20130128034831.GQ8206@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 06:49:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzhbA-0006KO-Qh
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 06:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab3A1FtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 00:49:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab3A1FtS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 00:49:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E66571BD;
	Mon, 28 Jan 2013 00:49:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=waLucC1olgYfEjqysaxXGPXJ24U=; b=MLvZ7u
	RDOXQB6lRzBX3ki+JwWqyXVOtrrHk6+RYucBiuQYEulH5EWnFfSLBlW6lgvs8EsN
	YnVsLclZhsOw6kY7e7pS+b0iATay4QfbY0brxUsy8GYanPpBkcQJL+9V8NPIs4ze
	9ySbP+HEX4eMyZ/61Dv8ZElTKePMxBB2I5FeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mzf6pBeDd/Q8GFKPzvZH3NtiMOUOqPiO
	3o+83vk/ZnMiCkgBAMLiGRCQnlgNUHKiksROZRO2g2vpr/NKKAKqtAFA+5LE954l
	nosmZEmkBC13UoTTgnwVoGQ51LfuId4UjmObrUjMztRjl+AyKUZXMK+nYdPM2hgF
	ZaVK2UeoUEs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F32B71BC;
	Mon, 28 Jan 2013 00:49:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C748871B9; Mon, 28 Jan 2013
 00:49:17 -0500 (EST)
In-Reply-To: <20130128034831.GQ8206@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 27 Jan 2013 19:48:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 746C2530-690E-11E2-950C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214806>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Brandon Casey wrote:
>
>> Round 3.
>
> Thanks for a pleasant read.  My only remaining observations are
> cosmetic, except for a portability question in Duy's test script, a
> small behavior change when the commit message ends with an
> RFC2822-style header with no trailing newline and the possibility of
> tightening the pattern in sequencer.c to match the strictness of
> format-patch (which could easily wait for a later patch).
>
> Jonathan

Thanks for a quick review.  I agree that this series is getting very
close with your help.

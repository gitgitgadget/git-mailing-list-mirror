From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/6] send-pack.c: add --atomic command line argument
Date: Wed, 17 Dec 2014 15:14:17 -0800
Message-ID: <xmqqegrx98dy.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418841177-12152-1-git-send-email-sbeller@google.com>
	<1418841177-12152-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	sunshine@sunshineco.com, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 00:14:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1NnV-0002Er-Nq
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 00:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbaLQXOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 18:14:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750959AbaLQXOU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 18:14:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C073A286AF;
	Wed, 17 Dec 2014 18:14:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NJy3ChzOYcbS3S3s6ImBVO8RR6w=; b=mjmGPw
	IhcqqSwSO6N9F0PB4xq/PV0Rv2wAd06+m39om6Y/KPa8Wd/yChJlXVESu3Iy3cJw
	Oh3Fx8Qi67FTk11GHoFVPXEWPovbcOxLECNO7rs/GuWor4y+QUZ8ZZHAACX4i7Uy
	lCKV8Q5pT9wiVAY+3ayOedwHsGNwf32h/Fvk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FqW2GsJxk8UErssQ9Ysld9MIEwNusqPR
	8lBc07SI6Ul28ikp8dKK/cbuHMs0JIWyZaQVYI9aCwdLzdrrRt428zLpQ2Xx/MHK
	07m2CQTAEEvwYgJTCjBLTPEu041Ykx5s5rK3XZGUWpuGwMdONTIxwRLDWovo+7zn
	AWyvNkcDUyw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6424286AE;
	Wed, 17 Dec 2014 18:14:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CE87286AD;
	Wed, 17 Dec 2014 18:14:20 -0500 (EST)
In-Reply-To: <1418841177-12152-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 17 Dec 2014 10:32:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E3AF24C-8642-11E4-B848-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261504>

Stefan Beller <sbeller@google.com> writes:

> From: Ronnie Sahlberg <sahlberg@google.com>
>
> This adds support to send-pack to negotiate and use atomic pushes
> iff the server supports it. Atomic pushes are activated by a new command
> line flag --atomic.

Looks sensible.  Thanks.

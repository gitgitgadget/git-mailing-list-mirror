From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SubmittingPatches: fix an inconsistency
Date: Thu, 13 Nov 2014 10:28:54 -0800
Message-ID: <xmqqtx230xax.fsf@gitster.dls.corp.google.com>
References: <5463DA20.3080703@inventati.org> <5463FB4C.2060203@inventati.org>
	<xmqqy4rf0xod.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: slavomir vlcek <svlc@inventati.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 19:29:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xoz8h-0007ly-Ct
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 19:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933146AbaKMS27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 13:28:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932648AbaKMS26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 13:28:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E8111C2CB;
	Thu, 13 Nov 2014 13:28:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IX2PGvuky3gu8kKveMfLhBO4jhA=; b=V4AwYq
	XMfggmsp0Sr7NnASVFmdQQu4Kt0DtwPce4HsrxwuP4XIZdEQkd/A5lCjq+gU+VaN
	O25cdLOXFW8uukT3804cGp+51g0jsfDx+Rw1wNnnBhBtz2g1Nll28vpCoUVuayDr
	Fo78mvtudGdyK+TqddUHCFS15N/KbtoNyYYnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WhaAHaMd8zrRB3maNIMjkVJImGUqoisV
	wgJGIs31fYtDCS3LWr/8zYgUzlWhDNv5PlFRGfrxbeYXamoKlBkJyFvwkVpDJ45g
	w0HZpDnEXv0GI2Irvs5Cn0ktSctCHYJpMiAflCrj4G/ATRMvTHqk+GnCqwpSSfiN
	M3dTD+kCne0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2430E1C2CA;
	Thu, 13 Nov 2014 13:28:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92F9E1C2C8;
	Thu, 13 Nov 2014 13:28:55 -0500 (EST)
In-Reply-To: <xmqqy4rf0xod.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 13 Nov 2014 10:20:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED0EFB4A-6B62-11E4-926E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Signed-off-by: slavomir vlcek <svlc@inventati.org>

> The same comment applies to the log message part.

I said:

> Will queue; no need to resend.
>
> Thanks.

But one thing to make sure.  Do you really mean to have your
sign-off with all lowercase?  I can amend the patch to read

    Signed-off-by: Slavomir Vlcek <svlc@inventati.org>

while applying, so that your name does not stand out like a sore
thumb in "git shortlog -20 -s" output, if you want.

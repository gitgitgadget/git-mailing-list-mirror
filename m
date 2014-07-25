From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] commit: advertise config --global --edit on guessed identity
Date: Fri, 25 Jul 2014 12:38:58 -0700
Message-ID: <xmqqoawd5iul.fsf@gitster.dls.corp.google.com>
References: <xmqq1tt96yyh.fsf@gitster.dls.corp.google.com>
	<1406315496-10237-1-git-send-email-Matthieu.Moy@imag.fr>
	<1406315496-10237-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:39:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAlKj-0002fo-ED
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 21:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760890AbaGYTjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 15:39:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56884 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520AbaGYTjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 15:39:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CA242AAE3;
	Fri, 25 Jul 2014 15:39:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yjzGiXgwWAAk7BbBU1uLJmRv1yU=; b=WaSgHu
	Ve5m3qe5GmDscwyuvDy5ypD7ZiTwOOnZprhZhF46V4eR3X2bO7JfRoZ9/Xwvhdxl
	5eXuKlBUG9lkblCmTBwokxA9UdpH75SD4Tnwbot0o9BujCCSKNJdp2EYlUq+NCp2
	TQItiAMmyHVFWl0PlXpHkFEft+7YrO31577IM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C9SJpxBAWHHVZs+LeoDwXPoM/4/ZBGbX
	uEjtN3MNsqeIL+HSr1iKcPAVgdfWw0B0StEFDLfdm7qIW6tRkyM+INX/TJBbXrve
	D/g3/Gt/KeOFaq/e3QmR0eEod4VWeGuY6bqCvmLRYQZQVOcMPofg3fiBPySvuko0
	80Iasi/fKis=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 318992AAE2;
	Fri, 25 Jul 2014 15:39:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F263F2AADC;
	Fri, 25 Jul 2014 15:38:59 -0400 (EDT)
In-Reply-To: <1406315496-10237-3-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Fri, 25 Jul 2014 21:11:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 53383F4E-1433-11E4-A213-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254264>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +static const char *implicit_ident_advice() {

Style:

static const char *implicit_ident_advice(void)
{

No need to resend.

Thanks.

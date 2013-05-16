From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Wed, 15 May 2013 23:14:01 -0700
Message-ID: <7vehd78n9y.fsf@alter.siamese.dyndns.org>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
	<7vip2j8ozu.fsf@alter.siamese.dyndns.org>
	<CAMP44s2sKWCswB+wT6OiyrA5_oVqUkDptrkdZCjWCucUL3KrKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 08:14:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcrSF-0000LR-4z
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 08:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373Ab3EPGOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 02:14:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144Ab3EPGOO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 02:14:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 325C11CF66;
	Thu, 16 May 2013 06:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C46vK+f4Gk1Gs8Y4ehAvi54EgWI=; b=L9M3+e
	KblXAFBBlo6CX7uhanC/hKYaQGFf77WO77UNInirqUGankrQdwGx+nWhIwV7Ukr9
	w3OICCP4ktFbQ73QvGjY/20Fw4dIgAEYJrY90MlkZc3WK5IuYLJ9H6NTh9MJfRve
	BhTLISAkeEMuXGxHhSXhZY7ZBwjjjGYIXaYRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IT6tSxf3t6L5xNsHahu2/IYgAuejkFIx
	f3yaMWFlNGA6aYQRgRDBUw09q38oztKCgRGPnp0B4g6UJyzWCyHniTz97sHaLpf3
	1Jt/usDkjLGmPBygCr+ueJKJHapA4u5vhOUkgfu/A0p9y7JXLd5iMfD52U7fHPUM
	Bj/S4mKt5Ig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 299AB1CF64;
	Thu, 16 May 2013 06:14:13 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7F821CF56;
	Thu, 16 May 2013 06:14:02 +0000 (UTC)
In-Reply-To: <CAMP44s2sKWCswB+wT6OiyrA5_oVqUkDptrkdZCjWCucUL3KrKA@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 01:00:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE34B0E2-BDEF-11E2-81FF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224483>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> ...for me
> it's more important that 'git fetch' works sanely (patch #1), and I
> don't like the proposed patch, but I can't think of anything better.

I do not like that either, but I haven't formed a firm opinion on it
yet.

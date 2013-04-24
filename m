From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Wed, 24 Apr 2013 11:25:41 -0700
Message-ID: <7vmwsndbve.fsf@alter.siamese.dyndns.org>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
	<1366821216-20868-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:25:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4OC-0000TX-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757120Ab3DXSZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:25:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757100Ab3DXSZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:25:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8781719086;
	Wed, 24 Apr 2013 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=netEcEaHqxWyxs6ihx4DwnNC1Bc=; b=Gh1kkL
	j/siBKf+I0jJ53sGcZT24zpdZ89+GW8zFWQJ1fBRg59siQE8rUMSKsxbZ29qWNHs
	HkLYW9QHrZRr1JK77EnqqJGeJvBScSpra0s9NjM0i79cNwR3SjAINz16TXvWL40K
	pr18lAEouionvq6eNfkdK9YigITtUeh0r+VPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LrfqXitSiGBLUfW0Yu21PzjJo4EMs64n
	NpaKy7qIAXMALddAU1IicOBiPZP8778j7VhIP/77lyanrSMkYJvz4QEk0A8EnOeS
	+KGBLQ20UFC0wRL81D2p9aUCr4s2nqUww1DjLMHhW1QI1x2YhjToYg+x042ccubu
	QGl2qBFHges=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C68C19085;
	Wed, 24 Apr 2013 18:25:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F39E319083;
	Wed, 24 Apr 2013 18:25:42 +0000 (UTC)
In-Reply-To: <1366821216-20868-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 24 Apr 2013 22:03:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FA062DC-AD0C-11E2-9C91-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222287>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The SYNOPSIS lists the [--no-index] form as the last item, but the
> DESCRIPTION lists it as a natural extension of the first form.

Perhaps either the description or your reading is wrong.

The "--no-index" mode was a hack to allow "git diff" goodies to be
used outside the context of "git", and a proper execution of it
should have been to send patches to GNU or BSD diff maintainers, not
to add the "--no-index" option that is unrelated to "git" to our
code.

I think it is more correct to list it as a footnote and list
separately from the main text, which is what the original SYNOPSIS
section does.

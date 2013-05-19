From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sun, 19 May 2013 00:42:11 -0700
Message-ID: <7vli7bza98.fsf@alter.siamese.dyndns.org>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
	<1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0QYrzVBsmba1PYMG0yo0CpvTnVm=QHfYif6iu_Zo=tNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 09:42:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdyG2-0004Wq-AN
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 09:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940Ab3ESHmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 03:42:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab3ESHmN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 03:42:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28E231B93C;
	Sun, 19 May 2013 07:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TvsqN6jiPG4cnFXe1d8CjCPVhas=; b=xv2AVe
	m9zmMaJW/609e3lz3Elpe/9W4Fgb1tKYjKBEZuhJPDxsUPwFgr1Ojg+GK2yPiKsO
	ah/YHHjr0opIX+1bVHKyv6fmX7Egf2IUc03xDZ9XEWMEds08ToufoYUu9H6+Y5tG
	gLn0eF/E56nhU/DHIl+fQJ8wxB6znYWrKHoUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cxex2dBcaVKmbXIgnHBLseLjzKSb3vFj
	Iw29qJWQQ5DNe96ShLq6H+WqDZ1ZjXV5AzPjgpseufzF2135dSs9OxeH+deAXgpj
	OldDK0KcAr7TLfMeCMvb/Y9VJRtRl0D5QpHlWI9iLSwc8pFrCSep+mfoGDQT0+3d
	Bas3B2usgTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C9971B938;
	Sun, 19 May 2013 07:42:13 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9899E1B935;
	Sun, 19 May 2013 07:42:12 +0000 (UTC)
In-Reply-To: <CAMP44s0QYrzVBsmba1PYMG0yo0CpvTnVm=QHfYif6iu_Zo=tNA@mail.gmail.com>
	(Felipe Contreras's message of "Sat, 18 May 2013 06:55:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E60C10C-C057-11E2-9D21-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224824>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sat, May 18, 2013 at 6:46 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>>  contrib/related/git-related | 124 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 124 insertions(+)
>>  create mode 100755 contrib/related/git-related
>
> I tried everything and I don't think it's physically possible to make
> this script any simpler without severely crippling it's main goal.

Hmm, I haven't read these patches yet (I just came back a few hours
ago to a state in which I am well enough to read and write e-mails),
but did anybody complain that it is too complex?

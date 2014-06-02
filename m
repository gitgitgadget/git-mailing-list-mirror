From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch doc: Move FETCH_HEAD material, and add an example.
Date: Mon, 02 Jun 2014 11:24:31 -0700
Message-ID: <xmqqbnub5fvk.fsf@gitster.dls.corp.google.com>
References: <xmqqioon9msf.fsf@gitster.dls.corp.google.com>
	<1401722507-15075-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 20:25:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrWut-0002Rj-6D
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 20:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbaFBSY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 14:24:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65236 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbaFBSYs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 14:24:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 854EA1DDDB;
	Mon,  2 Jun 2014 14:24:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DUCHzgeOsZmwbuyx/e8Jb1OQfc0=; b=d1nKp2
	n1GR1YH5jUq2zb4o0F6kphIBi9sEA5SGJ7wuc7hVtEq9aWmDIOzgJ97cHziA6Nj+
	mfIioMH1Rhwdxj4wukJ8As0o/GxWgmL84Y8D2r0w9rCf/MIWKbmhSnHWeLTLhE98
	Li2CglbDEwofWo1P7oP8xeRPCceDFHPcEMb7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GBMJjDwyoabc4UiIggAMUdngU8NSDCAs
	TAS4xCGzOrmjkr/H/VzKAbTavAf/sw4dNGUYqIaCoGLxma3+qD16h7pcqB37FHN9
	jMVJr8de3oKX1e16mppBLl+rA0p59+zRADy2fbDkHu+qWz+tG8/Ia+iaTa71V1jQ
	gc4teX3UIG8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7349A1DDDA;
	Mon,  2 Jun 2014 14:24:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D266D1DDD5;
	Mon,  2 Jun 2014 14:24:43 -0400 (EDT)
In-Reply-To: <1401722507-15075-1-git-send-email-marcnarc@xiplink.com> (Marc
	Branchaud's message of "Mon, 2 Jun 2014 11:21:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B43BDBC-EA83-11E3-8ABE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250579>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>  Documentation/git-fetch.txt | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>
> This patch applies on top of your 1/5.  It:
>
> * De-emphasizes the FETCH_HEAD stuff by moving it to the end of the
>   DESCRIPTION section,

This reads much better.  Thanks.

>
> * States that remote-tracking branches are simply "updated", and hints
>   that playing with <refspec> can control this.
>
> * Includes the "their histories" rephrasing.
>
> * Adds your peek-at-a-remote-branch example.

> If you like this, feel free to sqush it into your 1/5.

Will splice in as patch 1.5 instead ;-)

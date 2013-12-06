From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] difftool: Change prompt to display the number of files in the diff queue
Date: Fri, 06 Dec 2013 14:00:03 -0800
Message-ID: <xmqqsiu51vz0.fsf@gitster.dls.corp.google.com>
References: <1386286726-26653-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 23:00:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp3Rg-0002Kv-F5
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 23:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759094Ab3LFWAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 17:00:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758611Ab3LFWAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 17:00:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA8DD5931A;
	Fri,  6 Dec 2013 17:00:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YqZDT4cwUPMLyl+Ci4hz8RBjMeY=; b=CBnSuv
	mzv4bGj7T9wEDNGfFRSfXxb3jdn4zfbbxpjspkA3TftccXyPOmNCvdbOtpEzWCt4
	0tL3c2Jrja19PxO8ltjfBqhPloold4Ma3ZueHalRObegZvtMvasGaVvs5u2+VENY
	N/wyYAY9vjzIGq/zxR3xVX4ByZ5lgItvcjGpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=udu7YiluWs8vqW+7IxPcpfKN37gIaYUV
	wGbQUUDZIUfkHDULVy+6xVsGrBmu+w4RN507SZwx89GQnJG0gnrD5XXkVgz4K/ge
	eaP1zpLIZCauXYmxtZVCm6ZBhqWZTRxPiNIFwEPrdcu8G+rK3uCnAjXlsmSnKuNf
	bzD7gNRcFzc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1BEB59315;
	Fri,  6 Dec 2013 17:00:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22FA359311;
	Fri,  6 Dec 2013 17:00:11 -0500 (EST)
In-Reply-To: <1386286726-26653-1-git-send-email-zoltan.klinger@gmail.com>
	(Zoltan Klinger's message of "Fri, 6 Dec 2013 10:38:46 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C71AA6CC-5EC1-11E3-9BEC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238954>

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> Reworked patch to use run_command_v_opt_cd_env() function when invoking
> the external diff program. Modified test script to use write_script
> helper function.

Thanks; will queue with a minor tweak.

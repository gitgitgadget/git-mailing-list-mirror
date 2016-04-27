From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/29] read_raw_ref(): improve docstring
Date: Wed, 27 Apr 2016 11:31:44 -0700
Message-ID: <xmqqa8keaoof.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<5b73d10ec47a68535725d77ebbc5c4f0512ac5f3.1461768689.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:32:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avUFo-0000kQ-Uo
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 20:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbcD0Sbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 14:31:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752626AbcD0Sbs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 14:31:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D849B16837;
	Wed, 27 Apr 2016 14:31:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8LVCxDfohNjN9SKCETacLah8pug=; b=Jc7Cie
	J1Bv1N6xCvJDUEejhYRTVIWRkTEt5sPY+1Tej2K97lp/vmJtwHor7x47Hq1QX0vm
	tLJjf1L0CStBDbOdliQQ9A3YwTDoBdxgcpa6VHc6pohYBmopr1B8WjI+8Pf4+Dl4
	ahiD/5egAoC5hucG+uu+0CqW1ZzmKEuNoByno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iUiPW4te9rqM0CeMSwSrkYRSwQmirSUR
	1BZCzL16FirpkWSoT4PTesoi7GWAMrA0flXW0ABEGPFKjRn/6sRtw3jmt5InEqfo
	sW46z4Ax9saN8xtC+fO0UmTZlmgKUDflVR6iiG16l95xPNmxUrDcUTMBJd6WvsMK
	Gw7ntfRIaRI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFF8116836;
	Wed, 27 Apr 2016 14:31:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1CE4816835;
	Wed, 27 Apr 2016 14:31:46 -0400 (EDT)
In-Reply-To: <5b73d10ec47a68535725d77ebbc5c4f0512ac5f3.1461768689.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Wed, 27 Apr 2016 18:57:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C157944-0CA6-11E6-93C5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292784>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>   * Backend-specific flags might be set in type as well, regardless of
>   * outcome.
>   *
> - * sb_path is workspace: the caller should allocate and free it.

All made sense.

A welcome bonus is the removal of this stale comment that 42a38cf7
(read_raw_ref(): manage own scratch space, 2016-04-07) forgot to
remove.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use "working tree" instead of "working directory" for git status
Date: Thu, 09 Jun 2016 12:59:24 -0700
Message-ID: <xmqqporqgmlf.fsf@gitster.mtv.corp.google.com>
References: <1465496370-11664-1-git-send-email-Lars.Vogel@vogella.com>
	<vpqporqb0x0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Vogel <lars.vogel@gmail.com>, git@vger.kernel.org,
	Lars Vogel <Lars.Vogel@vogella.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 21:59:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB673-0007Fv-9d
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 21:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbcFIT73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 15:59:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750751AbcFIT72 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 15:59:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EBB0921FB0;
	Thu,  9 Jun 2016 15:59:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+RyUMtNxZW2nuXwrIdc+HFgHknw=; b=GFcDcg
	ITpEo5cEZf39jUEqZ736A/42sTt9mY3wfcc1WnlU3pxgyASX9M5/dVAgEr+MJ+FA
	q4FVTQv6o8Eh29EK4+0IsfhZYmik9b7cOumIx7Hc3MBdfT9qcxE25w1j5rDKIIjE
	qOimjItRRMw2Fj8WeK3yvY3cL6g1IsoDh2SLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ly9Dloz8P0oXlc/pfHKT8K3w6yKK6Qiy
	hZ8LiGE16ojyo+CqTpX1ZvcK2oqMPFY68Zh4g9I/xdhgtbItT0GVVwzzyXGrIDl3
	hLBIQ5we5+6anT6BysNKrS17gonAm6gjb37Ug5yawsuqG5KBunhalhcMGSNJKi93
	xuX+AylBTng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E340221FAF;
	Thu,  9 Jun 2016 15:59:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 660EC21FAE;
	Thu,  9 Jun 2016 15:59:26 -0400 (EDT)
In-Reply-To: <vpqporqb0x0.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	09 Jun 2016 21:46:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AB30FB4A-2E7C-11E6-878A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296923>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Lars Vogel <lars.vogel@gmail.com> writes:
>
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -1554,7 +1554,7 @@ void wt_status_print(struct wt_status *s)
>>  			else
>>  				printf(_("nothing to commit\n"));
>>  		} else
>> -			printf(_("nothing to commit, working directory clean\n"));
>> +			printf(_("nothing to commit, working tree clean\n"));
>
> Looks good to me, thanks.

Thanks, all.  Queued.

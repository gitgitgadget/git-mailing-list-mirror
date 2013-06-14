From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] stash doc: add a warning about using create
Date: Fri, 14 Jun 2013 08:11:17 -0700
Message-ID: <7vd2roralm.fsf@alter.siamese.dyndns.org>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
	<1371205924-8982-2-git-send-email-artagnon@gmail.com>
	<CABURp0rF2ESFmvf=UQcbKr6ybc0wmGY-_=Nc3yMQJ2jhZGUQJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 17:11:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVev-00085R-Pk
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880Ab3FNPLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 11:11:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab3FNPLU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:11:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FBBF25633;
	Fri, 14 Jun 2013 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fNGZ6P82og4rg2U4aP8mbRVekWU=; b=ST7JuM
	PtEZCuNBnHoTr2ZE6Z/mFNwzzj5FQEyPAlQyJPTSeo2CNAcNG6n14/9bxTrROKki
	9FUX2z5n4Dgbi3G4ptj5ObwxpUdSTta9pp9wyGzWXLrR8mfSGAhwV4IrkGwnLNT9
	Brck2bVWR2xdiZnVJFoZAY96F1ie7zcL4gyQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RFX8EcSCxq0qIuiNq+AjXVnGd/0c7YrU
	a3OkE84JVteJqcMPfqTHeWw7LmqeUk2R5ANk9JAzs93ScdMND2Id9MAVYGgrcgzs
	TvPRkbmj/xub86lYduWogNG5bcsEUHvwzY5UYOyT6TYKAX+i6cYl59LqZDdC59w3
	sutaBz5MwfI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6649A25632;
	Fri, 14 Jun 2013 15:11:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3A3525630;
	Fri, 14 Jun 2013 15:11:18 +0000 (UTC)
In-Reply-To: <CABURp0rF2ESFmvf=UQcbKr6ybc0wmGY-_=Nc3yMQJ2jhZGUQJQ@mail.gmail.com>
	(Phil Hord's message of "Fri, 14 Jun 2013 08:27:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA5E082C-D504-11E2-8FB4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227881>

Phil Hord <phil.hord@gmail.com> writes:

>>  DESCRIPTION
>>  -----------
>> @@ -151,6 +151,7 @@ create::
>>
>>         Create a stash (which is a regular commit object) and return its
>>         object name, without storing it anywhere in the ref namespace.
>> +       This is probably not what you want to use; see "save" above.
>
> Thanks, this is helpful.
>
> Maybe you can also hint why this command exists.
>
>   +       This is intended to be useful for scripts.  It is probably not the
>   +       command you want to use; see "save" above.

Yeah, I agree that is much better than my original suggestion that
resulted in the addition in this patch.

Thanks.

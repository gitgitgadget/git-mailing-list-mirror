From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Factorize shortening of notes refname for display.
Date: Sun, 19 Jun 2011 15:51:34 -0700
Message-ID: <7vliwxe8p5.fsf@alter.siamese.dyndns.org>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
 <1308431208-13353-3-git-send-email-ydirson@free.fr>
 <201106192325.00667.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@free.fr>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 00:51:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYQqE-0006JW-02
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 00:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab1FSWvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 18:51:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab1FSWvh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 18:51:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 449A26882;
	Sun, 19 Jun 2011 18:53:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KqDDp754yr1xTf2a6dr0AUdDfF0=; b=ydoEBb
	HCux5YorsvOJhyIsWdDLGjiHcdnVG+PMUIU5RKRH6bPGwuT9QNHjUMlnNtXD1eo/
	wl92BEEv0jMnjqPMgcuU90lBLHwsbt6zMtsxuuXr3878RQNoMEm88GCYNl2jZpet
	xKFQHkvRSuPeU/7oBTzcujgX0NXis8RD3Qf/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t+akf49hRjM/jpjLZHRAiRXNtuAxswSo
	mftKlSLoTSd55Mkn45L8hWaaSvBa9pmaOXVGs6Bu13r7d78rtecCUHkmw77LKI00
	VXbxYtS1uBVK/iLE7EYmcDa6GfQmSe4KqtdBAh2FV0m1pp8Jl8x8PDI7906hbnoN
	K8qY8s3NTeY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D4346881;
	Sun, 19 Jun 2011 18:53:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8A9FA6880; Sun, 19 Jun 2011
 18:53:46 -0400 (EDT)
In-Reply-To: <201106192325.00667.johan@herland.net> (Johan Herland's message
 of "Sun, 19 Jun 2011 23:25:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD58C370-9AC6-11E0-A975-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176038>

Johan Herland <johan@herland.net> writes:

> On Saturday 18 June 2011, Yann Dirson wrote:
>> Signed-off-by: Yann Dirson <ydirson@free.fr>
>> ---
>>  notes.c |   24 ++++++++++++++++--------
>>  notes.h |    7 +++++++
>>  2 files changed, 23 insertions(+), 8 deletions(-)
>> 
>> [...]
>> 
>>  /*
>> + * Return a short name for a notes ref, suitable for display to the user.
>> + *
>> + * No copy is done, the return value is a pointer into the original string.
>> + */
>> +const char *notes_ref_shortname(const char *ref);
>> +
>> +/*
>
> Please include in the documentation what a NULL return means.
>
> Otherwise the patch looks OK.

It may be just me, but every time somebody says Factorize, I find myself
looking for math textbook from middle school days, 12 = 2 * 2 * 3, etc.

Could we say Refactor instead pretty please?

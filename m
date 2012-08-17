From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Fri, 17 Aug 2012 00:32:42 -0700
Message-ID: <7v7gsyvuqt.fsf@alter.siamese.dyndns.org>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org> <502D5D97.3020906@kdbg.org>
 <7v4no21raw.fsf@alter.siamese.dyndns.org>
 <7vzk5uzgqa.fsf@alter.siamese.dyndns.org> <20120817053826.GB22313@suse.cz>
 <7vk3wyvy67.fsf@alter.siamese.dyndns.org> <20120817070406.GD22313@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 17 09:32:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2H35-00027C-Pd
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 09:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221Ab2HQHcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 03:32:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56613 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964832Ab2HQHcp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 03:32:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 961AC4BB6;
	Fri, 17 Aug 2012 03:32:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CaMdTlQJPdsccq3aupLpcw5DZbo=; b=lajP7w
	Xu/PiLlYAYdMy3y06N4l3e++Nnm9aK4Ot902Bs3eTQtwQ4T5tOcFltYvYRvH2CKL
	+q/YYtAvLUszqKhpKq0YMoofHUEJKMU8ZgU8X43Kw45KshSDYkZA0aXSO/XZ93YV
	AqC/tWqB4K5YV/AjBPr/9EkQQOc6kLdIqgDrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HT+Ni3iDFOwidij0QaY0ZF/atheixJ9c
	jWx/G4cux9zDj9Kp/cKNG4pjnsfWVN98ahJyOKREPtWJRQZW1oP4PC+HdhfW85D0
	8BFMiIaPUIn14XuQF5IEEdrwNFPLpC05pDm44TsLneQg8kRTC2JH/gQnqpR9nJFZ
	sma87KU5OTw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84AB34BB5;
	Fri, 17 Aug 2012 03:32:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 002284BB3; Fri, 17 Aug 2012
 03:32:43 -0400 (EDT)
In-Reply-To: <20120817070406.GD22313@suse.cz> (Miklos Vajna's message of
 "Fri, 17 Aug 2012 09:04:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBD9BA06-E83D-11E1-B8D4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miklos Vajna <vmiklos@suse.cz> writes:

> On Thu, Aug 16, 2012 at 11:18:40PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> From: Miklos Vajna <vmiklos@suse.cz>
>> Date: Thu, 16 Aug 2012 11:50:18 +0200
>> Subject: [PATCH] man: git pull -r is a short for --rebase
>> 
>> Letting the "--rebase" option squat on the short-and-sweet single
>> letter option "-r" was an unintended accident and was not even
>> documented, but the short option seems to be already used in the
>> wild. Let's document it so that other options that begin with "r"
>> would not be tempted to steal it.
>
> Signed-off-by: Miklos Vajna <vmiklos@suse.cz>

Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] documentation fix: git log -p does not imply -c.
Date: Sun, 06 Mar 2011 16:36:28 -0800
Message-ID: <7vbp1n4vhv.fsf@alter.siamese.dyndns.org>
References: <4D724A0F.7050904@gmail.com>
 <1299355004-3532-2-git-send-email-haircut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 01:36:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwORV-0006NL-Fu
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 01:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab1CGAgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 19:36:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab1CGAgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 19:36:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B2074C42;
	Sun,  6 Mar 2011 19:38:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=Wn4mWACNzrPEtlNfIlvcm1fnR3I=; b=dbTya1
	ko4jAMiaVxp4rkKztO4f4J4jHZ8FOa05NIkiKEV+KPHIO4eJFkensXG+cv574S/3
	0FOjNtEIIzQQmwZxupXuNybf0n+DllyCpbpx2SZrQPr8yS2v18VKDkUJ/xkRWdMe
	G6XTCfnM+5iT9gUL4I7KYaqYDiasSwS4L1RF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AOYNI2KHClxWqWSP+KXmmyeUCnJm2jxw
	90t6zO9s0k9YhRwrxWm11zAm964WdbqmEOvW2EGPdGaxuiSnoXQ3i9pMJ/04osd+
	+jEFUyOPocWspSEeKe/izzqbc5MPWf4/DQTXpy6x4OqgcdUGEJ/Mya22V1k5rZ1Y
	khI0I+SHpk0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C0EDF4C41;
	Sun,  6 Mar 2011 19:37:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B32254C3C; Sun,  6 Mar 2011
 19:37:55 -0500 (EST)
In-Reply-To: <1299355004-3532-2-git-send-email-haircut@gmail.com> (Adam
 Monsen's message of "Sat\,  5 Mar 2011 11\:56\:43 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 27277D66-4853-11E0-A15A-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168561>

Adam Monsen <haircut@gmail.com> writes:

> Relates to the thread with subject "frustrated forensics: hard to find
> diff that undid a fix" on the git mailing list.
>
> 	http://thread.gmane.org/gmane.comp.version-control.git/168481
>
> I don't wish for anyone to repeat my bungled forensics episode.

But this patch is wrong, isn't it?

The --cc format _is_ the default, not -c format.

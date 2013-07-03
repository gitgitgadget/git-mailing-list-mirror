From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/5] Reroll patches against Git v1.8.3.2
Date: Wed, 03 Jul 2013 13:06:54 -0700
Message-ID: <7vip0re7c1.fsf@alter.siamese.dyndns.org>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com>
	<cover.1372719264.git.Alex.Crezoff@gmail.com>
	<7vbo6klpgw.fsf@alter.siamese.dyndns.org>
	<20130703200304.GA32573@dell-note>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 22:07:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTKP-0003Ix-UD
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933041Ab3GCUG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:06:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932690Ab3GCUG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:06:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 004282D602;
	Wed,  3 Jul 2013 20:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eGAxogy1/TTKIej2nbMsqarhvi8=; b=UBGiAk
	GVODSycRqzUfI8Z6a/k8Wc+XZ4xDBxr/Kb0puW5KxI2XbAOPcI/YXZWPbZCU/wj9
	SKJIckk1CyQfGfJFvQlvHf7nWqSPs/b/XRE/5Xyng/OoA5XteqPxDfyA5Sl9j09M
	q53sAiNs8ImajWgqFx3D4GRnGqKsvANnHyrIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l8rtOJD4fGtZL8Wfc3iGhP6d8OjKp42s
	f0268igxVIjrbDF6w998kQGRH/V+HrJOrfmeGixAW6TRCgsl7HnJ1Rn7Fp+S57fW
	+WGoyDlvAc0g4aKi+1OH+QKEONMF0cY+NVmkt46YMjauYr0o+tuYZPzlc1GVW4//
	HRH6L/L6Whw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E61122D601;
	Wed,  3 Jul 2013 20:06:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34B362D600;
	Wed,  3 Jul 2013 20:06:56 +0000 (UTC)
In-Reply-To: <20130703200304.GA32573@dell-note> (Alexey Shumkin's message of
	"Thu, 4 Jul 2013 00:03:04 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C838208-E41C-11E2-A8E1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229520>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> On Tue, Jul 02, 2013 at 12:41:03PM -0700, Junio C Hamano wrote:
>> Alexey Shumkin <Alex.Crezoff@gmail.com> writes:
>> 
>> > v8 of this patch series includes the following changes against v7:
>> 
>> Oops, isn't this already in 'next'?  In that case, please feed
>> incremental updates on top of the patches that are already queued as
>> improvements and fixes.
> Oops ;)
> I'll send patches against 'next' then.

Thanks; please build on top of 7c375214 (t4205: replace .\+ with ..*
in sed commands, 2013-07-01).

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie question: how can I list added files?
Date: Wed, 23 Jun 2010 11:28:10 -0700
Message-ID: <7vvd99eh8l.fsf@alter.siamese.dyndns.org>
References: <AANLkTinxOE5xcP_V-PvoZGlfsxtcCafoYKy_PuBZnQnQ@mail.gmail.com>
 <7vzkylejbf.fsf@alter.siamese.dyndns.org>
 <AANLkTikE2ylLXk5XxNGvcvol6R-puSTzPurdLcNMYaZJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT List <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 20:28:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORUgT-00089x-B7
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 20:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab0FWS2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 14:28:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab0FWS2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 14:28:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 496EFBE909;
	Wed, 23 Jun 2010 14:28:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=374GmC0x1NQs9TQruK1HiQOQ31Y=; b=focoVI
	JSLxSlNGElHUcptc12mWCN7o4nmNUVwlqFE1ckmL61ueF8L1x2+HITrzXP+t37Lo
	sZz39MvVfaigN5Sq8SwpNuueIiiNXAn0jm1ORq4zC2PIxuUdUltbYBvJrk8aW5y2
	Mb0UOdm5kDT3ayJ+L7Ya7sWfNN2SuTDBtO9hE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sEzEay9fyLs+e1xMjHwullE74KutV41Z
	vilFyDa6vMffliFIfP3rOLMdO4kNhXgxm8BxurwVtDLLQILPb8v1yI7eUUbPqk1j
	GWC/sUz0Cv/9fmeZPDlLgok0OuOtIDt2jNhnKnhas7i+E4EMZK37kDUDPS3WhiAo
	Ntoe/w3zJ9g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2886ABE908;
	Wed, 23 Jun 2010 14:28:15 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84255BE902; Wed, 23 Jun
 2010 14:28:12 -0400 (EDT)
In-Reply-To: <AANLkTikE2ylLXk5XxNGvcvol6R-puSTzPurdLcNMYaZJ@mail.gmail.com>
 (Bruce Korb's message of "Wed\, 23 Jun 2010 10\:50\:11 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 16587864-7EF5-11DF-B69F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149527>

Bruce Korb <bruce.korb@gmail.com> writes:

> $ git diff --name-only HEAD
> chip/chopin2/up/hdl/.sopc_builder/install.ptf
> chip/mozart/up_oam/hdl/.sopc_builder/install.ptf
> chip/mozart2/up/hdl/.sopc_builder/install.ptf
> chip/mozart2/up_ft/hdl/.sopc_builder/install.ptf
> sw/embedded/nios2/system/system.stf
> sw/embedded/platform/strad/scripts/mk_relsrc.sh
> sw/projects/nios2/modules/system/lib/system.stf

Try using --name-status instead here and check what you see.

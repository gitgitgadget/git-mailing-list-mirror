From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] completion: complete "unstuck" `git push --recurse-submodules`
Date: Wed, 23 Jul 2014 14:31:22 -0700
Message-ID: <xmqqr41bdaol.fsf@gitster.dls.corp.google.com>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
	<8303c95dd3e3ee8d77d4b994bb2d33b6a155a17f.1406053442.git.john@keeping.me.uk>
	<xmqqr41df8hu.fsf@gitster.dls.corp.google.com>
	<20140722205730.GD26927@serenity.lan>
	<xmqqha29f606.fsf@gitster.dls.corp.google.com>
	<20140723193536.GE26927@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:31:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA48M-00051v-VM
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 23:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933497AbaGWVbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 17:31:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50997 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933426AbaGWVba (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 17:31:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEA412AFE2;
	Wed, 23 Jul 2014 17:31:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M/QES8CHJewWvF1+xIqCr+jc4pU=; b=TFnsFk
	S5NCu229WbiKTtxa93v1jvTKUipkhKXYxSL9Sy8wx1eTNgVYCHpvEtW5BQpOQymY
	xWZG4yXvfklkKyNluSzDokFKwqc2YJ/yw76UILtwMaDUKScHDlqcOk1+0YAZU79N
	7I51nsTRN3Ao9Z6znBRTMYvc8PKFGNIyrdZP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dS8gqpMe8zrip32Pfm3y0szhyRrDnYBn
	EnuZdI94W/jcgHf7OVtc06k9SxdrJZwsHBef+xaNBLuhbzPkx2KXBLlgcIjJDVAl
	nTm18+nFph3ETtGXE/cIsfi+ycNtoEPF+E/xbwr9UzHTs6eT086uc/mbM0zcIVyg
	ytWLiL7dwlM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C55B72AFE1;
	Wed, 23 Jul 2014 17:31:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B3AD32AFD8;
	Wed, 23 Jul 2014 17:31:23 -0400 (EDT)
In-Reply-To: <20140723193536.GE26927@serenity.lan> (John Keeping's message of
	"Wed, 23 Jul 2014 20:35:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1FA2CB0-12B0-11E4-A0A6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254127>

John Keeping <john@keeping.me.uk> writes:

> On Tue, Jul 22, 2014 at 02:17:13PM -0700, Junio C Hamano wrote:
>> John Keeping <john@keeping.me.uk> writes:
>> 
>> > Do you want me to re-roll with this change or can you replace the patch
>> > while applying?
>> 
>> I think I had to flip the third one to adjust to the change I
>> suggested to this; the result will be on 'pu', so please double
>> check when I push it out.
>
> The result on jk/more-push-completion looks good.  Thanks.

Thanks.

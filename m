From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: simplify file filtering
Date: Sun, 12 May 2013 15:54:14 -0700
Message-ID: <7vmwrzu7vt.fsf@alter.siamese.dyndns.org>
References: <1367100099-13798-1-git-send-email-felipe.contreras@gmail.com>
	<20130511094258.GC6196@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 13 00:54:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubf9p-0002fk-QG
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 00:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab3ELWyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 18:54:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53891 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab3ELWyR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 18:54:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F3D71EC29;
	Sun, 12 May 2013 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2AIzz8Ngx1fh6Mg68fnT5/b6+Ws=; b=n2Rs/3
	YpubJgT7gccT4tmKkwvf4IKxto0TGIQyLJ+G30756vV0EfhvG0Fh0dYPPWTHr33c
	pt5mf72UakyW2Fxdp0TuHBNsV61lTBiAdP0/iu9of5O82oYzYm9NqL1nOkOYwzVY
	nMCtza+RksR+l/sxelpaLtmcEhOzv91pwqTrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VKsKE87BPeT11psisg1bq819GJ8Mv37p
	PWhBxD/oi2g0VKESuhCeEd7qiVmh0xg6olYkmJW78itw+W7VHDzQ1W3AF5OPI6H/
	gNWKo6r3d7MbMY02dcsUGDZlAvx2TlVcPcvPf4Sg+qZUoYrJUHZzndg1CbieGM6L
	50F6INVF72g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93F0D1EC28;
	Sun, 12 May 2013 22:54:16 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16D8E1EC26;
	Sun, 12 May 2013 22:54:16 +0000 (UTC)
In-Reply-To: <20130511094258.GC6196@iris.ozlabs.ibm.com> (Paul Mackerras's
	message of "Sat, 11 May 2013 19:42:58 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF374A44-BB56-11E2-926C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224068>

Paul Mackerras <paulus@samba.org> writes:

> On Sat, Apr 27, 2013 at 05:01:39PM -0500, Felipe Contreras wrote:
>> git diff is perfectly able to do this with '-- files', no need for
>> manual filtering.
>> 
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> Thanks, applied, with the commit message expanded to say that this
> makes gettreediffs do the same as getblobdiffs.
>
> Paul.

Thanks; is this the last one for this cycle and is your usual branch
ready to be pulled?

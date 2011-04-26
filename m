From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Automatically autoload bashcompinit for ZSH, when needed
Date: Tue, 26 Apr 2011 14:55:25 -0700
Message-ID: <7vd3k8d6eq.fsf@alter.siamese.dyndns.org>
References: <7vtydkddto.fsf@alter.siamese.dyndns.org>
 <1303849690-20894-1-git-send-email-mstormo@gmail.com>
 <vpqbozszqnu.fsf@bauges.imag.fr> <1303851177.9740.2.camel@Nokia-N900>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 23:55:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEqEW-0005D0-RM
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 23:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944Ab1DZVzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 17:55:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932488Ab1DZVzm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 17:55:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E5D0544C;
	Tue, 26 Apr 2011 17:57:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p3k403ueeCQkNcIJ69b4ovE7pJs=; b=DsHs5Z
	KtFC1/tDdgb+IxdNcWKHYtBDQfrKowZa9FX86/lHqHrA3Hbn/0Jd0Ii8M/DBUUvl
	tQWChnVgLmMFJ2A8Cad9wWiZVVsKsDJLn/Zf1+WyGXp7sV8WtE7hECdMXssKGdBE
	k8wUPj0WygRrprNK3i42XWz+8JSg98uCWXvG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=okD10333iyUO4ratZqbgyNDVJc+aXWR3
	pNo7SdcyR5lSqT341RMJfxlcc6fpKHXssYxrJU/v0Ie6aphCZVX7seycpZZXgPjN
	TANXhoDael8NfFWvSGxqakrrJPK8I1OeqivoUaIWrtZHoNrEVlx28DGxWQscO8Eg
	xiVLy82MnEQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E0BA15449;
	Tue, 26 Apr 2011 17:57:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 638615448; Tue, 26 Apr 2011
 17:57:29 -0400 (EDT)
In-Reply-To: <1303851177.9740.2.camel@Nokia-N900> (Marius Storm-Olsen's
 message of "Tue, 26 Apr 2011 15:52:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31EC4FEA-7050-11E0-B890-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172130>

Marius Storm-Olsen <marius@storm-olsen.com> writes:

> Or Junio could just fix it up when/if picking it.

Surely, no problem.

I do not use zsh myself, so unless a real zsh user complains, I'll queue
it directly on 'master' as part of the batch for the first week.

Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Fri, 29 Apr 2011 09:21:29 -0700
Message-ID: <7vfwp1yqnq.fsf@alter.siamese.dyndns.org>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:21:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqRy-0001Ec-2R
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759984Ab1D2QVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:21:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757954Ab1D2QVi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:21:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 25C8E5105;
	Fri, 29 Apr 2011 12:23:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AMdaiQyHh7gJUTPQ493E6C1Kbqc=; b=q4+KoF
	4Fd5j/kZpChOp9HvK9y12kDNUPnSSfgfuoTmUxLb1iWe5tR817hWv8tHlPtVK3OU
	qSfiXwco7YyYS/Qxd0gj8cCCKuVt4uv5fRend/NxUx89Zlob1vseNdyckyWKsg37
	MOeVfXcKm3y8fy2SVKj1PSFiNsJcaIm0ob/o8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O4sdMGW3t2KBev+RdABmUPIQMASkTRph
	t/V/wCsD1nR+JUxSWtaej3hjrDnSpO6T2v6PFzaT8GygmkAEAgvCSfjnjswogCUB
	A864ZKwha0BpHc0ufVk85OENLtBHTyICv8nBp9H/V/dx/nGB86OA6kRoQMBfeOjn
	q8JcgL03GIU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 01ED05104;
	Fri, 29 Apr 2011 12:23:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 236A05100; Fri, 29 Apr 2011
 12:23:33 -0400 (EDT)
In-Reply-To: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 29 Apr 2011 17:53:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 090A3810-727D-11E0-8EBB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172462>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> HEAD~n is often used for rebase invocations etc.

I thought rebase invocations these days use @{u}.

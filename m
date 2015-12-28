From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] grep: make it clear i-t-a entries are ignored
Date: Mon, 28 Dec 2015 11:59:12 -0800
Message-ID: <xmqq37uml4z3.fsf@gitster.mtv.corp.google.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
	<1451181092-26054-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 20:59:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDdwt-0004XA-1n
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 20:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbbL1T7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 14:59:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752532AbbL1T7P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 14:59:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5501C37D09;
	Mon, 28 Dec 2015 14:59:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pp5XL5ci8fCp3dJZ1C8vkBdknRE=; b=arwMkK
	sxkmdUdy5J6hw0GVDNrefhpGzG7eGx0Pbh2bcWaAhGv/nJ+q9GkuUBUx0srpXgot
	eOVxnNkNeEyxigJNiMNAGBALLWnh3ZeU0EbsAXliRoPsx5yianxQPQYKEnIqQLAH
	vKTUfuHTNE+P9YtaaJLndS72LUZ3YlH/0PoGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WZ1MrS4YcnkR6a2e36CmevolBwjM15wz
	nX6bewfNM52Hd96dWjTRWFrpSkJfcrXS3mPZUJSdkKWSpOHDTUlbRz17F4u/Pnkn
	/DzRIb0cJ8twqG1rvwbABggynate7wXgqtpGyTg4wz36WtqoYDlZ5BDSLAnpp0Gb
	DJ+bckEadV8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C79D37D08;
	Mon, 28 Dec 2015 14:59:14 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BEE6137D07;
	Mon, 28 Dec 2015 14:59:13 -0500 (EST)
In-Reply-To: <1451181092-26054-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 27
 Dec 2015 08:51:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 77E984C4-AD9D-11E5-A47A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283046>

This one looks correct.

I'll pick the obviously correct pieces (1, 2, and 6) from this
series, as they are pretty-much independent, and discard the rest
for now.

Thanks.

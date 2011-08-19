From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] merge: keep stash[] a local variable
Date: Fri, 19 Aug 2011 15:59:52 -0700
Message-ID: <7v8vqp0zyv.fsf@alter.siamese.dyndns.org>
References: <1313674994-22902-1-git-send-email-pclouds@gmail.com>
 <1313765407-29925-1-git-send-email-pclouds@gmail.com>
 <1313765407-29925-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 01:00:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuY2h-0000MJ-Lz
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 01:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447Ab1HSW7z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 18:59:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756407Ab1HSW7y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 18:59:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 157394F3E;
	Fri, 19 Aug 2011 18:59:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eKX9SLIOC5kj
	ktVrjzBTTqGMLy8=; b=v3uv1Lr4qKaadnTp2HO1eHH5nqCVj/j6N5omTmZ3Ubga
	Q0vsaGV9fMapZ+AAFo7ZsmqmXH30n6GeWNo9u7iGRFYuhIS2j7CL1i1jMXg2W0Nf
	uhfYuxDr08guGPl0M+affhhQKWk6vSu7w1UC4qrPREGDODoehNmAMXBs8z1Sdx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bhjKHD
	gaN+op1fyHrV7SDvzG1yi+2lfYiW9JGRXYP5zeaVBF4XL0pi3vmnUzM+yjr+XQ/v
	hhYGMEt5Zxv0iiQ1dVdSERPy0LcVb/43fllVwhNFvkuu9JPBVPjZA3LHxxiML0kX
	KMYxNMYQ2HTDWKZR3vsaQSF9TXM0XaMIitL+w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D3DA4F3D;
	Fri, 19 Aug 2011 18:59:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 962D64F3C; Fri, 19 Aug 2011
 18:59:53 -0400 (EDT)
In-Reply-To: <1313765407-29925-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 19 Aug
 2011 21:50:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3528CBA-CAB6-11E0-BF0F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179742>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> A stash is created by save_state() and used by restore_state(). Pass
> SHA-1 explicitly for clarity and keep stash[] to cmd_merge().

Makes tons of sense; thanks.

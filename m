From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Mon, 17 Mar 2014 15:12:00 -0700
Message-ID: <xmqqfvmgbhlb.fsf@gitster.dls.corp.google.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
	<1394976904-15395-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 23:12:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPflV-0001Et-Nq
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 23:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbaCQWMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 18:12:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbaCQWMF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 18:12:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 837AE75951;
	Mon, 17 Mar 2014 18:12:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+m7quokTxRFk
	rwhJni3mNIW60xs=; b=ppqqkttIRYcrrsz2+A2Ghj3FbDjE0uNO4DzM/sYNwToz
	TxmZqRMOtNDb3PxErO+QYyY58cGIprA+WiVgOOKN8fJcENcvwZuC1Oo8+oaPINqw
	+bG7mboF/Ium2jiNfDkAum7E58MLWEWW6QsCf8nDN8CgGbVME4NRMlTwEKHeeZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cfA/GL
	Fqf/aBpNPCZhgh6rwMiitP9d6UgBScBcZe2LQFZMuFyqkyHvOTCydKiro+m4k2Wz
	es330dSUcV5AxInTuNlrc0vMQNlqpkvbLjLawP9VcWFz9VYKECWMwh3S18cbgxmA
	zywCUAU9ht5CU1W+9dqqXNIZz5LE/f5rFYPNU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C5337594F;
	Mon, 17 Mar 2014 18:12:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71BA17594B;
	Mon, 17 Mar 2014 18:12:03 -0400 (EDT)
In-Reply-To: <1394976904-15395-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 16
 Mar 2014 20:35:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2B4B0EEE-AE21-11E3-8A92-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244299>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> As explained in the previous commit,...

[PATCH 3/4] becomes a commit with an empty log message for some
reason.  Have you tried running "am -s" on it?

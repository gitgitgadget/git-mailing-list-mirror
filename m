From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t7002: set test prerequisite "external-grep" if
 supported
Date: Wed, 06 Jan 2010 18:37:38 -0800
Message-ID: <7v4omyhc7h.fsf@alter.siamese.dyndns.org>
References: <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
 <1262608455-4045-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 03:37:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSiG2-0005xa-Am
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 03:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630Ab0AGChu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 21:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756591Ab0AGCht
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 21:37:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579Ab0AGCht convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 21:37:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D35078EB61;
	Wed,  6 Jan 2010 21:37:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xhd5J0DRptYG
	VJQ/6usW/5YnXTc=; b=EejAXNlQ4V52hP4/w60w5CBALHPgS7GDZMN5pzAcgTMw
	dqIaCeSPNZknbq3lwyD7Pphh7aWecIypTDfoMNVUSKS31tbvE3tO36qO+OBa6kfx
	xtUOL2FGrEUcYvUYoKUZD6Db7icwkolOvabEYJTOae0wa8pTBYlKHObsFiUFG4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wuQByh
	9y48VFs+kXb35vLy5eS/VHARIMg2zvpTpqTgGlwPyDOfcLAIwvpHeOz7FX2cQpBC
	f8SdUf1b9pukaZmIldEnM/hnSNxFzhiIRpW/jQ/Nt0YC/UGvQY9/51qyBWAFVuW+
	DrhluJjUNpF8zYl6+O8KwmFDOfW7e6CArq8kA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB2058EB60;
	Wed,  6 Jan 2010 21:37:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE8768EB54; Wed,  6 Jan
 2010 21:37:39 -0500 (EST)
In-Reply-To: <1262608455-4045-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\,  4 Jan
 2010 19\:34\:14 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A153444C-FB35-11DE-86FD-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136317>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Add another test to set prerequisite "external-grep" if the current
> build supports external grep. This can be used to skip external grep
> only tests on builds that do not support this optimization.

Thanks.  We seem to spell our prerequistes in a single-word, all-caps, =
so
I'll change this new one to EXTGREP in both [1/2] and [2/2].

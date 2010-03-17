From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: only print upstream relationship with -v -v
Date: Wed, 17 Mar 2010 09:53:27 -0700
Message-ID: <7vwrxavqig.fsf@alter.siamese.dyndns.org>
References: <1268838344-8581-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 17:53:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrwV8-0004Uz-N9
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 17:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908Ab0CQQxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 12:53:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab0CQQxf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 12:53:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D1A3A2482;
	Wed, 17 Mar 2010 12:53:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TkGFB15V0gKF
	yTnlqGJX+44J1vg=; b=vsC6O6U2+N3YZvTGv0liDrY/yfl1UXhVqkb4JYzmh3v6
	Nm1ocrKd9sStyEolSLdHXEj0NXiftv5iPHT2tV04COjs9V2I2LxDymt3jlQq0hla
	tWhA1BGfJHm7U0s0TI+Cw/GiWjKeFuTRGl8eVMdyknpWeUyEqpICXnRCpC/p6HY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aiPOwE
	K+KKTi2DcO90nBCaDDbQLshS/1NkPyEVsqlYsPA8buu8k9XbD66DnG83SUuYP33v
	7mk1F88LGNPfdXj2SL3/7sPoin9xeZwatUXlENtc3XMDMsB3nueOg/QWn6BmkLre
	LkIjo+ZcOn2vrxtSIY7xaiQNXUlnqNI8rjnfI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B6C3A247E;
	Wed, 17 Mar 2010 12:53:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 752E6A247C; Wed, 17 Mar
 2010 12:53:29 -0400 (EDT)
In-Reply-To: <1268838344-8581-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 17 Mar
 2010 22\:05\:44 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9E757074-31E5-11DF-B3DE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142414>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> "git branch -v" is unusable for me because it's too slow.
> ...
> This is on a repository with ~30 branches, some are hundreds of
> patches behind upstream.

Perhaps you have an overeager branch.autosetupmerge configuration?

I dunno.  I seem to have a lot more branches than you do (currently
56), but most of them are topics that, once they forked from a
particular commit, never merge other random commits, only because they
have new commits that are unrelated to the objective of the topic, so
most of my branches do not have "upstream" in that sense.

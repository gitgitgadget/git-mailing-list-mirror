From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] archive: add a failure test wrt .gitattributes  
 misreading
Date: Thu, 16 Apr 2009 01:22:26 -0700
Message-ID: <7v4owpm2il.fsf@gitster.siamese.dyndns.org>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
 <1239185133-4181-2-git-send-email-pclouds@gmail.com>
 <1239185133-4181-3-git-send-email-pclouds@gmail.com>
 <1239185133-4181-4-git-send-email-pclouds@gmail.com>
 <7vab6rkl5f.fsf@gitster.siamese.dyndns.org> <49E3448B.8010602@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 16 10:24:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuMtF-0003Dq-BZ
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 10:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbZDPIWi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2009 04:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbZDPIWg
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 04:22:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbZDPIWf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Apr 2009 04:22:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E376EF520;
	Thu, 16 Apr 2009 04:22:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3E680F516; Thu,
 16 Apr 2009 04:22:30 -0400 (EDT)
In-Reply-To: <49E3448B.8010602@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Mon, 13 Apr 2009 15:56:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC6D1B9C-2A5F-11DE-A303-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116685>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Hmm, "fix" implies that something is broken without this option, whic=
h
> is not necessarily the case.

"What is recorded in the tree is unsuitable for the purpose of this
particular export, so we are xxxing using yyy", is the intended use cas=
e,
and I think the verb "fix" is a good fit there in "xxx" part.  "Tweak"
would also work well.

Your suggestion is to say "attributes from the work tree" in place of
"yyy", which also is good.

I got the impression that people tend to prefer the operation named aft=
er
what it does than how it does it, but I can go either way.

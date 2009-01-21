From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] color-words: Support diff.wordregex config option
Date: Wed, 21 Jan 2009 02:27:37 -0800
Message-ID: <7vvds9dkdi.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <200901192145.21115.bss@iguanasuicide.net>
 <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de>
 <200901202146.58651.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 11:29:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPaKh-0001Cq-11
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 11:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759670AbZAUK1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 05:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759407AbZAUK1t
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 05:27:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759283AbZAUK1s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 05:27:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1280F1CED5;
	Wed, 21 Jan 2009 05:27:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 683AA1CE92; Wed,
 21 Jan 2009 05:27:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2617556E-E7A6-11DD-8EE2-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106592>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

> When diff is invoked with --color-words (w/o =regex), use the regular
> expression the user has configured as diff.wordregex.
>
> diff drivers configured via attributes take precedence over the
> diff.wordregex-words setting.  If the user wants to change them, they have
> their own configuration variables.
>
> Signed-off-by: Boyd Stephen Smith Jr <bss@iguanasuicide.net>
> ---
> This version is squashed into one patch and includes documentation and
> rewritten tests.  It was generated against js/diff-color-words~2,
> 80c49c3d (color-words: make regex configurable via attributes), replacing
> my previous 2 patches.  It uses "diff.wordregex" for reasons mention by
> Dscho and because that was already what the diff drivers were using.

Nicely done and very well described.  I fixed the Subject: line, though ;-)

Thanks.

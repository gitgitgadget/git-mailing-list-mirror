From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .ft tag in man
Date: Tue, 13 Jan 2009 21:35:33 -0800
Message-ID: <7veiz678m2.fsf@gitster.siamese.dyndns.org>
References: <20090114052126.GA6849@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 06:37:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMyRT-0006xX-Ri
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 06:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759545AbZANFfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 00:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759421AbZANFfo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 00:35:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759444AbZANFfm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 00:35:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F28881C6DB;
	Wed, 14 Jan 2009 00:35:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6C2861C6F0; Wed,
 14 Jan 2009 00:35:36 -0500 (EST)
In-Reply-To: <20090114052126.GA6849@b2j> (bill lam's message of "Wed, 14 Jan
 2009 13:21:26 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D8B764E-E1FD-11DD-96A2-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105586>

bill lam <cbill.lam@gmail.com> writes:

> The diagram in man contain some .ft tag, eg inside
> PAGE=less git help rebase
> it contains
>
>            .ft C
>                      A---B---C topic
>                     /
>                D---E---F---G master
>            .ft

No, I do not see that neither on my Debian nor on k.org's FC 9.

Perhaps you are using different version of asciidoc/docbook/xmlto
toolchain?

I think we added compatibility definitions in our Makefile to deal with
differences between AsciiDoc 7 vs 8, but I do not recall offhand what
misformatting one would get if it is set incorrectly..

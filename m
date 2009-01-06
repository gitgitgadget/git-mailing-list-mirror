From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix sourcing "test-lib.sh" using dash shell in
 "t3003-ls-files-narrow-match.sh"
Date: Tue, 06 Jan 2009 00:18:38 -0800
Message-ID: <7vzli4kftt.fsf@gitster.siamese.dyndns.org>
References: <20090105143002.8a369535.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:20:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7AT-0007ga-GA
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbZAFISq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbZAFISp
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:18:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbZAFISp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:18:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C0A7D1BE94;
	Tue,  6 Jan 2009 03:18:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5ACB41BE89; Tue, 
 6 Jan 2009 03:18:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A28965DE-DBCA-11DD-A498-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104652>

Christian Couder <chriscool@tuxfamily.org> writes:

> dash barfs, on my old Ubuntu box, when "test-lib.sh" is sourced
> without "./".
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t3003-ls-files-narrow-match.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> 	This patch applies to "pu".

Thanks; I hope you don't mind squashing this in to 'Introduce "sparse
patterns"'.

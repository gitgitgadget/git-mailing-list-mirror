From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation: bisect: add a few "git bisect run"
 examples
Date: Tue, 06 May 2008 21:59:57 -0700
Message-ID: <7vwsm6g14i.fsf@gitster.siamese.dyndns.org>
References: <20080507062931.dd72d7e1.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed May 07 07:01:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtbm5-0002oX-19
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 07:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbYEGFAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 01:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbYEGFAP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 01:00:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbYEGFAN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 01:00:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B7E6E2160;
	Wed,  7 May 2008 01:00:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D25A32E2E; Wed,  7 May 2008 01:00:04 -0400 (EDT)
In-Reply-To: <20080507062931.dd72d7e1.chriscool@tuxfamily.org> (Christian
 Couder's message of "Wed, 7 May 2008 06:29:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7904C494-1BF2-11DD-9207-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81404>

Christian Couder <chriscool@tuxfamily.org> writes:

> Before this patch, there were no proper "git bisect run" example.

As if there were improper examples, and as if this patch adds a proper
one.  Drop "proper" and add sign-off perhaps?  ;-)

> ---
>  Documentation/git-bisect.txt |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index 698ffde..a05963a 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -224,6 +224,32 @@ tree to the pristine state.  Finally the "run" script can exit with
>  the status of the real test to let "git bisect run" command loop to
>  know the outcome.
>  
> +EXAMPLES
> +--------
> ...
> +* Automatically bisect a broken test case using a custom script:
> ++
> +------------
> +echo "#"\!"/bin/sh" > ~/test.sh
> +echo "make install || exit 125" >> ~/test.sh
> +echo "~/check_test_case.sh" >> ~/test.sh
> +chmod u+x ~/test.sh

s/install//; let's not set a bad example of installing first and then
testing.

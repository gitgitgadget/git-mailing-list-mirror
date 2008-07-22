From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH for master] Rename path_list to string_list
Date: Mon, 21 Jul 2008 19:28:09 -0700
Message-ID: <7v3am2sldy.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807211858330.8986@racer>
 <alpine.DEB.1.00.0807211904090.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 04:29:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL7cs-0003AQ-VO
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 04:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbYGVC2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 22:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753577AbYGVC2T
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 22:28:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbYGVC2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 22:28:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 224F1326E6;
	Mon, 21 Jul 2008 22:28:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1E1B0326E4; Mon, 21 Jul 2008 22:28:11 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807211904090.8986@racer> (Johannes
 Schindelin's message of "Mon, 21 Jul 2008 19:05:30 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D71608C0-5795-11DD-8E58-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89424>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> @@ -64,9 +65,10 @@ Functions
>  
>  `string_list_clear`::
>  
> -	Free a string_list. The `path` pointer of the items will be freed in case
> -	the `strdup_strings` member of the string_list is set. The second parameter
> -	controls if the `util` pointer of the items should be freed or not.
> +	Free a string_list. The `path` pointer of the items will be freed in
> +	case the `strdup_strings` member of the string_list is set. The second
> +	parameter controls if the `util` pointer of the items should be freed
> +	or not.

Missed 's/path/string/' here?

Everything else looked fine, thanks.

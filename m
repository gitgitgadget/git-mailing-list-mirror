From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] valgrind: do not require valgrind 3.4.0 or newer
Date: Thu, 05 Feb 2009 12:32:08 -0800
Message-ID: <7vzlh0bp6f.fsf@gitster.siamese.dyndns.org>
References: <cover.1233858507u.git.johannes.schindelin@gmx.de>
 <b204f01577584835f1c0252c77ffbfab33442a79.1233858507u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVAv0-0001ws-HX
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758893AbZBEUcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 15:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758724AbZBEUcS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:32:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758404AbZBEUcR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:32:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8311096C6D;
	Thu,  5 Feb 2009 15:32:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0318596C6B; Thu,
  5 Feb 2009 15:32:09 -0500 (EST)
In-Reply-To: <b204f01577584835f1c0252c77ffbfab33442a79.1233858507u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Thu, 5 Feb 2009 19:34:27 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 135E89EA-F3C4-11DD-AF19-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108611>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Valgrind 3.4.0 is pretty new, and even if --track-origins is a nice
> feature, it is not the end of the world if that is not available.  So
> play nice and use that option only when only an older version of
> valgrind is available.

s/older/newer/?

> +TRACK_ORIGINS=
> +case "$(valgrind --version)" in
> +valgrind-{3.[4-9],3.[1-3][0-9],[4-9],[1-3][0-9]}*)
> +	TRACK_ORIGINS=--track-origins=yes
> +esac

What kind of case pattern is that?

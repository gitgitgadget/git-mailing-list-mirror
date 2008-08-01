From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-name-rev: refactor stdin handling to its own
 function
Date: Fri, 01 Aug 2008 12:07:41 -0700
Message-ID: <7vtze4sgea.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808011256330.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <1217589372-4151-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Aug 01 21:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOzzg-0003f2-77
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 21:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbYHATHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 15:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbYHATHu
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 15:07:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbYHATHt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 15:07:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 666A746BB7;
	Fri,  1 Aug 2008 15:07:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5613446B9C; Fri,  1 Aug 2008 15:07:43 -0400 (EDT)
In-Reply-To: <1217589372-4151-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Fri, 1 Aug 2008 13:16:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 217B054A-5FFD-11DD-BC90-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91077>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
> ---
>
>     On 1 aug 2008, at 09:23, Junio C Hamano wrote:
>     >Is it just me to find that this part is getting indented too deeply to be
>     >readable?
>
>     How about something like this then?

Much nicer, except that this refactoring should come first and then a new
feature.  Dropping those extra five 's' so that it would compile would be
a nice bonus as well ;-)

> ...
> +
> +			if (name_only) {
> +				fwrite(p_start, p - p_start + 1 - 40,
> +					1, stdout);sssss
> +				printf(name);
> +			}

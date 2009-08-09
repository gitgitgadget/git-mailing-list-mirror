From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6 (v2)] full integration of rev-cache into git's
 revision walker, completed test suite
Date: Sun, 09 Aug 2009 11:22:00 -0700
Message-ID: <7v1vnk97av.fsf@alter.siamese.dyndns.org>
References: <op.uyb1vl2jtdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	"Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Andreas Ericsson" <exon@op5.se>,
	"Christian Couder" <christian@couder.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Nick Edelen" <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 20:22:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaD2K-0001Qy-Mx
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 20:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbZHISWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 14:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbZHISWU
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 14:22:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbZHISWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 14:22:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F62E23F71;
	Sun,  9 Aug 2009 14:22:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A08AD23F6E; Sun,  9 Aug 2009
 14:22:02 -0400 (EDT)
In-Reply-To: <op.uyb1vl2jtdk399@sirnot.private> (Nick Edelen's message of
 "Sat\, 08 Aug 2009 09\:31\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 936660AC-8511-11DE-A689-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125360>

"Nick Edelen" <sirnot@gmail.com> writes:

> This patch provides a working integration of rev-cache into the revision 
> walker, along with some touch-ups:

This message from me is not about the patch 5/6 at all.  It is about your
earlier patches in the series.

> ...
> -	printf("queue:\n");
> +	fprintf(stderr, "queue:\n");
> ...
> -	printf("work:\n");
> +	fprintf(stderr, "work:\n");
> ...
> -	printf("pending:\n");
> +	fprintf(stderr, "pending:\n");
> ...
> - 	pptr = &item->parents;
> +	pptr = &item->parents;
> ...
> -#define SLOP		5
> +#define SLOP			5
> ...

These are all "Shoot, the mistakes in earlier ones need to be fixed here"
changes.

Please fix them in the patch earlier in the series so that you do not have
to make, and more importantly, reviewers do not have to get distracted by,
these fix-up in a later patch like this.

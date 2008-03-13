From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/16] add test_cmp function for test scripts
Date: Thu, 13 Mar 2008 13:48:35 -0700
Message-ID: <7v63vqxsd8.fsf@gitster.siamese.dyndns.org>
References: <cover.1205356737.git.peff@peff.net>
 <20080312213636.GG26286@coredump.intra.peff.net>
 <7vmyp34mn6.fsf@gitster.siamese.dyndns.org>
 <20080313120821.GA19485@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 21:49:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZuMn-00063M-LK
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbYCMUsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 16:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbYCMUsx
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 16:48:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbYCMUsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 16:48:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A694A21BB;
	Thu, 13 Mar 2008 16:48:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E74AA21BA; Thu, 13 Mar 2008 16:48:42 -0400 (EDT)
In-Reply-To: <20080313120821.GA19485@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 13 Mar 2008 08:08:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77136>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 12, 2008 at 03:12:45PM -0700, Junio C Hamano wrote:
>
>> I think I have an earlier round of this in 'pu'.
>
> Oops, so you do. I remember discussing it but didn't recall a patch
> coming out of it.
>
> I see you have queued mine now in pu over yours. I actually think yours
> looks a little nicer (you sanity-check the comparator, and you are more
> careful with stdin (something that I considered, but figured we could
> add if something actually broke)).
>
> Any reason not to keep your existing one over mine?

Yours is much simpler.

And it is tested on the field, so if it ever breaks I have somebody else
to blame ;-)

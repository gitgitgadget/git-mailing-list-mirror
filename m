From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff --check is stupid about blank lines
Date: Wed, 20 Aug 2008 15:39:25 -0700
Message-ID: <7v8wurnwf6.fsf@gitster.siamese.dyndns.org>
References: <20080820140517.GA1304@atjola.homenet>
 <20080820172825.GC27773@sigill.intra.peff.net>
 <7v7iabsgfk.fsf@gitster.siamese.dyndns.org>
 <7vskszr0it.fsf@gitster.siamese.dyndns.org>
 <20080820222048.GB8137@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:40:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVwM1-0003D3-Gm
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 00:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbYHTWje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 18:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbYHTWje
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 18:39:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbYHTWjd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 18:39:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 507E161FA0;
	Wed, 20 Aug 2008 18:39:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2A68861F9F; Wed, 20 Aug 2008 18:39:27 -0400 (EDT)
In-Reply-To: <20080820222048.GB8137@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 20 Aug 2008 18:20:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB7393C6-6F08-11DD-9EA2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93067>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 20, 2008 at 11:42:34AM -0700, Junio C Hamano wrote:
>
>> Ahhh, what idiot wrote the logic for checking trailing blank lines in
>> checkdiff_consume().
>> 
>> It does not ask for any context lines.  Sheesh.
>> 
>> This should fix it.
>
> Ah, that was much easier than I expected. ;)
>
> Maybe this should be squashed in?

Thanks but I've done that myself already.

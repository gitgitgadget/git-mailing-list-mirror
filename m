From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 06/11 v2] fast-import: Add support for importing commit
 notes
Date: Wed, 29 Jul 2009 19:35:20 -0700
Message-ID: <7veiryoq3b.fsf@alter.siamese.dyndns.org>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
 <20090729142634.GC1033@spearce.org> <7v8wi7wjex.fsf@alter.siamese.dyndns.org>
 <200907300229.13642.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	barkalow@iabervon.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 30 04:35:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWLUW-00024S-ML
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 04:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbZG3Cf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 22:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbZG3Cf2
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 22:35:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbZG3Cf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 22:35:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EAE4C164F4;
	Wed, 29 Jul 2009 22:35:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 12630164EF; Wed, 29 Jul 2009
 22:35:21 -0400 (EDT)
In-Reply-To: <200907300229.13642.johan@herland.net> (Johan Herland's message
 of "Thu\, 30 Jul 2009 02\:29\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A48AC098-7CB1-11DE-B899-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124437>

Johan Herland <johan@herland.net> writes:

> On Wednesday 29 July 2009, Junio C Hamano wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
> ...
>> > See above about notes.
>>
>> I think we are in agreement then.  Good.
>
> We do? on what?

We might mind if fast-import does not handle tags to non-commits, but we
would want to restrict notes to apply only to commits for other reasons
anyway, and it is perfectly fine if your patch handled only notes that are
attached to commits and not arbitrary objects.

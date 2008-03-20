From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git-bisect unsure
Date: Wed, 19 Mar 2008 17:55:59 -0700
Message-ID: <7vod9az00w.fsf@gitster.siamese.dyndns.org>
References: <CE6D7D80-DC0F-4840-8B95-7482EE0E71A3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:57:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc95p-00057G-R3
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934681AbYCTA4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 20:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936512AbYCTA4J
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:56:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764555AbYCTA4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:56:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 583A514BC;
	Wed, 19 Mar 2008 20:56:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A986414BB; Wed, 19 Mar 2008 20:56:01 -0400 (EDT)
In-Reply-To: <CE6D7D80-DC0F-4840-8B95-7482EE0E71A3@gmail.com> (Kate Rhodes's
 message of "Tue, 18 Mar 2008 11:57:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77607>

"Rhodes, Kate" <masukomi@gmail.com> writes:

> My proposal is to add an "unsure" option to git-bisect.
>
> I'm thinking that when you say "git bisect unsure" it would simply
> shift one commit earlier or later and refrain from ever checking out
> one marked unsure until there were only "unsure" ones left at which
> point it would add a disclaimer when you called bad or good and throw
> up it's hands in frustration if you were to say "unsure" again.

Patches welcome.

^L

But if this is what you are trying to say:

    6ca8b97 (Bisect: add "skip" to the short usage string., 2007-10-29)

you are about 4.5 months late ;-).

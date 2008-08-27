From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in
 gittutorial
Date: Wed, 27 Aug 2008 11:06:44 -0700
Message-ID: <7v1w0aqqmj.fsf@gitster.siamese.dyndns.org>
References: <20080825215023.11822a20@paolo-desktop>
 <loom.20080825T200956-169@post.gmane.org>
 <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
 <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
 <7vy72kbov4.fsf@gitster.siamese.dyndns.org>
 <4d8e3fd30808260116o543f1a61sd05070fe02f69d2e@mail.gmail.com>
 <7viqtnabld.fsf@gitster.siamese.dyndns.org>
 <4d8e3fd30808270058g3379174bn9efe09f550aa0721@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Eric Raible" <raible@gmail.com>, git@vger.kernel.org
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 20:08:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPQy-0001kl-7O
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbYH0SGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYH0SGw
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:06:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbYH0SGv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:06:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EB71D6AA85;
	Wed, 27 Aug 2008 14:06:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C073C6AA84; Wed, 27 Aug 2008 14:06:45 -0400 (EDT)
In-Reply-To: <4d8e3fd30808270058g3379174bn9efe09f550aa0721@mail.gmail.com>
 (Paolo Ciarrocchi's message of "Wed, 27 Aug 2008 09:58:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC354B64-7462-11DD-87E3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93911>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> What do you think of this whitespace damaged patch?

Looks fine; I slightly miss the dotless form of gitk to show both
histories fully that was in the original, though.  Before this part, the
tutorial has one invocation of gitk to view the history leading to the
current state, and as a gentle introduction I think showing two full
histories first before teaching to limit might make more sense, but that
is minor.

> diff --git a/gittutorial.txt.txt b/gittutorial.txt.txt
> index 48d1454..384972c 100644
> --- a/gittutorial.txt.txt
> +++ b/gittutorial.txt.txt

I have to wonder why txt.txt, though.

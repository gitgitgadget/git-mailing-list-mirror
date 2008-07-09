From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] cherry: cache patch-ids to avoid repeating work
Date: Tue, 08 Jul 2008 23:24:58 -0700
Message-ID: <7vprpnlglh.fsf@gitster.siamese.dyndns.org>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
 <7vfxqjmyg2.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Geoffrey Irving" <irving@naml.us>
X-From: git-owner@vger.kernel.org Wed Jul 09 08:26:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGT81-00064d-Du
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 08:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbYGIGZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 02:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbYGIGZP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 02:25:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbYGIGZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 02:25:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D6FF218D98;
	Wed,  9 Jul 2008 02:25:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2CC3F18D97; Wed,  9 Jul 2008 02:25:06 -0400 (EDT)
In-Reply-To: <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>
 (Geoffrey Irving's message of "Tue, 8 Jul 2008 22:26:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C98DCFD2-4D7F-11DD-9BF5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87852>

"Geoffrey Irving" <irving@naml.us> writes:

> On Tue, Jul 8, 2008 at 10:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>>>  }

Please don't quote the whole thing without trimming if you do not have any
interspersed comments/responses to quoted part.

> Should I rewrite the patch sequence to incorporate these changes into
> the first commit, or add them as a forth commit off the end?

I strongly encourage the latter.  We try not to keep early mistakes in the
history (see my comments on your [2/3]).

It is not unusal for any sizeable new code to go through a few round of
review cycle without even queued to 'pu', and the general rule is until
the series hits 'next', it is either "rejected (dropped on the floor),
please resend an improved version" or "ok now it is good, will queue".
After queued in 'next', improvements will continue incrementally.

Think of this procedure as giving a chance for you to hide early
embarrassment under the rug ;-)

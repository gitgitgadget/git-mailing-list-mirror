From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Demonstrate bugs when a directory is replaced with a
 symlink
Date: Wed, 29 Jul 2009 15:44:57 -0700
Message-ID: <7vprbjp0ra.fsf@alter.siamese.dyndns.org>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
 <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
 <4A70062A.4040008@drmicha.warpmail.net>
 <7v4osvyjl2.fsf@alter.siamese.dyndns.org>
 <3BA20DF9B35F384F8B7395B001EC3FB342402AD9@azsmsx507.amr.corp.intel.com>
 <7v63dbuyru.fsf@alter.siamese.dyndns.org>
 <3BA20DF9B35F384F8B7395B001EC3FB342402D3C@azsmsx507.amr.corp.intel.com>
 <alpine.LFD.2.01.0907291440480.3161@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Pickens\, James E" <james.e.pickens@intel.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:45:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWHtd-0002SE-Km
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbZG2WpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 18:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbZG2WpI
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:45:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbZG2WpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 18:45:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 264D619887;
	Wed, 29 Jul 2009 18:45:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1EAD019886; Wed,
 29 Jul 2009 18:44:58 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907291440480.3161@localhost.localdomain>
 (Linus Torvalds's message of "Wed\, 29 Jul 2009 15\:08\:12 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 761D5DA8-7C91-11DE-8CCC-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124401>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 29 Jul 2009, Pickens, James E wrote:
>>
>> This test creates two directories, a/b and a/b-2, then replaces a/b with
>> a symlink to a/b-2, then merges that change into the 'baseline' commit,
>> which contains an unrelated change.
>
> Great tests.
>
> This patch should fix the 'checkout' issue.

Thanks.

I've queued v2 with local fixes and Kjetil's earlier fix in 'pu' that
updates has_symlink_leading_path() breakage.  Will take a look at your
patch (and v3 test) later.

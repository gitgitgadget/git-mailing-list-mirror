From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Wed, 29 Jul 2009 01:39:22 -0700
Message-ID: <7vws5rx4qt.fsf@alter.siamese.dyndns.org>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vljm84htf.fsf@alter.siamese.dyndns.org>
 <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com>
 <7vab2oynhm.fsf@alter.siamese.dyndns.org>
 <cb7bb73a0907290120x72d0ae99p7cfdd2b88264a24a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4hH-0007A1-MG
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbZG2Ijb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 04:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbZG2Ija
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:39:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbZG2Ija (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 04:39:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6038718CCF;
	Wed, 29 Jul 2009 04:39:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C203018CCE; Wed,
 29 Jul 2009 04:39:24 -0400 (EDT)
In-Reply-To: <cb7bb73a0907290120x72d0ae99p7cfdd2b88264a24a@mail.gmail.com>
 (Giuseppe Bilotta's message of "Wed\, 29 Jul 2009 10\:20\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 553DD16A-7C1B-11DE-8BB7-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124324>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> I was thinking more about consistency than 'correctness'  in this
> case, actually. Typical scenario would be: patch is created for a file
> using a given whitespace convention (e.g. 4 spaces). File is updated
> to match the rest of the project (tabs). Patch would now introduce the
> wrong whitespace convention for the new lines.

You are assuming that the patch is always based on a wrong convention and
the target always uses the right convention.  In general, however, you
cannot tell which way the "consisitency" should go --- often you have to
apply a patch based on a fixed codebase to an older version.

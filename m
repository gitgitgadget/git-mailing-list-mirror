From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Implement unstage and reset modes for
 git-add--interactive
Date: Fri, 24 Jul 2009 09:39:39 -0700
Message-ID: <7vocrakpbo.fsf@alter.siamese.dyndns.org>
References: <200907231041.32567.trast@student.ethz.ch>
 <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 24 18:39:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUNoI-0003FZ-2n
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 18:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbZGXQjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 12:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbZGXQjs
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 12:39:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbZGXQjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 12:39:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C5D0E100DC;
	Fri, 24 Jul 2009 12:39:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3BC9A100D9; Fri, 24 Jul 2009
 12:39:40 -0400 (EDT)
In-Reply-To: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri\, 24 Jul 2009 11\:15\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99171206-7870-11DE-96CF-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123929>

Thomas Rast <trast@student.ethz.ch> writes:

> I'm not completely happy with the idea of reset --interactive by the
> way, as it's not a reset in the 'reset $commit' sense.

Why not?

"resetting index entries selectively" makes perfect sense.  So do
"checking out index entries selectively" and "adding to index
selectively".

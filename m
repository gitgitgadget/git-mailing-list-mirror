From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document 'stash clear' recovery via unreachable commits
Date: Sat, 08 Aug 2009 18:25:55 -0700
Message-ID: <7veirlbwws.fsf@alter.siamese.dyndns.org>
References: <9e8ddf7c6c4d4df4150bff0467b461bfff92a401.1249778711.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Aug 09 03:26:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZxB4-0004gl-J8
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 03:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbZHIB0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 21:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbZHIB0F
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 21:26:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbZHIB0F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 21:26:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 48FB622AEE;
	Sat,  8 Aug 2009 21:26:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CB4C222AEC; Sat,  8 Aug 2009
 21:25:57 -0400 (EDT)
In-Reply-To: <9e8ddf7c6c4d4df4150bff0467b461bfff92a401.1249778711.git.trast@student.ethz.ch> (Thomas Rast's message of "Sun\, 9 Aug 2009 02\:47\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 99A78150-8483-11DE-8678-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125315>

Thomas Rast <trast@student.ethz.ch> writes:

> Add an example to the stash documentation that shows how to quickly
> find candidate commits among the 'git fsck --unreachable' output.

Thanks.

> Unless you have merges of branch names containing WIP, or edit your
> merge messages to say WIP, there will be no false positives.

That may be true, but I suspect that people's stash entries that are worth
saving are given their own messages with "git stash save 'message'" and do
not necessarily say WIP.  I wish if there were a better way to identify
them, but I do not think of any offhand.

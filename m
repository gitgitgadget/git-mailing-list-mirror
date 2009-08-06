From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 1/3] gitweb: support to globally disable a snapshot
 format
Date: Wed, 05 Aug 2009 23:20:56 -0700
Message-ID: <7vtz0lpinr.fsf@alter.siamese.dyndns.org>
References: <35210404-7E4C-4CB9-881C-45C9E61ACECE@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Aug 06 08:21:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYwM8-0003Ho-8V
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 08:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbZHFGVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 02:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbZHFGVD
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 02:21:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbZHFGVB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 02:21:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FD8E1F833;
	Thu,  6 Aug 2009 02:21:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 053531F830; Thu,  6 Aug 2009
 02:20:57 -0400 (EDT)
In-Reply-To: <35210404-7E4C-4CB9-881C-45C9E61ACECE@uwaterloo.ca> (Mark A.
 Rada's message of "Thu\, 6 Aug 2009 00\:24\:53 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4FCA9F88-8251-11DE-AC32-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125045>

Mark A Rada <marada@uwaterloo.ca> writes:

> Re-ordered, as suggested by Junio.
>
> --
> Mark A Rada (ferrous26)
> marada@uwaterloo.ca
>
>
> --->8---

Please have all of the above after the "---" line.

> From: Mark Rada <marada@uwaterloo.ca>
> Date: Wed, 5 Aug 2009 21:02:54 -0400
> Subject: [PATCH 1/3] gitweb: support to globally disable a snapshot
> format

And you do not need these four lines, as they match what you have in the
e-mail header.

> I added an optional variable, 'disabled', to to the
> $known_snapshot_formats keys so that a Gitweb administrator can
> globally enable or disable a specific format for snapshots.

"to to"?

We tend not to say "I did this and that" in our log messsages; order the
codebase to do certain new things, or order the maintainer to change the
code to make it do new things. e.g.

	Allow gitweb administrators to set in %known_snapshot_formats hash
	an optional key, 'disabled' for specific format.  This can be used
	to configure out individual formats.

> All formats are enabled by default because project specific overriding
> is disabled by default.

That is not quite a good justification; but "all the formats have been
enabled so far, and installing an updated gitweb should not change the
existing behaviour" is.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Clarify the gitmodules and submodules docs
Date: Wed, 08 Apr 2009 00:16:10 -0700
Message-ID: <7vljqbpqdh.fsf@gitster.siamese.dyndns.org>
References: <1239172816-38966-1-git-send-email-pbaker@retrodict.com>
 <526944450904080004r1249d1b8j4a44472d72502b9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: P Baker <me@retrodict.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 09:18:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrS32-0008Ff-8T
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 09:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbZDHHQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 03:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761571AbZDHHQS
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 03:16:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762276AbZDHHQR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 03:16:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A723A85B3;
	Wed,  8 Apr 2009 03:16:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 111A8A85AB; Wed,
  8 Apr 2009 03:16:12 -0400 (EDT)
In-Reply-To: <526944450904080004r1249d1b8j4a44472d72502b9c@mail.gmail.com>
 (P. Baker's message of "Wed, 8 Apr 2009 03:04:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26386760-240D-11DE-93DB-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116054>

I think the new description is good, and the message claims to be sent by
send-email, but I am seeing a funny whitespace damage everywhere in your
patch.

 * Signed-off-by: and the three-dash lines have a leading SP

 * The first line of diffstat is indented by one SP as expected; the
   second line has one extra SP at the beginning.

 * everything after that has one extra SP at the beginning.  Also the hunk
   header for the first hunk is linewrapped.

Very curious.  I could just hand munge the patch if I wanted to, but I'd
rather not.  As you are in "GSoC preparation", I expect to receive
patches, perhaps tons of them, from you in the future, and I'd want to see
easier procedural wrinkles straightened out first.  That will allow us to
concentrate on the substance when "the real thing" starts.

    Added some explanation to the docs to clear up some confusing parts of
    git-submodules that appeared frequently on the mailing list.

We tend to say "Add some explanation..." here.  Think of it as your giving
an order to _me_, "cause this to happen", by accepting and applying your
patch.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] mergetool-lib: add diffuse as merge and diff tool
Date: Thu, 02 Apr 2009 11:06:07 -0700
Message-ID: <7vhc17exrk.fsf@gitster.siamese.dyndns.org>
References: <1238668246-762-1-git-send-email-davvid@gmail.com>
 <1238668246-762-2-git-send-email-davvid@gmail.com>
 <1238668246-762-3-git-send-email-davvid@gmail.com>
 <20090402104252.GA29223@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Pipping <sebastian@pipping.org>, git@vger.kernel.org,
	spearce@spearce.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 20:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpRKQ-0000jk-OE
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 20:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbZDBSGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 14:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbZDBSGR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 14:06:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbZDBSGR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 14:06:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B2577B62F;
	Thu,  2 Apr 2009 14:06:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E6D8AB62E; Thu, 
 2 Apr 2009 14:06:08 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F411D1F0-1FB0-11DE-A666-781813508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115478>

David Aguilar <davvid@gmail.com> writes:

> git-send-email (probably gmail, too) won't let me send
> one patch in a series with a different "From:" header,
> so maybe you should resend this patch so that you can get the
> proper authorship recognition?  I've attached the original
> patch file I sent in case you want to just grab it and
> send-email it back out for the purposes of getting the right
> authorship in there (actually, Junio, please advise...,
> I'm not exactly sure what you'd prefer)

The way you marked your 3/3 with a From: line in the body of the message
is the preferred way to say "David forwards a patch from Sebastian", and
our patch application tool knows about it.

If you wanted to preserve the original author date, you could have also
added a Date: line in-body ("David forwards a patch from Sebastian, who
created it at this date in this timezone").  You can find an earlier
example in:

    http://article.gmane.org/gmane.comp.version-control.git/115289

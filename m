From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] avoid trailing whitespace in zero-change diffstat
 lines
Date: Sat, 14 Jun 2008 00:22:38 -0700
Message-ID: <7vtzfwh45d.fsf@gitster.siamese.dyndns.org>
References: <20080614064857.GA8930@sigill.intra.peff.net>
 <20080614065614.GC9006@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 14 09:23:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Q73-00070H-Kq
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbYFNHW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbYFNHWz
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:22:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbYFNHWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:22:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3BE3C1618;
	Sat, 14 Jun 2008 03:22:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 85C0B1617; Sat, 14 Jun 2008 03:22:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B45C52BA-39E2-11DD-9DFF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84977>

Jeff King <peff@peff.net> writes:

> In some cases, we produce a diffstat line even though no lines have
> changed (e.g., because of an exact rename). In this case, there is no
> +/- "graph" after the number of changed lines. However, we output the
> space separator unconditionally, meaning that these lines contained a
> trailing space character.
>
> This isn't a huge problem, but in cleaning up the output we are able to
> eliminate some trailing whitespace from a test vector.

This is why I love your patches.  Not merely fixing superficial issues but
doing so with _real thinking_ ;-)

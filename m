From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-branch - allow deleting a fully specified
 branch-name
Date: Mon, 13 Apr 2009 02:54:27 -0700
Message-ID: <7vws9ohoa4.fsf@gitster.siamese.dyndns.org>
References: <1239323335-4684-1-git-send-email-mlevedahl@gmail.com>
 <200904092119.10520.mlevedahl@gmail.com>
 <7vbpr519jq.fsf@gitster.siamese.dyndns.org>
 <200904111301.31250.mlevedahl@gmail.com>
 <20090412072056.GA25837@coredump.intra.peff.net>
 <7v7i1qb7sw.fsf@gitster.siamese.dyndns.org>
 <20090413085622.GC9846@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 13 11:56:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtIte-0000QX-Fr
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 11:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263AbZDMJyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 05:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755241AbZDMJyh
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 05:54:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211AbZDMJyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 05:54:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A37D5AA906;
	Mon, 13 Apr 2009 05:54:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5AB7DAA905; Mon,
 13 Apr 2009 05:54:30 -0400 (EDT)
In-Reply-To: <20090413085622.GC9846@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 13 Apr 2009 04:56:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 17CB8542-2811-11DE-90C5-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116421>

Jeff King <peff@peff.net> writes:

> I think it would be better in the synopsis to split this into two use
> cases:
>
>   git checkout [<branch>]
>   git checkout -b <new_branch> [<start_point>]
>
> And then explain them as separate definitions.

I'd agree it would make it much nicer.

Thanks for a bit of sanity.  I sometimes misplace it when I got grumpy.

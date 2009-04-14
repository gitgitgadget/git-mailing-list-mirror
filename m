From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] docs/checkout: clarify what "non-branch" means
Date: Mon, 13 Apr 2009 21:20:56 -0700
Message-ID: <7v8wm3c1cn.fsf@gitster.siamese.dyndns.org>
References: <20090413110947.GA15647@coredump.intra.peff.net>
 <20090413112104.GE15982@coredump.intra.peff.net>
 <7vmyakh5wc.fsf@gitster.siamese.dyndns.org>
 <200904132340.36191.mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 06:23:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtaAx-0008CB-Ir
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 06:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbZDNEVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 00:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbZDNEVH
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 00:21:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbZDNEVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 00:21:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 07A0CAAF34;
	Tue, 14 Apr 2009 00:21:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B1C17AAF31; Tue,
 14 Apr 2009 00:20:58 -0400 (EDT)
In-Reply-To: <200904132340.36191.mlevedahl@gmail.com> (Mark Levedahl's
 message of "Mon, 13 Apr 2009 23:40:35 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AA538870-28AB-11DE-B3A2-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116510>

Mark Levedahl <mlevedahl@gmail.com> writes:

> I think the question being posed is: Would unifying branch names across all 
> git commands (i.e., always accepting refs/heads/master as naming branch 
> master, and accepting master when that is unambiguous) sufficiently benefit 
> new users...

My knee-jerk reaction is that what you are saying is backwards.

When do new people even need to know about refs/heads vs refs/tags with
modern Porcelain command set?

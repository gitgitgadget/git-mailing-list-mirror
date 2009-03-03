From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH] Push to create
Date: Mon, 02 Mar 2009 23:55:51 -0800
Message-ID: <7vy6vnf3aw.fsf@gitster.siamese.dyndns.org>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com>
 <1235865822-14625-2-git-send-email-gitster@pobox.com>
 <1235865822-14625-3-git-send-email-gitster@pobox.com>
 <20090301031609.GA30384@coredump.intra.peff.net>
 <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
 <20090301100039.GD4146@coredump.intra.peff.net>
 <20090301170436.GA14365@spearce.org>
 <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
 <20090303070937.GB30609@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePVK-0008U4-7j
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbZCCH4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 02:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbZCCH4B
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:56:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbZCCH4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 02:56:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B66CA121C;
	Tue,  3 Mar 2009 02:55:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 08EB2121B; Tue, 
 3 Mar 2009 02:55:52 -0500 (EST)
In-Reply-To: <20090303070937.GB30609@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 3 Mar 2009 02:09:37 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BAD9AC3C-07C8-11DE-A6D2-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112017>

Jeff King <peff@peff.net> writes:

> If you are going to limit it in that way, wouldn't it be better to do it
> entirely client-side? As in, "git push --create remote" will literally
> do:
>
>     ssh remote_host "mkdir -p remote_dir && cd remote_dir && git init --bare"
>
> ? Then you don't have to care about whether the remote side is recent
> enough to support this, and there are no potential security issues; git
> is merely saving you from typing the commands you could have done
> yourself.

As with the previous "git init --remote" patch, my design constraints
includes keeping the door open for "git shell" users to optionally allow
this mode of operation.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git remote update: Report error for non-existing
 groups
Date: Wed, 08 Apr 2009 11:48:49 -0700
Message-ID: <7v1vs3nfqm.fsf@gitster.siamese.dyndns.org>
References: <1239025262-16960-1-git-send-email-finnag@pvv.org>
 <1239025262-16960-2-git-send-email-finnag@pvv.org>
 <7vprfnubyi.fsf@gitster.siamese.dyndns.org> <20090408080738.GA24386@pvv.org>
 <7vy6ubo8tn.fsf@gitster.siamese.dyndns.org>
 <20090408170844.GB28069@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:50:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrcrA-00069s-EQ
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 20:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764940AbZDHSs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 14:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758355AbZDHSs6
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 14:48:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757436AbZDHSs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 14:48:57 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 58924A816B;
	Wed,  8 Apr 2009 14:48:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BBDB1A8169; Wed,
  8 Apr 2009 14:48:50 -0400 (EDT)
In-Reply-To: <20090408170844.GB28069@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 8 Apr 2009 13:08:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E956251A-246D-11DE-B55C-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116109>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 08, 2009 at 01:20:36AM -0700, Junio C Hamano wrote:
>
>> I don't know what users want to see when they say "default" explicitly
>> without having an explicit configuration.  Should it do the same thing as
>> "git remote update"?
>
> I'm not sure we have a choice anymore; is it worth breaking
> compatibility to "fix" something that doesn't actually seem to be
> harming anyone?

Nope.  I do not use the "remote update" myself to begin with, and I
somehow suspect that the reason it does not seem to be harming anyone is
because nobody sane uses these "remote groups".

Anyway, I took the patch as-is already.

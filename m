From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sat, 30 Aug 2008 13:20:13 -0700
Message-ID: <7v3akmgsqq.fsf@gitster.siamese.dyndns.org>
References: <20080830173947.GF7185@schiele.dyndns.org>
 <20080830180022.GA14552@coredump.intra.peff.net>
 <7vwshygyy9.fsf@gitster.siamese.dyndns.org>
 <20080830183413.GG7185@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Lea Wiemann <lewiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:21:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZWwr-0004SM-JQ
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 22:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbYH3UUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbYH3UUX
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:20:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbYH3UUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:20:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8749D6D667;
	Sat, 30 Aug 2008 16:20:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 58DBC6D665; Sat, 30 Aug 2008 16:20:15 -0400 (EDT)
In-Reply-To: <20080830183413.GG7185@schiele.dyndns.org> (Robert Schiele's
 message of "Sat, 30 Aug 2008 20:34:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 12220AA4-76D1-11DD-B262-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94416>

Robert Schiele <rschiele@gmail.com> writes:

> On Sat, Aug 30, 2008 at 11:06:06AM -0700, Junio C Hamano wrote:
>> I didn't try either but I think you are right.  And I agree we should say
>> we rely on 5.6 or newer.
>
> If we don't change it we need to rely on 5.8 or newer as my initial patch
> suggested.

I think it should be as simple as Jeff's patch, and I think it is
moderately preferable to make sure the core part runs with earlier version
than punting.

I however do not have 5.6 (or 5.6.1) installation handy, so I cannot test
to make sure that Jeff's patch is the only necessary fix to the "add -i".

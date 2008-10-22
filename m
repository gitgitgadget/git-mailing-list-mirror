From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Add -n/--no-prompt option to mergetool
Date: Wed, 22 Oct 2008 16:21:21 -0700
Message-ID: <7vr668tdvy.fsf@gitster.siamese.dyndns.org>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org>
 <1224583999-26279-2-git-send-email-charles@hashpling.org>
 <48FDC1CA.2080800@op5.se> <20081021122655.GA29294@hashpling.org>
 <20081022211720.GA23146@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	William Pursell <bill.pursell@gmail.com>,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Oct 23 01:23:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksn2j-0003Vh-4U
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 01:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbYJVXVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 19:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753728AbYJVXVk
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 19:21:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbYJVXVj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 19:21:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 123A48EA6F;
	Wed, 22 Oct 2008 19:21:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AFD1A8EA6C; Wed, 22 Oct 2008 19:21:24 -0400 (EDT)
In-Reply-To: <20081022211720.GA23146@hashpling.org> (Charles Bailey's message
 of "Wed, 22 Oct 2008 22:17:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2CF00136-A090-11DD-B9E4-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98927>

Charles Bailey <charles@hashpling.org> writes:

> I'm pretty keen on this patch, but have no strong opinions on which
> short option is used, so are there any votes against -y?

Between 'n' and 'y', I am in favour of the latter, but at the same time I
have to wonder if there are other commands that would want "Assume yes"
option.  It could be that this single command that prompts for "Is this
Ok" is an oddball and giving it an "interactive" option to trigger the
current behaviour might make things more consistent.  I dunno.

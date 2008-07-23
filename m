From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git add: do not add files from a submodule
Date: Tue, 22 Jul 2008 23:40:20 -0700
Message-ID: <7vhcahgl2j.fsf@gitster.siamese.dyndns.org>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com>
 <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness>
 <alpine.DEB.1.00.0807210256510.3305@eeepc-johanness>
 <alpine.DEB.1.00.0807222230490.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 08:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLY2U-0004ec-Co
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 08:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbYGWGka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 02:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbYGWGka
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 02:40:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbYGWGk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 02:40:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A268F382FE;
	Wed, 23 Jul 2008 02:40:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9C743382FD; Wed, 23 Jul 2008 02:40:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807222230490.8986@racer> (Johannes
 Schindelin's message of "Tue, 22 Jul 2008 22:32:03 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3B5DE0EA-5882-11DD-9F01-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89603>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Do you plan to apply the split-up builtin-add enhancments you did a few 
> nights ago,...

I have a few updates to that one, I'll be sending them out shortly.

Switching branches between revs that have and do not have submodule at a
given path has always been broken.  It is not even a "known breakage",
which is a word used for something that has a sensible design already is
worked out but the implementation does not do so.

If we started the process of diagnosing and fixing these issues earlier,
and had plausible code to address the issue already in 'next' before the
current -rc cycle started, the topic would have been an obvious candidate
for the coming release and I'd further say it would be even worth delaying
the release for a few weeks if it takes more time.  But I have to say it
is too late for 1.6.0 now if we are just noticing and starting the
discussion.  This comment goes to the issue Pierre raised last night as
well.

Nobody prevents us from starting the process to discuss and prepare to put
something in 'next' for 1.6.1 cycle now, though.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow cherry-picking root commits
Date: Sat, 05 Jul 2008 18:05:41 -0700
Message-ID: <7vzlovq0t6.fsf@gitster.siamese.dyndns.org>
References: <1214879914-17866-2-git-send-email-s-beyer@gmx.net>
 <7vbq1f68rh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807031142540.9925@racer>
 <1214879914-17866-1-git-send-email-s-beyer@gmx.net>
 <1214879914-17866-2-git-send-email-s-beyer@gmx.net>
 <7vbq1f68rh.fsf@gitster.siamese.dyndns.org>
 <20080703210950.GC6677@leksak.fem-net>
 <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness>
 <20080704003857.GG6677@leksak.fem-net>
 <alpine.DEB.1.00.0807040252490.2849@eeepc-johanness>
 <20080704015326.GI6677@leksak.fem-net>
 <alpine.DEB.1.00.0807041617320.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 03:07:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFIiN-0006fI-Tc
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 03:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbYGFBF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 21:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbYGFBF6
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 21:05:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbYGFBF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 21:05:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C651C19D60;
	Sat,  5 Jul 2008 21:05:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2C94619B5E; Sat,  5 Jul 2008 21:05:50 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807041617320.9925@racer> (Johannes
 Schindelin's message of "Fri, 4 Jul 2008 16:19:52 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0684FBC-4AF7-11DD-B9FB-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87480>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> There is no good reason why cherry-picking root commits should not be 
> allowed.

Hmm, does "cherry-pick a root commit" even have a well defined semantics,
other than "if there is no overlap in files just add the files in"?  I
have a feeling that it is more likely to be a user error, a sign that the
user mistyped the name of the commit to pick.

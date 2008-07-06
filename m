From: Junio C Hamano <gitster@pobox.com>
Subject: Re: About -X<option>
Date: Sat, 05 Jul 2008 21:57:36 -0700
Message-ID: <7vmykvpq2n.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807051454060.3334@eeepc-johanness>
 <20080705133245.GH4729@genesis.frugalware.org>
 <AB745D70-D23A-4742-A5B3-DC1B6CAD9C30@ai.rug.nl>
 <7v63rktekf.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807060342550.3557@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <frimmirf@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 06:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFMKm-00079H-1B
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 06:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbYGFE5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 00:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbYGFE5v
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 00:57:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58156 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbYGFE5u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 00:57:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A2241AEA8;
	Sun,  6 Jul 2008 00:57:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D9CEE1AEA6; Sun,  6 Jul 2008 00:57:44 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807060342550.3557@eeepc-johanness> (Johannes
 Schindelin's message of "Sun, 6 Jul 2008 03:44:03 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 150DD94E-4B18-11DD-B4A4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87497>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Isn't that obvious?  -X looks like a short option, but the rest of that 
> string does not consist of aggregated short options.

Ah, I see.  Then the issue is not about "not easy to code" but about "not
being consistent".  We should care much more deeply about the latter.

We can change it to "--X<option>[=<value>]" and "-X option[=<value>]"; the
topic is still young, not even documented properly IIRC, and is not
scheduled for 'master' any time soon yet.

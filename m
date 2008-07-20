From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: doc restructuring
Date: Sun, 20 Jul 2008 01:14:23 -0700
Message-ID: <7vk5fhc6qo.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <48806D03.30603@fastmail.fm>
 <alpine.DEB.1.00.0807190314010.3064@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 10:15:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKU4s-0000mO-El
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 10:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbYGTIOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 04:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYGTIOf
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 04:14:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbYGTIOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 04:14:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D0162F119;
	Sun, 20 Jul 2008 04:14:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A34ED2F0F8; Sun, 20 Jul 2008 04:14:26 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807190314010.3064@eeepc-johanness> (Johannes
 Schindelin's message of "Sat, 19 Jul 2008 03:19:25 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E0A225E4-5633-11DD-A802-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89173>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So what I really would like is this: leave the plumbing pages as they are, 
> but enhance those pages that users (especially new ones) are likely to see 
> most often.

Regarding the original "do we want to ever teach plumbing to new users?"
issue, I suspect that, with sufficient enhancement to Porcelain, we might
be able to reach a point where end users can work without ever touching a
single plumbing command at all.

	Side note, that was why I suggested us to first think about use
	cases in our every day work that we still need to resort to the
	plumbing, so that we can identify what that enhancement would
	consist of.

When we reach that point, we might want to restructure the documentation
into two volumes.  One volume for end-users who exclusively use the stock
git Porcelain, and another that describes plumbing commands for Porcelain
writers.

Perhaps move the plumbing documentation to section 3; just like Perl has
DBI.3pm and friends there, /usr/share/man/man3/git-cat-file.3git will
describe what scripts can do with the command.

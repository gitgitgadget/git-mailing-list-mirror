From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Sun, 29 Jun 2008 13:36:23 -0700
Message-ID: <7vprq07zco.fsf@gitster.siamese.dyndns.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl>
 <alpine.DEB.1.00.0806271353350.9925@racer>
 <alpine.LNX.1.00.0806271149580.19665@iabervon.org>
 <7vvdzuo61b.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD3eM-0006j6-SN
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 22:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817AbYF2Uge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 16:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756485AbYF2Uge
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 16:36:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbYF2Ugd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 16:36:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A69E8D910;
	Sun, 29 Jun 2008 16:36:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E9137D90F; Sun, 29 Jun 2008 16:36:27 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0806291359330.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 29 Jun 2008 14:31:56 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F5B5E56-461B-11DD-A26B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86832>

Daniel Barkalow <barkalow@iabervon.org> writes:

> There's no need to use the environment variable to direct the generation 
> of the config file in the C version of clone, and having it not defined 
> means that global and per-user configuration is available. This is 
> necessary for the fetching portion, and could be useful someday for the 
> init portion as well. It is unlikely that the user would want the 
> repository's configuration in some non-default location, but no less 
> likely than with any other git command besides "git config".
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

Thanks, will queue together with the earlier [2/2] from Dscho.

Can we have updates to the testsuite as well?  We would probably have to
fudge $HOME and have some entries in $HOME/.gitconfig to simulate the
situation that triggered the original discussion.

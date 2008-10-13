From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Mon, 13 Oct 2008 10:33:43 -0700
Message-ID: <7vhc7g9z7s.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081012183855.GA5255@spearce.org>
 <alpine.DEB.1.00.0810131057150.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vskr0bnlk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810131611470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:37:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpRLg-0006iF-4F
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 19:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbYJMRfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 13:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756475AbYJMRfk
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 13:35:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310AbYJMRfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 13:35:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A95126E480;
	Mon, 13 Oct 2008 13:35:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E52E66E44A; Mon, 13 Oct 2008 13:33:45 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0810131611470.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Mon, 13 Oct 2008 18:09:21 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59A9B9FA-994D-11DD-8B45-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98128>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> - all the editors that this guy tested keep the hard links, so it was 
>   kinda hard to understand why Git insists on behaving differently,
>
> - if the user asked for hard links, it is not Git's place to question that 
>   decision,

These are non-arguments, when you are asked to give rationale for adding
capability to "ask for hard links" to begin with.

IOW, the question was why git should support tracked contents being
hardlinked to something else.

[jc: Sorry for dropping Shawn from CC: list.  pobox.com seems to complain
on his address for some reason.  Here are msmtp log for an identical
message with and without him on the recipient list.

Oct 13 10:23:57 host=sasl.smtp.pobox.com tls=on auth=on user=junio@pobox.com from=junio@pobox.com recipients=Johannes.Schindelin@gmx.de,barkalow@iabervon.org,git@vger.kernel.org,spearce@spearce.org,gitster@pobox.com smtpstatus=451 smtpmsg='451 4.3.5 Server configuration problem' errormsg='recipient address spearce@spearce.org not accepted by the server' exitcode=EX_DATAERR
Oct 13 10:31:26 host=sasl.smtp.pobox.com tls=on auth=on user=junio@pobox.com from=junio@pobox.com recipients=Johannes.Schindelin@gmx.de,barkalow@iabervon.org,git@vger.kernel.org,gitster@pobox.com mailsize=2283 exitcode=EX_OK
]

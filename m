From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: [FYI][PATCH] Customizing the WinGit installer
Date: Wed, 08 Oct 2008 00:38:42 -0700
Message-ID: <7vd4ibr0xp.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081006141840.GO10360@machine.or.cz>
 <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <m3zllhpvby.fsf@localhost.localdomain>
 <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org>
 <alpine.DEB.1.00.0810061959280.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LFD.2.00.0810061246460.3208@nehalem.linux-foundation.org>
 <20081007015336.GU21650@dpotapov.dyndns.org>
 <alpine.LFD.2.00.0810061909260.3208@nehalem.linux-foundation.org>
 <20081007092819.GW10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Oct 08 09:40:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnTeV-0007iU-1J
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 09:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbYJHHi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 03:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbYJHHi7
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 03:38:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbYJHHi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 03:38:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BDAF46C3F1;
	Wed,  8 Oct 2008 03:38:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 30A126C3F0; Wed,  8 Oct 2008 03:38:44 -0400 (EDT)
In-Reply-To: <20081007092819.GW10360@machine.or.cz> (Petr Baudis's message of
 "Tue, 7 Oct 2008 11:28:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 29FE16AA-950C-11DD-A546-C355E785EAEE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97783>

Petr Baudis <pasky@suse.cz> writes:

> Note that as mentioned in the original mail, my patch was not meant
> for application upstream, just as an example for others who would like
> to customize the Git installer for a particular environment. We wanted
> to make Git installation/usage as simple as possible, reducing any
> unnecessary steps we could - and this was an easy one.

I do not personally think showing the license is necessary in the
installer, but unlike the earlier one that refused to proceed until the
user says "I Accept" (which was just plain silly), I think the current one
is Ok.

The details are entirely up to people who have actually been involved in
msysgit packaging work, but it may be possible to package an installer
that can be used for installing multiple machines with minimum
interaction, and make the process of extracting that installer show
notices on licensing and legalese.

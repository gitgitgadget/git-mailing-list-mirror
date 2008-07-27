From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Sun, 27 Jul 2008 12:46:42 -0700
Message-ID: <7v1w1f155p.fsf@gitster.siamese.dyndns.org>
References: <20080722193901.GA5113@blimp.local>
 <alpine.DEB.1.00.0807222115440.8986@racer>
 <20080722203128.GB5113@blimp.local>
 <7vr69lihkt.fsf@gitster.siamese.dyndns.org>
 <20080723164614.GB5283@blimp.local>
 <alpine.DEB.1.00.0807231757550.8986@racer>
 <20080723191647.GF5283@blimp.local>
 <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org>
 <20080725055547.GA3699@blimp.local>
 <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness>
 <20080726153802.GA16868@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 21:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNCDe-0002cE-UD
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 21:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757646AbYG0Tqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 15:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757675AbYG0Tqu
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 15:46:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64268 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757642AbYG0Tqu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 15:46:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BE1E03E710;
	Sun, 27 Jul 2008 15:46:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2C3D33E70E; Sun, 27 Jul 2008 15:46:44 -0400 (EDT)
In-Reply-To: <20080726153802.GA16868@blimp.local> (Alex Riesen's message of
 "Sat, 26 Jul 2008 17:38:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C0F98F3E-5C14-11DD-9189-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90362>

Alex Riesen <raa.lkml@gmail.com> writes:

> because there are situations where it produces too much false
> positives. Like when file system crawlers keep changing it when
> scanning and using the ctime for marking scanned files.

This justification is good and I am very inclined to advocate for its
inclusion in 1.6.0, but any new configuration needs to be in the
documentation.

It appears there is "gui.trustmtime"; shouldn't this be called
"core.trustctime" or something?

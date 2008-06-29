From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] Add strbuf_vaddf(), use it in strbuf_addf(), and
 add strbuf_initf()
Date: Sun, 29 Jun 2008 13:24:14 -0700
Message-ID: <7vvdzs7zwx.fsf@gitster.siamese.dyndns.org>
References: <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org> <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org> <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org> <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org> <cover.1214581610.git.vmiklos@frugalware.org> <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org> <7vk5gal3my.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806281832510.9925@racer> <7vskuwek9w.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806291436520.9925@racer> <20080629201757.GA27370@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:25:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD3Sk-0002sR-3D
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 22:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023AbYF2UYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 16:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755783AbYF2UYe
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 16:24:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684AbYF2UYd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 16:24:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3781FD815;
	Sun, 29 Jun 2008 16:24:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6FC8CD80B; Sun, 29 Jun 2008 16:24:24 -0400 (EDT)
In-Reply-To: <20080629201757.GA27370@steel.home> (Alex Riesen's message of
 "Sun, 29 Jun 2008 22:17:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 61EEB9D0-4619-11DD-A26B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86829>

Alex Riesen <raa.lkml@gmail.com> writes:

> Johannes Schindelin, Sun, Jun 29, 2008 15:40:57 +0200:
>> On Sun, 29 Jun 2008, Junio C Hamano wrote:
>> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > 
>> > > Anyway, I'm fine with having them only in my personal fork.
>> > 
>> > It will cost you some "trust point" next time you try to sneak something
>> > in as a part of a largely unrelated topic.  Please don't.
>> 
>> Fine.  Fine!
>
> See the positive side: you just won a "please review me carefully"
> point. These have no negative side effects, usually.

Heh, he hasn't _yet_.  I said "next time" didn't I?

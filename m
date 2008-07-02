From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Wed, 02 Jul 2008 11:27:52 -0700
Message-ID: <7viqvob0pj.fsf@gitster.siamese.dyndns.org>
References: <20080701101114.GA6379@sigill.intra.peff.net>
 <1214912674-9443-1-git-send-email-trast@student.ethz.ch>
 <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org>
 <20080702080200.GA21367@sigill.intra.peff.net>
 <7vd4lwemja.fsf@gitster.siamese.dyndns.org>
 <20080702083214.GA22301@sigill.intra.peff.net>
 <alpine.DEB.1.00.0807021412300.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 02 20:29:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE74l-0002YB-HI
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 20:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbYGBS2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 14:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbYGBS2J
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 14:28:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbYGBS2I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 14:28:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 80DA22BA0E;
	Wed,  2 Jul 2008 14:28:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C31B62BA0C; Wed,  2 Jul 2008 14:27:58 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807021412300.9925@racer> (Johannes
 Schindelin's message of "Wed, 2 Jul 2008 14:13:53 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9DF7618C-4864-11DD-B897-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87173>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I wonder why bother trying to import things when you do not need them to 
> begin with!  I mean, it is _obvious_ that in this case, we want .git/ to 
> be writable _anyway_, so why not stick with a fixed name in that?

Good suggestion -- I love that simplicity.  Thomas?

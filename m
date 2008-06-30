From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Only use GIT_CONFIG in "git config", not other programs
Date: Mon, 30 Jun 2008 00:57:54 -0700
Message-ID: <7vskuv1hj1.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0806300328380.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 09:59:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDEI0-00063e-Jk
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 09:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbYF3H6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 03:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754470AbYF3H6G
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 03:58:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbYF3H6F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 03:58:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E8EA941E2;
	Mon, 30 Jun 2008 03:58:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5211541E1; Mon, 30 Jun 2008 03:57:56 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0806300328380.19665@iabervon.org> (Daniel
 Barkalow's message of "Mon, 30 Jun 2008 03:37:47 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 43434238-467A-11DD-B974-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86891>

Hmm, I actually think this is a good thing to do in the sense that it
vastly simplifies the user experience ;-).  Two less things to explain.

Care to write up a snippet for 1.6.0 release notes, as this is quite a
large user visible backward incompatible change, even though it would be
an improvement?

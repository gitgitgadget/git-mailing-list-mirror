From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone --mirror: avoid storing repeated tags
Date: Thu, 07 Aug 2008 23:41:13 -0700
Message-ID: <7vzlnof1py.fsf@gitster.siamese.dyndns.org>
References: <489B9A8B.9050807@cesarb.net>
 <alpine.DEB.1.00.0808080428520.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vej50gl3v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 08:42:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRLg7-0004ox-Dp
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 08:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbYHHGlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 02:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYHHGlT
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 02:41:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbYHHGlS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 02:41:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CA42C593DD;
	Fri,  8 Aug 2008 02:41:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 56469593DC; Fri,  8 Aug 2008 02:41:15 -0400 (EDT)
In-Reply-To: <7vej50gl3v.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 07 Aug 2008 21:57:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01198D5E-6515-11DD-89FA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91625>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for reporting and a quick fix.

By the way, Dscho, do you have comments on recent filter-branch thread and
patches?

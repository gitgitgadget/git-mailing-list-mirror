From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Don't require to be in the repository if we don't
 need to
Date: Sat, 15 Mar 2008 20:55:43 -0700
Message-ID: <7vy78jl3uo.fsf@gitster.siamese.dyndns.org>
References: <1205515770-3424-1-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun Mar 16 04:56:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JajzD-0000Vf-8R
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 04:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbYCPD4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 23:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbYCPD4A
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 23:56:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbYCPDz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 23:55:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 703EA1A06;
	Sat, 15 Mar 2008 23:55:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8921B1A02; Sat, 15 Mar 2008 23:55:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77347>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> Here a small patch series that was based on a user request who wants to
> be able to call git send-email from outside of any repository.
>
> I've done some basic testing but more would of course be welcome.
> Probably no 1.5.5 material anyway.

I am tempted to queue this to 'next', as I think it is a good thing to
do, but there are other users of Git.pm that makes it a bit worrisome.
We'll see if we would want to have it in 'master' before or after 1.5.5
depending on how well it goes.

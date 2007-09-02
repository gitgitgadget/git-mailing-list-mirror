From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git remote add" a mirror mode
Date: Sun, 02 Sep 2007 12:52:36 -0700
Message-ID: <7vk5r8q1yz.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709021245040.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 21:52:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRvV0-0001rf-6F
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 21:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbXIBTwm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 15:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbXIBTwm
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 15:52:42 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbXIBTwl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 15:52:41 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CC9BE12D2FB;
	Sun,  2 Sep 2007 15:53:00 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709021245040.28586@racer.site> (Johannes
	Schindelin's message of "Sun, 2 Sep 2007 12:45:22 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57381>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When using the "--mirror" option to "git remote add", the refs will not
> be stored in the refs/remotes/ namespace, but in refs/heads/.

I suspect people'd prefer "+refs/*:refs/*" for a repo truly
mirroring another.

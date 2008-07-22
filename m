From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-merge-recursive.c: make merge_recursive() static
Date: Tue, 22 Jul 2008 01:47:25 -0700
Message-ID: <7vzloamhk2.fsf@gitster.siamese.dyndns.org>
References: <20080720192127.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.0807201403070.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 10:48:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLDXv-0000Da-6l
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 10:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYGVIre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 04:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbYGVIre
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 04:47:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbYGVIrd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 04:47:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BCA7B342C3;
	Tue, 22 Jul 2008 04:47:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 10193342C2; Tue, 22 Jul 2008 04:47:27 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807201403070.3305@eeepc-johanness> (Johannes
 Schindelin's message of "Sun, 20 Jul 2008 14:03:56 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D280006A-57CA-11DD-9296-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89472>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course, we could apply this patch now, and revert it later, increasing 
> your commit count in the process :-)

Heh, don't tempt people, especially when we would have an interesting
set of tools for statistics just around the corner ;-)

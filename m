From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] builtin-remote: teach show to display remote HEAD
Date: Thu, 12 Feb 2009 13:24:48 -0800
Message-ID: <7vfxijjqlb.fsf@gitster.siamese.dyndns.org>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>
 <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>
 <1234332083-45147-3-git-send-email-jaysoffian@gmail.com>
 <20090212002612.GC30231@coredump.intra.peff.net>
 <76718490902111748j58f80591ma149f8ec9fb8b352@mail.gmail.com>
 <alpine.LNX.1.00.0902121519160.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, gitster@pobox.com
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:26:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXj4o-0008EA-7p
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbZBLVZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbZBLVZB
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:25:01 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZBLVZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:25:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E837699092;
	Thu, 12 Feb 2009 16:24:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3694699090; Thu,
 12 Feb 2009 16:24:49 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0902121519160.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 12 Feb 2009 15:27:13 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 989D0992-F94B-11DD-BF2B-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109661>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I have the vague memory, as well, that there's some way for a transport to 
> report that it actually knows that HEAD is a symref to something in 
> particular, and so git shouldn't guess.

I think you are thinking about:

    http://thread.gmane.org/gmane.comp.version-control.git/102039

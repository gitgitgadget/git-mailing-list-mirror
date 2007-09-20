From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add git-rev-list --invert-match
Date: Thu, 20 Sep 2007 14:49:14 -0700
Message-ID: <7vtzppj9d1.fsf@gitster.siamese.dyndns.org>
References: <20070919202615.GK3076@jukie.net>
	<Pine.LNX.4.64.0709201132381.28395@racer.site>
	<20070920123849.GD12076@jukie.net>
	<Pine.LNX.4.64.0709201403540.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bart Trojanowski <bart@jukie.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYTtl-0005Wp-2M
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 23:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbXITVtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 17:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbXITVtU
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 17:49:20 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbXITVtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 17:49:19 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C83C1138D5F;
	Thu, 20 Sep 2007 17:49:37 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709201403540.28395@racer.site> (Johannes
	Schindelin's message of "Thu, 20 Sep 2007 14:12:54 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58810>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Further, it probably makes sense to have the option to say _both_: "Find 
> me a commit that contains Bart in one line, but not Simpson, and that 
> does not contain the word "Sverdoolaege" at all."

Yeah.  And I think we would also want to have that at the
underlying "grep" layer wouldn't we?

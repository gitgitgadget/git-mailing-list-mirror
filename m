From: Junio C Hamano <gitster@pobox.com>
Subject: Re: parallel make problem with git
Date: Wed, 29 Aug 2007 23:46:04 -0700
Message-ID: <7v7inda5ar.fsf@gitster.siamese.dyndns.org>
References: <20070830063810.GD16312@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Aug 30 08:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQdnZ-0006ff-IA
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 08:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbXH3GqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 02:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbXH3GqJ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 02:46:09 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbXH3GqI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 02:46:08 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A309129376;
	Thu, 30 Aug 2007 02:46:27 -0400 (EDT)
In-Reply-To: <20070830063810.GD16312@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 30 Aug 2007 09:38:10 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57005>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>     LINK test-chmtime
> gcc: test-chmtime.o: No such file or directory
> make: *** [test-chmtime] Error 1
> make: *** Waiting for unfinished jobs....
>
> Any ideas?

Some missing dependencies, apparently.

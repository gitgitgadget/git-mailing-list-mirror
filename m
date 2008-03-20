From: Junio C Hamano <gitster@pobox.com>
Subject: Re: auto gc again
Date: Thu, 20 Mar 2008 00:55:51 -0700
Message-ID: <7vhcf1ygl4.fsf@gitster.siamese.dyndns.org>
References: <20080318180118.GC17940@kernel.dk>
 <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org>
 <20080318181948.GH17940@kernel.dk>
 <alpine.LFD.1.00.0803191629240.2947@xanadu.home>
 <20080319211733.GD17940@kernel.dk>
 <alpine.LFD.1.00.0803191856290.2947@xanadu.home>
 <20080320074057.GH17940@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 08:56:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcFdq-0006es-BP
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 08:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYCTH4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 03:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbYCTH4J
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 03:56:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbYCTH4I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 03:56:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 009411FCD;
	Thu, 20 Mar 2008 03:56:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4C2861FCB; Thu, 20 Mar 2008 03:56:00 -0400 (EDT)
In-Reply-To: <20080320074057.GH17940@kernel.dk> (Jens Axboe's message of
 "Thu, 20 Mar 2008 08:40:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77642>

Jens Axboe <jens.axboe@oracle.com> writes:

> gc.auto covering everything is good enough for me, GIT_GC_AUTO
> environment variable would be better because of the way that I work. But
> I can get by knowing that the gc.auto thing will at least only bite me
> once per tree. And perhaps just wrap git clone in one of my scripts
> that'll then do the gc.auto thing automatically.

You missed --global part of the suggestion, perhaps?

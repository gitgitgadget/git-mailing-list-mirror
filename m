From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rerere.txt: Mention rr-cache directory
Date: Tue, 08 Jul 2008 18:09:47 -0700
Message-ID: <7vk5fvq2w4.fsf@gitster.siamese.dyndns.org>
References: <1215562653-5043-1-git-send-email-s-beyer@gmx.net>
 <alpine.DEB.1.00.0807090225050.5277@eeepc-johanness>
 <alpine.DEB.1.00.0807090230560.5277@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 03:10:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGOCv-00008O-Qn
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 03:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbYGIBJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 21:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbYGIBJ6
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 21:09:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbYGIBJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 21:09:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA80216C71;
	Tue,  8 Jul 2008 21:09:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0DF3516C6F; Tue,  8 Jul 2008 21:09:50 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807090230560.5277@eeepc-johanness> (Johannes
 Schindelin's message of "Wed, 9 Jul 2008 02:38:15 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BEAB61E6-4D53-11DD-AE66-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87823>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course, this only holds true when the config is read, i.e. when 
> setup_rerere() was called in time.  Which is the case when you call 
> rerere() (as is done both from cmd_rerere() as well as cmd_commit()).
>
> Of course, I haven't tested it.  Other than running the test script, that 
> is.
>
> So care to elaborate what is going wrong?

Very interesting question indeed.

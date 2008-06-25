From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Wed, 25 Jun 2008 13:09:16 -0700
Message-ID: <7vprq5z383.fsf@gitster.siamese.dyndns.org>
References: <20080624222105.GA24549@dervierte>
 <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com>
 <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com>
 <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net>
 <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu>
 <7v63rx2zwf.fsf@gitster.siamese.dyndns.org> <20080625195003.GB15077@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:10:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbK1-0004K8-NW
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444AbYFYUJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752982AbYFYUJg
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:09:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYFYUJf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:09:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EDB6C23FD;
	Wed, 25 Jun 2008 16:09:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 10AD223F8; Wed, 25 Jun 2008 16:09:23 -0400 (EDT)
In-Reply-To: <20080625195003.GB15077@mit.edu> (Theodore Tso's message of
 "Wed, 25 Jun 2008 15:50:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A0E122A6-42F2-11DD-A48B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86335>

Theodore Tso <tytso@mit.edu> writes:

> On Wed, Jun 25, 2008 at 10:22:08AM -0700, Junio C Hamano wrote:
>> Isn't that this?
>> 
>>         #!/bin/sh
>>         exec git checkout HEAD -- "$@"
>
> Well, I think you really want this to handle filenames with spaces:

Sorry, I do not understand that remark.  Does "$@" corrupt embedded spaces
in its parameters?

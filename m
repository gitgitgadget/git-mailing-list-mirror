From: Junio C Hamano <gitster@pobox.com>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 21:49:10 -0700
Message-ID: <7v7ifyyp89.fsf@gitster.siamese.dyndns.org>
References: <20080318180118.GC17940@kernel.dk>
 <7vd4pq2ymo.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191444490.3020@woody.linux-foundation.org>
 <7vod9a1h8e.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191910170.2947@xanadu.home>
 <7vd4pq1el3.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803192228260.2947@xanadu.home>
 <7vfxumyr2r.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803200030020.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <jens.axboe@oracle.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 05:50:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcCj9-00009t-S5
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 05:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbYCTEt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 00:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbYCTEt2
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 00:49:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbYCTEt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 00:49:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D3070192F;
	Thu, 20 Mar 2008 00:49:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C9D30192E; Thu, 20 Mar 2008 00:49:19 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803200030020.2947@xanadu.home> (Nicolas
 Pitre's message of "Thu, 20 Mar 2008 00:40:20 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77627>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 19 Mar 2008, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > So you have 17.1 seconds for a single pack vs 18.4 seconds for 66 packs.
>> >
>> > Compare that to 24.9s without that patch.
>> 
>> Very interesting --- why should it affect a single pack case at all?
>
> It is not:
>
> Single pack = 17.1s
> 66 packs with commit f7c22cc6 = 18.4s
> 66 packs without commit f7c22cc6 = 24.9s
> ...
>> But I am still puzzled...
>
> Please tell me why if this is still the case.

Not anymore.  Your "It is not" above cleared things for me.  Somehow I
misread "with patch single pack is 17.1s and even with 66 packs it is only
18.4s, compare these great numbers with horrible 24.9s with single pack
without the patch".

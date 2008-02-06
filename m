From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prune: heed --expire for stale packs, add a test
Date: Wed, 06 Feb 2008 12:30:06 -0800
Message-ID: <7vfxw5x1yp.fsf@gitster.siamese.dyndns.org>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
	<alpine.LFD.1.00.0802051357420.2732@xanadu.home>
	<alpine.LSU.1.00.0802052005200.8543@racer.site>
	<alpine.LFD.1.00.0802051512370.2732@xanadu.home>
	<7v7ihi64xm.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802060910340.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Steven Tweed <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:31:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqvP-0003Eh-He
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759406AbYBFUad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759347AbYBFUac
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:30:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759301AbYBFUab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:30:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E5052E44;
	Wed,  6 Feb 2008 15:30:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 54A5B2E42;
	Wed,  6 Feb 2008 15:30:24 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72845>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 5 Feb 2008, Junio C Hamano wrote:
>
>> They are not "stale packs", but temporary files that wanted to
>> become pack but did not succeed.  Perhaps "stale temporary
>> packs"?
>> 
>> Shouldn't we do something similar to objects/pack/pack-*.temp
>> files and objects/??/*.temp that http walker leaves?
>
> Instead, I think http walker should be made to use the same location and 
> filename pattern for its temporary files as the rest of the code.

I concur.  That's much cleaner.

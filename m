From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in a
 pack file
Date: Wed, 07 Jan 2009 00:16:48 -0800
Message-ID: <7vaba3bken.fsf@gitster.siamese.dyndns.org>
References: <20081209093627.77039a1f@perceptron>
 <1231282320.8870.52.camel@starfruit>
 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
 <1231292360.8870.61.camel@starfruit>
 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
 <1231314099.8870.415.camel@starfruit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 09:18:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKTcL-0000zE-Cm
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 09:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbZAGIRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 03:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbZAGIRA
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 03:17:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbZAGIQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 03:16:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A0F831BFBC;
	Wed,  7 Jan 2009 03:16:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 83B4D1BF75; Wed, 
 7 Jan 2009 03:16:49 -0500 (EST)
In-Reply-To: <1231314099.8870.415.camel@starfruit> (R. Tyler Ballance's
 message of "Tue, 06 Jan 2009 23:41:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D185510-DC93-11DD-8B3B-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104773>

"R. Tyler Ballance" <tyler@slide.com> writes:

> Unfortunately it doesn't, what I did notice was this when I did a `git
> status` in the directory right after untarring:
>         tyler@grapefruit:~/jburgess_main> git status
>         #
>         # ---impressive amount of file names fly by---
>         # ----snip---
> ...
> Basically, somehow Git thinks that *every* file in the repository is
> deleted at this point.

That makes me suspect that your .git/index file is corrupt.

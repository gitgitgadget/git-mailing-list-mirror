From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable)
Date: Sun, 17 Feb 2008 12:45:16 -0800
Message-ID: <7vtzk7xqg3.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <m3d4qvbt40.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 21:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQqOm-0001nY-OK
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 21:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbYBQUpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 15:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbYBQUpe
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 15:45:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbYBQUpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 15:45:33 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 88BC16BA6;
	Sun, 17 Feb 2008 15:45:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 A39A46BA5; Sun, 17 Feb 2008 15:45:25 -0500 (EST)
In-Reply-To: <m3d4qvbt40.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sun, 17 Feb 2008 05:39:26 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74181>

Jakub Narebski <jnareb@gmail.com> writes:

>>   commit: discard index after setting up partial commit
>
> IIRC there was also request for proper solution; this was more a hack.

It is not a hack at all.

The more fundamental improvement was along the lines of what I
suggested soon after Kristian's initial round was posted, but
what the current code does is not wrong nor hack.  It is about a
partial commit after all and is not performance critical either.

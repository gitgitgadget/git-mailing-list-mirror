From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] diff --relative: output paths as relative to the
 current subdirectory
Date: Tue, 12 Feb 2008 16:59:16 -0800
Message-ID: <7vtzkdzn6j.fsf@gitster.siamese.dyndns.org>
References: <7vzlu524n9.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802121531170.2920@woody.linux-foundation.org>
 <7vfxvx211k.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802121550570.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 02:00:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP5z3-0000xS-3Z
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 02:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbYBMA7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 19:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbYBMA7r
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 19:59:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbYBMA7q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 19:59:46 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D21D2C51;
	Tue, 12 Feb 2008 19:59:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 45E1D2C4E; Tue, 12 Feb 2008 19:59:34 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802121550570.2920@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 12 Feb 2008 15:53:06 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73725>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 12 Feb 2008, Junio C Hamano wrote:
>> 
>> Your example is shorter to type as:
>> 
>> 	(cd drivers/scsi && git diff --relative a..b --)
>
> No it isn't. The above doesn't even work for bare
> repositories,...

AHHHHH.  You are right.

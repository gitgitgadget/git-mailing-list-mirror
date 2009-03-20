From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to commit changes if remote repository changed directory
 structure?
Date: Fri, 20 Mar 2009 00:08:51 -0700
Message-ID: <7vljr04qnw.fsf@gitster.siamese.dyndns.org>
References: <22612715.post@talk.nabble.com>
 <20090320060926.GC27008@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: andholt <andholt@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 08:10:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkYsE-00072g-SG
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 08:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbZCTHJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 03:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbZCTHJC
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 03:09:02 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbZCTHJA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 03:09:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AD2A976A2;
	Fri, 20 Mar 2009 03:08:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 133427697; Fri,
 20 Mar 2009 03:08:52 -0400 (EDT)
In-Reply-To: <20090320060926.GC27008@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 20 Mar 2009 02:09:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA672CF0-151D-11DE-A61E-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113905>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 19, 2009 at 06:17:15PM -0700, andholt wrote:
>
>> I have a lot of local changes to add, commit, and push. Right now our
>> directory structure is 1/2/3. Another developer decided to move everything
>> up one level, so used git move to move 3 to 2, and removed 3, so now the
>> level is 1/2. However, locally, all of my changes are in 1/2/3. 
>> 
>> I want to commit my changes and merge them into the new directory structure.
>> How would I go about doing that?
>
> First, commit your changes. Then merge the other developer's changes. :)

We should probably point out to new people that "first commit and then
worry about merges after your changes are safely committed" is always how
people would "go about" anything.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: fix local refs update if already up-to-date
Date: Wed, 05 Nov 2008 14:23:08 -0800
Message-ID: <7v63n1lsmr.fsf@gitster.siamese.dyndns.org>
References: <20081104000745.GA28480@localhost>
 <20081104042643.GA31276@coredump.intra.peff.net>
 <20081104085630.GA22530@localhost>
 <20081105024932.GA20907@coredump.intra.peff.net>
 <20081105202849.GA9484@localhost> <20081105215706.GA32063@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Nov 05 23:24:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxqnw-0005eH-Ry
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 23:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbYKEWXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 17:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbYKEWXd
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 17:23:33 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbYKEWXc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 17:23:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A264797B7;
	Wed,  5 Nov 2008 17:23:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 100C1797B3; Wed,
  5 Nov 2008 17:23:14 -0500 (EST)
In-Reply-To: <20081105215706.GA32063@localhost> (Clemens Buchacher's message
 of "Wed, 5 Nov 2008 22:57:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5DFAAC92-AB88-11DD-816C-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100192>

Clemens Buchacher <drizzd@aon.at> writes:

> On Wed, Nov 05, 2008 at 09:28:49PM +0100, Clemens Buchacher wrote:
>> On Tue, Nov 04, 2008 at 09:49:32PM -0500, Jeff King wrote:
>> [...]
>> > However, I would like to make one additional request.  Since you are
>> > killing off all usage of new_sha1 initial assignment, I think it makes
>> > sense to just get rid of the variable entirely, so it cannot create
>> > confusion later.
>
> Considering that the ref is initialized to the null_sha1, do you think it
> would be Ok to do the following instead?

Yeah, that's pretty much what I munged and committed.

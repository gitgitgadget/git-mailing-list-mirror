From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] for-each-ref: %(object) and %(type) unimplemented
Date: Wed, 25 Jun 2008 12:38:59 -0700
Message-ID: <7v63rx1ezw.fsf@gitster.siamese.dyndns.org>
References: <48625DAD.5040404@gmail.com>
 <20080625160814.GA3321@sigill.intra.peff.net>
 <20080625161433.GA6612@sigill.intra.peff.net>
 <237967ef0806251208u65c17652gc6091da98294f807@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, "Lea Wiemann" <lewiemann@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:40:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBar9-0001wc-Du
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbYFYTjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 15:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbYFYTjS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 15:39:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbYFYTjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 15:39:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D7A051BD8C;
	Wed, 25 Jun 2008 15:39:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E980D1BD86; Wed, 25 Jun 2008 15:39:06 -0400 (EDT)
In-Reply-To: <237967ef0806251208u65c17652gc6091da98294f807@mail.gmail.com>
 (Mikael Magnusson's message of "Wed, 25 Jun 2008 21:08:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 649DE8BE-42EE-11DD-81DB-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86328>

"Mikael Magnusson" <mikachu@gmail.com> writes:

> 2008/6/25 Jeff King <peff@peff.net>:
>> On Wed, Jun 25, 2008 at 12:08:15PM -0400, Jeff King wrote:
>>
>>> Since you seem to be testing for-each-ref, maybe it would make sense to
>>> put together a test script that exercises each of the atoms?
>>
>> Hmm. Actually, there is a test in t6300 that runs with each atom name.
>> Unfortunately, it doesn't bother actually checking the output for
>> sanity, so the fact that these atoms returned the empty string was
>> missed.
>
> The documentation also says "tree" and "parent" should work (which they
> also don't).

The doc does not say any such thing.  A tag object does not have 'parent'
nor 'tree' header fields.

Neither a commit have 'object' nor 'type' header fields and you cannot ask
for them when showing a commit object.

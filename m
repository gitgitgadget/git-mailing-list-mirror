From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] allow user aliases for the --author parameter
Date: Wed, 27 Aug 2008 10:19:09 -0700
Message-ID: <7viqtmqstu.fsf@gitster.siamese.dyndns.org>
References: <g8jbvd$18k$1@ger.gmane.org>
 <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm>
 <20080822165047.GA3339@sigill.intra.peff.net>
 <7vzln492pc.fsf@gitster.siamese.dyndns.org>
 <20080822211902.GA31884@coredump.intra.peff.net>
 <48B3B8B0.4020609@fastmail.fm> <7vsksr1hgt.fsf@gitster.siamese.dyndns.org>
 <20080827001944.GA7347@coredump.intra.peff.net>
 <7v7ia3rnnq.fsf@gitster.siamese.dyndns.org>
 <20080827122954.GA11986@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 19:20:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYOgx-0000fN-PE
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 19:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbYH0RTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 13:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbYH0RTT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 13:19:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbYH0RTT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 13:19:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7CF136A623;
	Wed, 27 Aug 2008 13:19:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 81BB46A620; Wed, 27 Aug 2008 13:19:12 -0400 (EDT)
In-Reply-To: <20080827122954.GA11986@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 27 Aug 2008 08:29:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 46D2F01E-745C-11DD-979F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93902>

Jeff King <peff@peff.net> writes:

> My only complaint is:
>
>> +	strbuf_addf(&buf, "--author=%s", name);
>> +	av[++ac] = "--all";
>> +	av[++ac] = buf.buf;
>> +	av[++ac] = NULL;
>
> I am too lazy to hit "shift", so I would use "-i".

I thought about it after writing the one you saw on the list, but from the
beginning I was planning to do this merely as a demonstration patch that
somebody who is interested in the feature can polish and resubmit with
test and documentation.  I didn't bother adding such frills --- that is
part of "polish and resubmit" cycle.

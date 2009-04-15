From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git cat-file <sha1>" shows usage but should not?
Date: Wed, 15 Apr 2009 10:18:40 -0700
Message-ID: <7vprfdvnrj.fsf@gitster.siamese.dyndns.org>
References: <49E61067.6060802@hartwork.org>
 <20090415165420.GB24528@coredump.intra.peff.net>
 <49E611A5.8090602@hartwork.org>
 <20090415170444.GA24717@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Pipping <webmaster@hartwork.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:20:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8ma-0003JJ-U2
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 19:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbZDORSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 13:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbZDORSr
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 13:18:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbZDORSq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 13:18:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6AF0FFDE0;
	Wed, 15 Apr 2009 13:18:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B0679FDDC; Wed,
 15 Apr 2009 13:18:41 -0400 (EDT)
In-Reply-To: <20090415170444.GA24717@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 15 Apr 2009 13:04:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 79B98A98-29E1-11DE-902D-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116631>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 15, 2009 at 06:56:05PM +0200, Sebastian Pipping wrote:
>
>> Jeff King wrote:
>> > That usage message is misleading. You need to use one of -t, -s, -e, -p,
>> > or <type>. So it should perhaps just be:
>> > 
>> >   git cat-file -t|-s|-e|-p|<type> <sha1>
>> > 
>> > though that looks terribly ugly. Suggestions welcome.
>> 
>> Thanks for making that clear.  How about round or curly brackets?
>
> I think curly makes the most sense for grouping, though I still think it
> is a bit ugly. Patch is below.

Thanks.  Doesn't this remind us of $gmane/72243, by the way?

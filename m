From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3 v3] Add support for external programs for handling
 native fetches
Date: Wed, 05 Aug 2009 13:43:02 -0700
Message-ID: <7v4osm0z6x.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0907310109130.2147@iabervon.org>
 <alpine.DEB.1.00.0908051143000.8306@pacific.mpi-cbg.de>
 <alpine.LNX.2.00.0908051058130.2147@iabervon.org>
 <alpine.DEB.1.00.0908052231461.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:43:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnKQ-0002Xb-B7
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbZHEUnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbZHEUnK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:43:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbZHEUnK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:43:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D22402270A;
	Wed,  5 Aug 2009 16:43:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2E6CA22708; Wed, 
 5 Aug 2009 16:43:04 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908052231461.8306@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed\, 5 Aug 2009 22\:34\:26 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 96C04C18-8200-11DE-BEDB-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124973>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > > +int transport_native_helper_init(struct transport *transport)
>> > > +{
>> > > +	struct helper_data *data = xmalloc(sizeof(*data));
>> > > +	char *eom = strchr(transport->url, ':');
>> > 
>> > "End of message"?
>> 
>> "End of method"; that's the "method" part of a URL.
>
> I'd have called that "protocol".  At least that's what java.net.URL 
> calls it, and I just assume that Sun is very much in love with standards, 
> so I could imagine they picked that term from the appropriate RFC.

In RFC parlance that's called <scheme>.

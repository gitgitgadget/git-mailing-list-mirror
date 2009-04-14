From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3 09/13] send-email: Remove horrible mix of tabs and
 spaces
Date: Mon, 13 Apr 2009 23:19:32 -0700
Message-ID: <7vws9n92q3.fsf@gitster.siamese.dyndns.org>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-10-git-send-email-mfwitten@gmail.com>
 <7vab6ke0ip.fsf@gitster.siamese.dyndns.org>
 <b4087cc50904131549sec5acc4m7201b1411245b95f@mail.gmail.com>
 <49E41F99.6010409@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 14 08:21:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltc1T-0006um-Tc
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 08:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbZDNGTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 02:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbZDNGTm
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 02:19:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63560 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212AbZDNGTl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 02:19:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EC58CAA622;
	Tue, 14 Apr 2009 02:19:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 23DDEAA621; Tue,
 14 Apr 2009 02:19:33 -0400 (EDT)
In-Reply-To: <49E41F99.6010409@op5.se> (Andreas Ericsson's message of "Tue,
 14 Apr 2009 07:31:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3BC3201C-28BC-11DE-BD3E-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116519>

Andreas Ericsson <ae@op5.se> writes:

> Using tabs to align stuff to indentation level and spaces to align
> line continuation is the only possible way to let users choose
> whichever indentation depth they want while preserving the continuation
> alignment.

Sure, it will look aligned with whatever width of HT ">":

	>>if (this is a looong
        >>....expression that is alighed) {
        >>>statement1;
        >>>statement2;
        >>}

but it is *only true* if your SP "." and everything else is of the same
width.

People seem to repeat that without realizing what they are saying, but I
find the assumption the argument is based on quite bogus.  Why do people
think it is only sane to assume flexible HT width but still monospaced
font whose SP, l and w are all of the same width?

You either forget about the alignment (there is no such thing---suck it
up), or use time honored HT=8 and monospace convention.

And this project uses the latter.

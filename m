From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Mon, 23 Mar 2009 19:08:22 -0700
Message-ID: <7vwsaf4qqx.fsf@gitster.siamese.dyndns.org>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
 <20090323064242.GB1119@coredump.intra.peff.net>
 <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com>
 <49C7A8AF.9080500@drmicha.warpmail.net>
 <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 03:10:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llw5l-000321-KU
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 03:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbZCXCIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 22:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbZCXCIg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 22:08:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbZCXCIf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 22:08:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0542F8667;
	Mon, 23 Mar 2009 22:08:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 04DAB8665; Mon,
 23 Mar 2009 22:08:25 -0400 (EDT)
In-Reply-To: <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com>
 (Felipe Contreras's message of "Tue, 24 Mar 2009 02:21:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD19A934-1818-11DE-8DCB-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114392>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Also, it seems that everything which is not black is blue, except for
>> terms, which are green and slanted. I don't think that looks nice
>> together. How about slanted blue?
>
> What's wrong with having 2 colors?

I personally also do not like pages that are too colorful.  If you can
convey the same information with smaller number of colors, please try to
do so.  And remember that some people are colour-challenged.

By the way, are you using a font that is a bit smaller than the body text
to render the examples?  I find it harder to read.

I thought that browsers typically have user control to let you set the
standard font size and choice independently for proportional, serif, sans
and mono, and people who want to see typewriter face in smaller font would
already have set their browser to do so (I don't do so myself because I'd
rather want to see them in uniform size).  I haven't checked your CSS, but
if you are doing "monospace smaller than usual", aren't you effectively
(1) doing disservice to people like me, and (2) doing disservice to people
who do want smaller monospace and configured their browser already (the
outcome would be doubly smaller, which may become too small)?

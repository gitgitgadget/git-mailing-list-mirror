From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] cleanups for git-send-email
Date: Wed, 29 Apr 2009 13:23:53 -0700
Message-ID: <7v4ow79pk6.fsf@gitster.siamese.dyndns.org>
References: <20090429194852.0976257034@viridian.itc.Virginia.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com (Junio C Hamano), git@vger.kernel.org
To: wfp5p@viridian.itc.Virginia.EDU (Bill Pemberton)
X-From: git-owner@vger.kernel.org Wed Apr 29 22:24:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzGKl-0000zi-PR
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758699AbZD2UYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756351AbZD2UYB
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:24:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53198 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465AbZD2UYA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 16:24:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 69659AE8FC;
	Wed, 29 Apr 2009 16:23:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 11BB8AE8FB; Wed,
 29 Apr 2009 16:23:54 -0400 (EDT)
In-Reply-To: <20090429194852.0976257034@viridian.itc.Virginia.EDU> (Bill
 Pemberton's message of "Wed, 29 Apr 2009 15:48:51 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ABF4BE54-34FB-11DE-ACF6-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117940>

wfp5p@viridian.itc.Virginia.EDU (Bill Pemberton) writes:

> My changes come directly from the book "Perl Best Practices".  Just as
> ...
> Again, it prevents bugs.  People use "and" vs "&&" as the same thing,
> when they are not.  The have different precedence in perl.
>
> For example, 
>
> next if not $finished || $x < 5;
> next if !$finished || $x < 5;
>
> do not mean the same thing.
> ...
> Again, it prevents potential bugs down the road....

Earlier I did guide the community not to use "more advanced" (aka
"obscure") Perl features so that people not so familiar with Perl can
still tweak scripts without breaking them; the tricks in your patches that
"prevent potential bugs" are in line with that, and that is why I said my
personal taste more or less agrees with your patch already.

But the line between "more advanced and tricky" and "if you are coding in
Perl you should know your language" is not so black and white as you seem
to think.  I'd rather defer that decision to whoever is taking send-email
over.

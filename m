From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add [HOWTO] using merge subtree.
Date: Tue, 08 Jan 2008 19:46:13 -0800
Message-ID: <7vfxx7psoq.fsf@gitster.siamese.dyndns.org>
References: <1199838182-15178-1-git-send-email-vmiklos@frugalware.org>
	<7vwsqjpyqi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 04:47:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCRu2-0001kI-7b
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 04:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbYAIDq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 22:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbYAIDq1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 22:46:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYAIDq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 22:46:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 017223683;
	Tue,  8 Jan 2008 22:46:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 983313681;
	Tue,  8 Jan 2008 22:46:20 -0500 (EST)
In-Reply-To: <7vwsqjpyqi.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 08 Jan 2008 17:35:33 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69951>

Junio C Hamano <gitster@pobox.com> writes:

> Miklos Vajna <vmiklos@frugalware.org> writes:
>
> NAK.  It may be well intentioned, but it lacks too much context
> to be usable as a generic teaching material.
>
>> +Abstract: In this article, Sean demonstrates how one can use the subtree merge
>> + strategy.
>> +Message-ID: <BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
>> +
>> +How to use the subtree merge strategy
>> +=====================================
> 
> Here, before diving to the actual command sequence, you need to
> tell the reader what the objective of the whole exercise is.

Just to avoid discouraging contributors too much, here are
pointers to some other materials in the mailing list archive
that may serve as the basis for the "discussion" section of this
HOWTO.

Side note.  I think an ideal HOWTO should

- describe the objective briefly so that the reader can tell if
  that is relevant to the task at hand;

- describe the procedure;

- mention other possible avenues and discuss pros and cons, so
  that the reader can make an informed decision to employ or not
  to employ the solution.

My complaints were that the original had only the second part.
And this message is to give pointers to possible material for
the third part.


* http://thread.gmane.org/gmane.comp.version-control.git/39443

This was the explanation on the way how the initial git-gui
subtree merge was created.

* http://thread.gmane.org/gmane.comp.version-control.git/39963

The introduction of subtree strategy.  The original cover letter
and the following discussion is rich with discussions on merge
philosophy and pros and cons.

Back then "submodule" was not available, and we would still
avoid it today in git.git, because use of submodule in a
repository would make the repository non-interoperable with any
clients older than 1.5.2 series (that's one pros-and-cons item).

Somewhere in the thread it was also suggested "am -pN" may be
necessary.

* http://thread.gmane.org/gmane.comp.version-control.git/46569/focus=46609

This is a side note -- it turns out that "am -pN" used on the
context of subtree merge is often not necessary, as --3way is a
magic.

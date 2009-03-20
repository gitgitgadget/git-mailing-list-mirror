From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minimum libCurl version for git
Date: Fri, 20 Mar 2009 15:58:33 -0700
Message-ID: <7vtz5ng5t2.fsf@gitster.siamese.dyndns.org>
References: <e2b179460903201059j20e37c1cr7ccfa4b42e45c9d9@mail.gmail.com>
 <7vy6uzg98v.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.10.0903202316170.2600@yvahk2.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>, git list <git@vger.kernel.org>,
	Nick Hengeveld <nickh@reactrix.com>,
	Mike Hommey <mh@glandium.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 00:00:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LknhG-00008d-5s
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 00:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899AbZCTW6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 18:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbZCTW6o
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 18:58:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbZCTW6o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 18:58:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E04388807;
	Fri, 20 Mar 2009 18:58:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0713C8806; Fri,
 20 Mar 2009 18:58:34 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.10.0903202316170.2600@yvahk2.pbagnpgbe.fr> (Daniel
 Stenberg's message of "Fri, 20 Mar 2009 23:31:30 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A83C135C-15A2-11DE-AF17-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114014>

Daniel Stenberg <daniel@haxx.se> writes:

> On Fri, 20 Mar 2009, Junio C Hamano wrote:
>
>> For non-commercial Linux folks I think it should be Ok to assume not
>> too ancient libcurl, but I have no clue on how the table like the
>> above would look like for things like AIX, IRIX, HPUX etc.  ... Oh,
>> and SCO.
>
> The oldest libcurl version I know is still being distributed to and
> therefor used by people is one IBM provides for AIX, and that is 7.9.3
> - dated "Jan 23 2002".

Thanks for the definitive words, Daniel.

Mike, I'd say we declare 7.9.3 as the floor and go from there.  That's
your #3, I think.

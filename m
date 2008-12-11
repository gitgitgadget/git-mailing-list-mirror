From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add support for a pdf version of the user manual
Date: Wed, 10 Dec 2008 16:37:40 -0800
Message-ID: <7v8wqny2az.fsf@gitster.siamese.dyndns.org>
References: <1228949090-22475-1-git-send-email-vmiklos@frugalware.org>
 <ee2a733e0812101606m1c522541j9380b6f5d5dc7fc8@mail.gmail.com>
 <7vd4fzy3il.fsf@gitster.siamese.dyndns.org>
 <ee2a733e0812101620s5fc2ff27p81826a5ff827e154@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 11 01:39:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZa7-0005fN-7i
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbYLKAht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbYLKAhs
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:37:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbYLKAhs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 19:37:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B2091895F;
	Wed, 10 Dec 2008 19:37:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3ACC818952; Wed,
 10 Dec 2008 19:37:41 -0500 (EST)
In-Reply-To: <ee2a733e0812101620s5fc2ff27p81826a5ff827e154@mail.gmail.com>
 (Leo Razoumov's message of "Wed, 10 Dec 2008 19:20:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE5FC25A-C71B-11DD-95DC-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102756>

"Leo Razoumov" <slonik.az@gmail.com> writes:

> On 12/10/08, Junio C Hamano <gitster@pobox.com> wrote:
>> "Leo Razoumov" <slonik.az@gmail.com> writes:
>>
>>  > BTW, for those of us without dblatex, is it possible to have pdf
>>  > manual pregenerated the same way html and man pages are pregenerated
>>  > for official releases in the git repo?
>>
>>
>> Those of us includes myself, so...
>
> Ouch:-) Does it mean that such a useful patch has a low probability of
> being accepted?

As an optional "make" target, as long as it works for people with the
necessary toolchain, I have no problem with the patch, but I would
complain if the usual "make doc" try to run the tool I do not want to run
with my regular build.  I didn't check.

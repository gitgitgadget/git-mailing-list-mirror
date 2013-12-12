From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subtree: My Status
Date: Thu, 12 Dec 2013 11:26:36 -0800
Message-ID: <xmqq61qtuaz7.fsf@gitster.dls.corp.google.com>
References: <87d2tp9j7b.fsf@waller.obbligato.org>
	<567618909.1800335.1366615126779.JavaMail.root@openwide.fr>
	<20131212182439.GM18340@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Rosen <jeremy.rosen@openwide.fr>,
	David Greene <greened@obbligato.org>, git@vger.kernel.org
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Dec 12 20:26:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrBuI-0000gT-92
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 20:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab3LLT0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 14:26:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54150 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab3LLT0l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 14:26:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C44058CC3;
	Thu, 12 Dec 2013 14:26:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cwbpksmmtYwaX0KTHx+CT6rwXcQ=; b=Fspg/9
	5Rq/EI7/QhIQ3PU096Z5O7GBPEBj86diYCiFsBkCvf1RcQ1uX7EW72u8CSKGyG6u
	OHsMhoMkEEBI7j/ezby7scnrYHopNvTx7SfRcP2D0NW8PViVQI+isf0QrnlRkL2E
	QU2X0wjpminbaHDtvx5vqTF0Thb2NlMRwlsoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hJH5829IdC6tzQ+GdDALZjT/m7CfrT0U
	MI+QlA3JTacODxZkclUGfeTCx1YRur8hXOf+ckstj3bJVshNGpkOEF4BNzYT99ej
	xkistc2VYw5FEbv2ptDNRgvOeP4HvjV4sZ+DwJI/V8t2NiNBlyjRLUTGTa4xXg9/
	gfGgHWWDDQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 656F558CC2;
	Thu, 12 Dec 2013 14:26:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F33258CBC;
	Thu, 12 Dec 2013 14:26:39 -0500 (EST)
In-Reply-To: <20131212182439.GM18340@gmail.com> (Adam Spiers's message of
	"Thu, 12 Dec 2013 18:24:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 52FF0606-6363-11E3-BD98-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239240>

Adam Spiers <git@adamspiers.org> writes:

> On Mon, Apr 22, 2013 at 09:18:46AM +0200, Jeremy Rosen wrote:
>> David Green wrote:
>> > Please remember that I don't consider myself a gatekeeper to git
>> > subtree.  In fact I could use some help reviewing and approving
>> > patches.
>> > If anyone thinks a patch looks good, let Junio know.  It's my
>> > responsibility to object to things, not your responsibility to wait
>> > for
>> 
>> I guess it's more or less everybody's responsability to review patches, but
>> it seems to me that for the actual gate-keeping, Junio considers you 
>> in charge of git-subtree... Maybe there is an organisational quirk to sort-
>> out here... Junio ?
>
> I can't see any resolution to this in the mail archives.  What's the
> process for getting subtree patches accepted?

Somebody take the ownership of the area, if David Green who earlier
volunteered to do so and worked on it needs help reviewing, helping
polishing and giving thumbs-up on the patches, perhaps?

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] add --summary option to git-push and git-fetch
Date: Sat, 30 Jan 2010 00:04:25 -0800
Message-ID: <7vd40sxbli.fsf@alter.siamese.dyndns.org>
References: <20100130020548.GA29343@cthulhu>
 <7vsk9oysds.fsf@alter.siamese.dyndns.org> <20100130075129.GA27702@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Jan 30 09:04:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb8K0-0003yv-1V
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 09:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab0A3IEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 03:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522Ab0A3IEj
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 03:04:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab0A3IEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 03:04:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ACF3995029;
	Sat, 30 Jan 2010 03:04:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fwt2DU9QW++DagsGZ1ttOqEQ5A0=; b=vbgns0
	tRK+A+R3FoxJ7UJW0qvM9Rffyy1R0w5G6zNtCWe+dyNJTlQMcGNjFR77VfQOwpCN
	pZ55Hed03h9Tbni7R9m/VRA8RgI8+jKNzhW7CPTbx4GEoBVmfhYcCLQ63SbI7KSY
	ieazDZ5KOeIg6g1auPA5l2/vXT/38ehsRMttE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=orECJcTpegDADmfvI0XmJuSebu94Ydyn
	SpEmpLZGOiwEAocXisnqjF0SqZtEFU1HWCSJkLEr4XgrxTh7YlumJwDOcpHIc881
	s9MlcXaUrUWEkSS4/j6QVZksxqufjrKh4XEOfV+IZocdZ+2iHmyIvDFDLtbPewlu
	MlcT9T2DDKk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AC8795026;
	Sat, 30 Jan 2010 03:04:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62E8495024; Sat, 30 Jan
 2010 03:04:26 -0500 (EST)
In-Reply-To: <20100130075129.GA27702@Knoppix> (Ilari Liusvaara's message of
 "Sat\, 30 Jan 2010 09\:51\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1922BD34-0D76-11DF-9608-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138463>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> Also, what about multiple-URL case? Don't know if there are problems, but it
> seems to be quite rarely tested...

Pushing to more than one deliberately chooses to fork for each remote IIRC
to avoid any funnies.

> [*] OTOH, this is extremely heavily used code, so breakages here will usually
> be pretty visible.

I'd actually like to avoid anybody being hit.

Thanks for a quick response.

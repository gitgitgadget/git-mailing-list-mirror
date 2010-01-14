From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 15:13:35 -0800
Message-ID: <7vvdf4700w.fsf@alter.siamese.dyndns.org>
References: <op.u6g8jnixg402ra@nb-04> <20100113154310.GA7348@Knoppix>
 <op.u6haiiiog402ra@nb-04>
 <be6fef0d1001132121w4e25c7f0j760d71c136012401@mail.gmail.com>
 <20100114070000.GA1528@rm.endoftheinternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Miles Bader <miles@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Rudolf Polzer <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 00:14:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVYtJ-0001gx-EJ
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 00:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663Ab0ANXNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 18:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755903Ab0ANXNy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 18:13:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926Ab0ANXNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 18:13:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1C5990BF7;
	Thu, 14 Jan 2010 18:13:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=xqU3cvDiodmAGGRaySA8BTEHlCQ=; b=v7YTJuqX1uN7zviO2417Bom
	TpIUY7/5eGQDdd6weEcNBgHQXn3JKmRDqNCge0RCBN7GSl0AvBDqYn6MfCe2ojk1
	Gaz+tHC0/+PI4OUc3Q/y53Qx5DpW8CqfWIBJDFXJPGchuJ+ujbDQiPD9tU8LjqxN
	cZQ4rhDA56rcET21bDH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QDflUh8WGEO9dnI9PUVrnPGDfws18hGV3TXNyiNGvumomPBvr
	U4NZX61CGgU9yTiMfueEH0iTiwn3gIgpkXZMBuBERxOhfPzuK/7bJHtmXVkTeRxy
	GwTt3OWH/PE1aZ0j3tNZrWvzurchx6eYr61yCdHlkvYHhtsjZ3muzx0AMo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DBEF90BEE;
	Thu, 14 Jan 2010 18:13:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0E8E90BEC; Thu, 14 Jan
 2010 18:13:36 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7689A5AC-0162-11DF-A013-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137036>

Rudolf Polzer <divVerent@alientrap.org> writes:

>> Each patch should be sent out in its own mail. (As Matthieu has
>> recommended, you should check out Documentation/SubmittingPatches.)
>
> So, using a newsreader is not accepted practice? Why is the mailing list on a
> newsgroup then?

I do read this list in a newsreader.  When I say "reply" or "follow-up",
the response is sent out to the list via e-mail.  Your newsreader should
be configurable in a similar way, I think.

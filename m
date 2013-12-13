From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2013, #03; Thu, 12)
Date: Fri, 13 Dec 2013 12:58:32 -0800
Message-ID: <7v1u1g1n9j.fsf@alter.siamese.dyndns.org>
References: <xmqqwqj9r2ig.fsf@gitster.dls.corp.google.com>
	<CACsJy8AMu9tiPBXXi3VKZ=nWub0nNt+6UTgGYRpudGxi7xzUnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 21:58:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrZom-0001jF-Qk
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 21:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285Ab3LMU6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 15:58:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184Ab3LMU6g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 15:58:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FA215A1B7;
	Fri, 13 Dec 2013 15:58:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ji8fS8mrc/0SC3BnVDRDrIXQwck=; b=Jah5Sn
	MWQNSK/3IraXTXF0Ua/WF/HOYLSHIaPugi2j+TMokDzoznOQ1pj59ZZcBOffRQvz
	NUqx/fLSJliFEbi+0lnS1TIxEHeafinRxLYXtvH3BalgrW5pWnEaX1mGutFkr1lO
	nyC4hwqFPC0qGJycYy4cOmMESm156M9YSxN6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZobkOlxls99Bs18pUMDMQ7QAyCK/krCF
	OJIj4NGPZteBk/9HZnta2n0rdHOr9Pz1qn23//48TzQWtwd0UbmI2WnAj7qQZTQh
	LohFJ0EFDMYSpd8VZGUZPcBVnOb6J1Pdabx4ud3VVIKOhxamtt7+2/swmj4AdYLt
	lc5dMnTWLog=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 801A65A1B6;
	Fri, 13 Dec 2013 15:58:35 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A24265A1B5;
	Fri, 13 Dec 2013 15:58:34 -0500 (EST)
In-Reply-To: <CACsJy8AMu9tiPBXXi3VKZ=nWub0nNt+6UTgGYRpudGxi7xzUnw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 13 Dec 2013 08:05:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 549CFDA2-6439-11E3-AF76-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239266>

Duy Nguyen <pclouds@gmail.com> writes:

> A bit off topic, but that command does not work as-is. We need '--' to
> separate pathspec.

Thanks.

> Something to be improved later..

Hmph, I somehow doubt it.

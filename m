From: Junio C Hamano <gitster@pobox.com>
Subject: Re: contrib/mw-to-git/Git/Mediawiki.pm
Date: Thu, 27 Jun 2013 10:28:25 -0700
Message-ID: <7v4ncjtqdi.fsf@alter.siamese.dyndns.org>
References: <51CC6189.6030701@web.de>
	<CAETqRCgctnVqrYaAYn7uZtv0rvQNawUAi513iTeWPufkZPRgAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?Q?Beno=C3=AEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 27 19:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsFzv-0006cK-BU
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 19:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab3F0R23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 13:28:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab3F0R21 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jun 2013 13:28:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 277E62946D;
	Thu, 27 Jun 2013 17:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aHVBCxciNdxs
	nyzoreE9ypEeGqU=; b=p8vGkVJF/02mzJdK3R2wyMjifsdDquagu5pdLXrqzEKw
	2jLTzS7c9hMfSa3+bcIJGpMT3BHwtCaK9MCecDUo+jyXmG63QuDcLm2cET4zTOEm
	VnD63/K6GxVG5Ke7x/eeBIJcWujBD+D8vDQPDmIJH+FzegKeZ5+sBfULNsY48YE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VRvzEz
	sXVnBAG6b2VNlEiSFGTWaCV5sA87JM5HIemt1olkWMNEWJDs13jPDVLi7zZRm7HF
	Djx5PXeVqkUibIU0Skd6BlOT2WziluJ9ZvUrg2RAdybkqQE8X0xHn+IBEFS/Vht4
	bh0eIbIFyEki3n03KDGEVw7lwAruyAPJtgAG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 164A02946B;
	Thu, 27 Jun 2013 17:28:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87AB52946A;
	Thu, 27 Jun 2013 17:28:26 +0000 (UTC)
In-Reply-To: <CAETqRCgctnVqrYaAYn7uZtv0rvQNawUAi513iTeWPufkZPRgAw@mail.gmail.com>
	(=?utf-8?Q?=22Beno=C3=AEt?= Person"'s message of "Thu, 27 Jun 2013 18:25:38
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9C8BCB4-DF4E-11E2-98B5-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229125>

Beno=C3=AEt Person <benoit.person@ensimag.fr> writes:

> Oops, so sorry :/
>
> It's defintely doable since the lowercase 'git' is only a bin-wrapper
> for git to ease development in contrib/mw-to-git/ .

Hmph.  Does it even need to be in-tree then?  Is it insufficient to
run ../../git from that directory instead?

> Junio, Matthieu : should I resend a new version of my serie which
> renames the 'git' (lowercase) file into something like 'git-dev' ?
> (some comments directly mentionning the 'git' (lowercase) file needs
> to be updated as well in the Makefile)
>
> Benoit

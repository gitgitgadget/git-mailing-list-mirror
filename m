From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Wed, 02 Jan 2013 18:02:48 -0800
Message-ID: <7vhamzyqev.fsf@alter.siamese.dyndns.org>
References: <201301012240.10722.tboegi@web.de>
 <20130102094635.GD9328@sigill.intra.peff.net> <50E4BF58.4090808@web.de>
 <20130102232239.GA27952@sigill.intra.peff.net> <50E4C9B5.8070308@web.de>
 <7vlicbyvc2.fsf@alter.siamese.dyndns.org> <50E4CF7E.9090302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 03 03:03:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqa9R-00087Y-0b
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 03:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790Ab3ACCCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 21:02:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757Ab3ACCCv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2013 21:02:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CCD0A727;
	Wed,  2 Jan 2013 21:02:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MUsWpBVJP/LX
	PA/kXmdi9Oammbo=; b=Z/QcpxuWD6YmOdHx36CDYf+lpc/X7SuzW7Bozau/5wFT
	fN1TWV6A869d/VpBacjFTBxJzllZkT88sFnQRHiQZ93dwRuxteYsOeJIez6uTepL
	WGQtd2M6LUigIFnXUdMDMDYVrFKfU+bcsCsxvVbuSyjEbjQ90MaPUnpHjwN3yBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YoQpkC
	TpXrNatLddBd3OOAbEnlE6xE9zRDwGfbOo9PAtg8vqmuMgrFrHm4q+E4vwzr9YvF
	xK6l9Wkos0jcYD3LmFXaDmQ7HU7QkHvossfOECRHwaot8v27Y1KO5HZE3TbESRxt
	C450SPYxjhq13rZ8QWh3P+IXluKnxF+5DPOqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E702A726;
	Wed,  2 Jan 2013 21:02:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1431BA725; Wed,  2 Jan 2013
 21:02:49 -0500 (EST)
In-Reply-To: <50E4CF7E.9090302@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Thu, 03 Jan 2013 01:23:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD2CC1DC-5549-11E2-97FF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212566>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> When the dust has settled, we can either enable the check always,
> or mention "make test-lint-shell-syntax" in the Documentation.

In the longer term, I'm pretty much in favor of enabling all the
checks that are cheap by default, as that would help people catch
easy mistakes while preparing their patches.  People do not tend to
enable any check if it were optional.

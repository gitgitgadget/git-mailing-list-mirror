From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] teach the user to be nice to git and let him say please sometimes
Date: Mon, 13 May 2013 13:47:38 -0700
Message-ID: <7vsj1qli8l.fsf@alter.siamese.dyndns.org>
References: <20130511201928.GA22938@book.hvoigt.net>
	<7vobcfvqu1.fsf@alter.siamese.dyndns.org>
	<20130513134415.GB3561@book-mint> <87ppwur4tq.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 13 22:47:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubzet-0003BO-FS
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 22:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab3EMUrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 16:47:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254Ab3EMUrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 16:47:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C15F1EA71;
	Mon, 13 May 2013 20:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kZHdF8W4KZLsL+CvHDZCssJrDhI=; b=IeDxf4
	AvGK4D72Hr1u4+9x1rHV4zsnyU7sssRU9vbWeaszoy9n6cpbqbSBIqdjD5I5ijv4
	6v8mnJSeHxjpn0IRm9fAdxL3wN7ANxHhFTmQwdV4VY5LN7r08LWfuFRBhooJed1K
	yRK1EWYFDUxrfRoMYy/yhnZGeW5KdJRF6wLbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qe8F+iuiGHmQ5EuflMvjjGTmNrYAQnr9
	joF09ELjjlaOFaHoAtFF+zRUCkkHlyANuwoHAOxUjZ1QT4g21GqSoOKjouELLfnu
	Je2C/aM9jP9KYTCMhQyVOyrtv0F0fqSuXc+PSGXJpwarb538ASrFnDhx6qjiuLye
	U6R/WVL26DU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8331B1EA70;
	Mon, 13 May 2013 20:47:40 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6F4D1EA6E;
	Mon, 13 May 2013 20:47:39 +0000 (UTC)
In-Reply-To: <87ppwur4tq.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Mon, 13 May 2013 22:40:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59F87688-BC0E-11E2-9C97-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224202>

Thomas Rast <trast@inf.ethz.ch> writes:

> Heiko Voigt <hvoigt@hvoigt.net> writes:
>
>> On Sun, May 12, 2013 at 02:19:34PM -0700, Junio C Hamano wrote:
>>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>>> 
>>> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
>>> > Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>>> > Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>>> > Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
>>> > Signed-off-by: Johan Herland <johan@herland.net>
>>> 
>>> So these were the ones present on the dev-day?
>>
>> No this was just a random sample of the ones sitting at the same
>> beer garden table that this feature was implemented on.
>
> Also see
>
>   http://thomasrast.ch/pix/foss/20130509_gitmerge/DSC_7078.jpg.php
>
> for an illustration of the history of this patch.
>
> </plug>

Thanks for sharing. I see some familiar faces.  Envy, envy...

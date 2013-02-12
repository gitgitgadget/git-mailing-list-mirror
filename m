From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Replace filepattern with pathspec for consistency
Date: Tue, 12 Feb 2013 10:04:11 -0800
Message-ID: <7vmwv9h0is.fsf@alter.siamese.dyndns.org>
References: <1360661084-8678-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vliatijej.fsf@alter.siamese.dyndns.org> <vpq4nhhv4vc.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 12 19:05:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5KE9-0003hM-7m
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 19:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933679Ab3BLSE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 13:04:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933681Ab3BLSEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 13:04:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB0CEC60C;
	Tue, 12 Feb 2013 13:04:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lF3Xwfh19YnNgGN7RoMQZlvqCnQ=; b=Gj3Yn9
	JmXEKabhMJCIPMAEwq0V83drvUpS2I6Af85FcJ+71P/dTUEJHZjNnJFRJXnEe9DU
	2DnW+m7RwB5Z14NWhZ40zZpnbmtlfdm+fFezvnDRPrmTpUmLy1h6e8HmIjw/zanp
	XCDu4lS9EL43qIaNL5offBVH1gsP9CzQ25z1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IBb+1fW0S1LQZBY4V5ojI2ondykiHVUX
	DzvaiXpGPvO6wQqQTS16iO8hehi7otRYeFUieqKdqrgnEfhggSqMOyrGVTXPagye
	qxnwaLgOV84FW/1g2J/LfNW8zJvxz30dCjHIo8/w0tgKZ3qbV5zmoTVZu2QBnL2X
	YjCPO/wDjS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF942C60B;
	Tue, 12 Feb 2013 13:04:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32ABDC609; Tue, 12 Feb 2013
 13:04:13 -0500 (EST)
In-Reply-To: <vpq4nhhv4vc.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Tue, 12 Feb 2013 18:06:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B852F7C-753E-11E2-BE52-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216169>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The strings that are fed to _() would be updated with your patch,
>> but the replacement will stay to be "filepattern" translated to the
>> target language.  Translators have to actively hunt for the messages
>> to update them.  If you left the .po files untouched, they would
>> notice when git.pot is updated the next time and that will ensure
>> that the affected messages get translated, no?
>
> Right, and I'm not competent to say how filepattern was translated in
> any of the languages. Let me know if you want a resend without the po/
> part.

I'll remove the tail part of the patch myself.  Thanks.

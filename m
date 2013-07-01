From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Mon, 01 Jul 2013 14:56:47 -0700
Message-ID: <7vobamaq04.fsf@alter.siamese.dyndns.org>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
	<CALKQrgcmmaqAt-oVtFeem_xvqsjehacVoVJ2bYOyfKWTUzV0AA@mail.gmail.com>
	<7vtxlwqrbg.fsf@alter.siamese.dyndns.org>
	<CALKQrge33R9NiQ6isy4xEFaPe7SUmRaDbrXsjPahjtGp9ELG9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jul 02 00:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmLB-0005bA-9g
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646Ab3GAWMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:12:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204Ab3GAWMp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:12:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F93D2D363;
	Mon,  1 Jul 2013 22:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=l5uDi8Jj096lOqdeygwdzxhYvXY=; b=WlGME2HSePICwSpq1+2C
	qb3jUF/6jhvaRe21ka/SqbVKsYiUIEDRkddiKubesrMSBNWB7GNdKm90Fvbr3HIe
	cdbqQdKxU6qtOn+b0Hg0uAoSA8C+hOGgO5xKAjP4qor+ssvHEdC014+EnGHJHVEo
	WCEX0vVXd9/qS4eal8g8bO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=fXIsc9rerGzZMgewhCvyh+5EzT08yXSpkie9OL718irkw1
	pmJ2XktUFfwD30hPFMjkyIhgSEp9peygzQQE8ifkGnGMi+mZqHJExcdtDEUp7PEn
	j6bO+khYTHSMEnNux3NjMm0WUbhDQ+8PzvkOB6EIQDbOGP45dSwZ+bHrvjZ1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 659CF2D362;
	Mon,  1 Jul 2013 22:12:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA9902D35F;
	Mon,  1 Jul 2013 22:12:44 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5AFFB056-E29B-11E2-B926-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229334>

Johan Herland <johan@herland.net> writes:

> On Tue, May 21, 2013 at 5:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ... I think we can go either way, and the above "I think this is
>> being rerolld" was primarily keeping the options open.
>
> You're right. No point in setting things prematurely in stone. I'll
> fold jh/shorten-refname into the ongoing series.

Ping?

No need to hurry, but just to make sure this didn't disappear from
everybody's radar.

Thanks.

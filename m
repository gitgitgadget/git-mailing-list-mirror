From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 14:59:24 -0800
Message-ID: <7vzkpyql2r.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
 <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
 <4D58D2DF.1050205@viscovery.net>
 <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
 <4D5906FD.7030502@drmicha.warpmail.net>
 <buod3muswq7.fsf@dhlpc061.dev.necel.com>
 <7vtyg6tu9e.fsf@alter.siamese.dyndns.org>
 <AANLkTinnCLVDEZpNPVYZ2fq1BY=257BTxkzNj44-Yz3O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 15 00:00:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp7Om-0000zd-Oh
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 00:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab1BNW7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 17:59:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab1BNW7l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 17:59:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F90E3D10;
	Mon, 14 Feb 2011 18:00:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7zKRDqO9aExZUMerlQJHRWAKMag=; b=s6P/Vh
	8yaZYeBTjEZmYjxIUpAl+EPEsOpuIZ/d6K4t/iF9uHHiSIoxGkqz9KFffHq0elvI
	cbfzypCos5RK9y3xkczNzp1+TvH0kYI7ttEt+SC8TXh9GcNUjzvv2+acY9FoTRkm
	Ofk886H9gcsci0m9URBmsNtOrjIz/ayWemy6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e05/df90jaU8jcmOp3uTxjIAceiI+5Jo
	yHrKsVBtylgsdoduslA4QwrhY0UdZO+m9VcteoMYJKNPE7g3gLDHDNZZ8PUJHLdK
	dwOP6HxR2RaR8QLGXLLM4/Z5pPy0AI850LzQiFSrm8yv3j/PstvcrpyZMqmaVkcB
	slHUWjHMxhk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A2D323D06;
	Mon, 14 Feb 2011 18:00:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 028E53D03; Mon, 14 Feb 2011
 18:00:29 -0500 (EST)
In-Reply-To: <AANLkTinnCLVDEZpNPVYZ2fq1BY=257BTxkzNj44-Yz3O@mail.gmail.com>
 (Miles Bader's message of "Tue\, 15 Feb 2011 07\:07\:03 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3CB7618E-388E-11E0-8E7C-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166790>

Miles Bader <miles@gnu.org> writes:

> Er...?
>
> Here we were talking about using "-s" (inspired by "--staged"), which
> I suggested because you earlier objected to "-c"...

Not _we were_, but _you_ were.

I actually was hoping that it was obvious that -s is a no-starter from the
messages so far in this thread, as neither --cached nor its more
descriptive spelling --index-only has character 's' anywhere in it, and we
have been keeping --staged as a low-key synonym for a reason.

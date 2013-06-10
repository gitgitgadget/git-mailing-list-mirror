From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 22/28] git-remote-mediawiki: Modify strings for a better coding-style
Date: Mon, 10 Jun 2013 12:01:11 -0700
Message-ID: <7vsj0phjt4.fsf@alter.siamese.dyndns.org>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-23-git-send-email-celestin.matte@ensimag.fr>
	<vpqk3m2qs2r.fsf@anie.imag.fr>
	<7vhah5kje8.fsf@alter.siamese.dyndns.org>
	<CAETqRCh2OLq=gj-fEGrO1vyQQfTJNAFp_z_Bf0sirbBgRKPrdw@mail.gmail.com>
	<vpqa9mxeuvf.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Beno=C3=AEt?= Person <benoit.person@ensimag.fr>,
	=?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 21:01:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um7LO-0005oD-FU
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 21:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab3FJTBS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 15:01:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754487Ab3FJTBO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jun 2013 15:01:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 636C0271A6;
	Mon, 10 Jun 2013 19:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XkMFsPmBaDlW
	hRDJoGu+60m7aV4=; b=OoeiU7jwrLBAiEBICHeTm7BQy/5m+lBMF1f1yhNL9n6t
	l/u1qA8IEXB8bIrNwQNZ0ypEo74Wl/vlHegtxdtwEUU66QWOSin422aNF6Xd2WCa
	Ex4U6cE3lUEtsGPUTR/PGidaXORsfmZESe+f69gAyro6LYg/tQRdrSIBrRKKgjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Wolt1s
	Iu8OruaxPE0LsHFYm199lKEFAj4sWkN5V/cC+V/28P0E3J3jcNLvvqKLxYpQTwfk
	V30bcxTXWPHgbMAObpbvxk+desTI/hI+aEGd1rKqwZe3+8yNU+qHGQIqTQPZOuTJ
	8eH51XQJ5eQTHj1cfhC0UsV0MaztVmu/3UihY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59040271A5;
	Mon, 10 Jun 2013 19:01:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C55FA271A2;
	Mon, 10 Jun 2013 19:01:12 +0000 (UTC)
In-Reply-To: <vpqa9mxeuvf.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	10 Jun 2013 19:30:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E819F3C-D200-11E2-AD99-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227360>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Please, don't top-post. Quote the part of the message you're replying
> to, and reply below.
>
> Beno=C3=AEt Person <benoit.person@ensimag.fr> writes:
>
>> Well, I think next step would be to replace all those calls with
>> Git.pm `command`, `command_oneline` and `config``which take an array
>> of arguments after the "command". In the preview tool we use those b=
ut
>> I don't know if we will find the time to clean that up too in
>> git-remote-mediawiki :) .
>
> Agreed. run_git was written to avoid having to depend on Git.pm, but =
now
> that we do, we should do it the Git.pm way (although this is not a
> high priority for now).
>
>> Don't know though if it's better to mix that with this serie which i=
s
>> mainly based on what perlcritic returns.
>
> If you go this way, I'd rather have it on top (i.e. a separate patch
> series).

Or not worry too much about it in the 3-week long school project.
=46inish one that you started and then build on top.

From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/3] make union merge an xdl merge favor
Date: Mon, 1 Mar 2010 07:57:40 +0100
Message-ID: <36ca99e91002282257i7f07f035o15d8d64e062ee94e@mail.gmail.com>
References: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com>
	 <17999fdb3ff374156acb7fc670426265fa27b94b.1267385538.git.bert.wesarg@googlemail.com>
	 <7vwrxx2k29.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 07:57:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlzZf-0004WW-53
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 07:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381Ab0CAG5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Mar 2010 01:57:45 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:32858 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0CAG5o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Mar 2010 01:57:44 -0500
Received: by fxm19 with SMTP id 19so393014fxm.21
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 22:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AsrfDWue17UFv2xT6SxwuXbc+SiaGJGxei3t+bnGjE4=;
        b=ujx1RgDjhPWVqAg/PJv5+7yy0rTso/Xk5PMOncjcbP76xaTDVqolpYzJjdjcFi4Inv
         VFpo/VzPsO9wN+BbzrdoJn5xDPsqvT8RKh1iA3h6q+/696qj0KNLpLZTqar05s4bppCj
         HL3hXlhLG8uwLDHpBDbWS+W+NR5PwGO8dEZXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J4MqNDs8ATqg0du3LL9DTVJiCdwRvD0fv6AmTOnumHbvWSdHID4sYeRpZTUddBU0Ic
         +l13N5Bha8ibHUaz5lHpFMfNrfxhFiEo25a6czRgk595IeposzsSAwkyQfaCBPv53U8S
         ZvkBxe+30gFgAf9Ovn7KgclleNyKLK0w5G9l4=
Received: by 10.223.15.148 with SMTP id k20mr4508752faa.67.1267426660051; Sun, 
	28 Feb 2010 22:57:40 -0800 (PST)
In-Reply-To: <7vwrxx2k29.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141300>

On Sun, Feb 28, 2010 at 21:15, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> The current union merge driver is implemented as an post process. =C2=
=A0But the
>> xdl_merge code is quite capable to produce the result by itself. =C2=
=A0Therefore
>> move to it there and teach git-merge-file a new --union option.
>
> I like the idea of patch 2 and 3 but they are independent of what we =
do
> (or don't do) to merge-file. =C2=A0Could you flip the order of the pa=
tches so
> that 2 and 3 can go first?

WIll do. On a side note: I plan to support the --union option also for
git-checkout. Would that be a good idea?

Bert

>
>
>

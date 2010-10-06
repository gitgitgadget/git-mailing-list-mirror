From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH v4] tg-files: list files changed by the topic branch
Date: Wed, 6 Oct 2010 08:11:58 +0200
Message-ID: <AANLkTi=Fy2EoJO9Ui0BB3JA85hPDJ9xt=++=M8a8pW9o@mail.gmail.com>
References: <20101005071723.GG11737@pengutronix.de>
	<1286305402-28284-1-git-send-email-bert.wesarg@googlemail.com>
	<87k4lw1enu.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 08:12:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3NET-00066P-Fz
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 08:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757579Ab0JFGL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 02:11:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46438 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474Ab0JFGL7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 02:11:59 -0400
Received: by iwn5 with SMTP id 5so9319017iwn.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 23:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4yHYrF/DHMktuF8i/lSIDrdkOcWfJOc4cj0PajGnIFM=;
        b=CE7tRL8WlCzyWry+F24ZubXC5OeEpgNOvXitms5yGDVKZjNeKnwI/9VBAHQ8pupW2Q
         Z8N8f0hsQ1HC4w+Gx3ncyJDnrC0FtBEXS4LfyNaiMhd0GBWcmgHHELvUZPlX3er1TAmA
         CUMw05Qb54T7ImvlHLQp/4mUCXYu6L6bFXvtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bYa3MPvcy32o70lwxeSGjXDY+57KudkJ6Gmj3PsjcZjX6sCVlw7+ggFZch3ynvZE4H
         NhekfQSu4wKesxGa+XI0RYPQ3hEoRIn05a5/gQHAuJ8hHTcv4ojCGkpp73JsY9kHNtDS
         qjno+KGpKs1WL8v1PGdD+LaRxZQaJg1GmgO78=
Received: by 10.231.35.135 with SMTP id p7mr13419678ibd.73.1286345518220; Tue,
 05 Oct 2010 23:11:58 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Tue, 5 Oct 2010 23:11:58 -0700 (PDT)
In-Reply-To: <87k4lw1enu.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158268>

On Wed, Oct 6, 2010 at 00:02, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem=
@gmail.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> this could also be a --name-only option to tg-patch. But I Like the
>> similarity to 'quilt files'.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
>>
>> =C2=A0Changes:
>> =C2=A0 v4:
>> =C2=A0 =C2=A0* apply Uwe's suggestions
>
> [...]
>
>> +
>> +
>> +[ -n "$name" -a -n "$topic" ] &&
>> + =C2=A0 =C2=A0 die "$topic are mutually exclusive with NAME"
>
> ...so, "are" should now be "is", as $topic will be _either_ `-i' or
> `-w', not both.

Thanks. Will fix.

Bert

>
> =C5=A0t=C4=9Bp=C3=A1n
>

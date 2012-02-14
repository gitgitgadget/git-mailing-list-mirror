From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] t: mailmap: add simple name translation test
Date: Tue, 14 Feb 2012 22:28:14 +0200
Message-ID: <CAMP44s2uZA_xYh8Rb8xNJM0Yf3LmNHgzzrLWd9C1wW64T2yVQA@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<1329235894-20581-3-git-send-email-felipe.contreras@gmail.com>
	<7v8vk56us3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marius Storm-Olsen <marius@trolltech.com>,
	Jim Meyering <jim@meyering.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:28:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxOz8-0002CM-EW
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760871Ab2BNU2R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 15:28:17 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41962 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760761Ab2BNU2P convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:28:15 -0500
Received: by lagu2 with SMTP id u2so375483lag.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 12:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6mhbdL7X02or+HAivfk65GZoy6h0nAFMwil/55vGfeY=;
        b=pUmXrMb5iIq/wLfb23Kw5MJRCBX/UnThLieU8HVivXFiw7ATLn0sGzb3oUojKEIA07
         8SlAsCTTaaaen03YgNruNWwQYbjNqM6VzhnIQ7j+i0kftN3MJGQN1chhEbALr4yjmK/R
         8KKilCjnMlzzwEfY1YICUiytYMUYeEqe6VC9I=
Received: by 10.112.28.169 with SMTP id c9mr7771677lbh.42.1329251294106; Tue,
 14 Feb 2012 12:28:14 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 12:28:14 -0800 (PST)
In-Reply-To: <7v8vk56us3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190749>

On Tue, Feb 14, 2012 at 10:10 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> It was clear that we didn't have any test for "blame -e" hence it was=
 no
> brainer to judge that the patch 1/2 is good without any description.
>
> But I am scratching my head, deciphering what this patch adds.
>
> It appears to me that the existing tests that map author@example.com =
from
> the original "A U Thor" to "Repo Guy" and inspect names and mails in
> various output already cover this "Wrong with <right@company.xx> can =
be
> corrected to Mr. Right" case this patch adds.

Yes, but in the first tests they don't check for 'git blame', and much
less 'git blame -e', and the second tests only check complex mappings.

> What am I missing? =C2=A0Instead of explaining it to me, can it be ex=
plained in
> the log message?

If an explanations along the lines of the above make sense, I can resen=
d.

Cheers.

--=20
=46elipe Contreras

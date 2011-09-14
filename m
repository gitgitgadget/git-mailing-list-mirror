From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git archive" seems to be broken wrt zip files
Date: Tue, 13 Sep 2011 23:55:39 -0700
Message-ID: <CA+55aFwLk8XcCDXM0w_wf5RnoB4oGxkjJrUGLB5wgSkx385b_g@mail.gmail.com>
References: <CA+55aFx43OxExGNrJs+AyKNtdr+KCZZoE=iaQTz8uHoUSrQv0w@mail.gmail.com>
 <20110911062206.GA29620@sigill.intra.peff.net> <20110911062740.GA8018@sigill.intra.peff.net>
 <m239g3i5kz.fsf@igel.home> <CA+55aFxsaE5btVJmM_QaUMcDzBg4df-g8X7NknC6t9UM+oQATw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 08:56:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3jOB-0008De-B5
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 08:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab1ING4B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 02:56:01 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42049 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab1ING4A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 02:56:00 -0400
Received: by wwf22 with SMTP id 22so1793955wwf.1
        for <git@vger.kernel.org>; Tue, 13 Sep 2011 23:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=x8t2+t9+AleasMo8MVPY14UjoDfKh8uJ7phS0Vf9ZRw=;
        b=fdXRN/ba6mg8Jgfp8unXhA1OlYvTraOus6xsytCY9LVL4xsTqpOj4cWI5rd+akD7fE
         vAq6sp0MNKEq1qZp+eLi21wAySWgPBOEpLK46D0wBWhaI/Q79fd6+Qcc3WZF9Sbjrsx+
         fC5F2bwEp/5y5aRX4b1IW23W9VXOMRJUCRqNM=
Received: by 10.216.171.72 with SMTP id q50mr4581355wel.76.1315983359181; Tue,
 13 Sep 2011 23:55:59 -0700 (PDT)
Received: by 10.216.174.8 with HTTP; Tue, 13 Sep 2011 23:55:39 -0700 (PDT)
In-Reply-To: <CA+55aFxsaE5btVJmM_QaUMcDzBg4df-g8X7NknC6t9UM+oQATw@mail.gmail.com>
X-Google-Sender-Auth: sT7ET3zWjEGWFXUg9cJgcsHzBC8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181340>

Re-sent as this clearly never seems to have gone anywhere due to me
not realizing that the LF problems meant that while incoming email
worked fine, going out through smpt.linux-foundation.org didn't work.

                     Linus

On Sun, Sep 11, 2011 at 11:07 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Sep 11, 2011 at 6:14 AM, Andreas Schwab <schwab@linux-m68k.or=
g> wrote:
>>
>> It is. =A0This only happens if you have more then 16k entries and wh=
en one
>> of the 16k entry infos is reused it happend to be previously used fo=
r a
>> symlink entry.
>
> Thanks for the explanation.
>
>> Here's a patch for unzip60 for reference:
>
> Is this problem known to the unzip developers? Is it actively
> maintained any more? The 6.0 release seems to have been from April
> 2009, and the web page seems to have a "last updated" of September
> 2009.. Is there some other unofficial archive for bugfixes like this?
> Distros?
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>

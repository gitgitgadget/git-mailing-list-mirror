From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Tue, 22 Mar 2011 09:04:34 +0100
Message-ID: <AANLkTimHEHQzV4B7beraEuT9Ta8+MBeyPPmSGkBWD+76@mail.gmail.com>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com>
	<7vwrjssbfk.fsf@alter.siamese.dyndns.org>
	<4D877FAD.9000807@viscovery.net>
	<4D879516.3060204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 09:04:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1wa3-0007jD-J6
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 09:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab1CVIEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 04:04:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65035 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab1CVIEe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 04:04:34 -0400
Received: by iyb26 with SMTP id 26so7186301iyb.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AbSQyePnQoIAsNLyEGalrVNyHKpyLmnxnhpG8XSx4WI=;
        b=FcbTDoXNqRiUj0+ny0BdyvJzom5J2uElsDKhIPUHflrKx/euS2N9Bu1qdbr3Zukpvk
         7TiOiyq6OnYa6sTarOEJbU+UaQiA+2H7lirX9gw35YTowVKmZjfcov3O4w9K7FiSwwr/
         zurgez9GM3yddYcnR1z0PyDEJBRwCmp6/LfZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tC4rohUTOKWEm5+69g3a77UO7NAzjc1WaOJZFyr8Ib66pHM+iBbl90mFcTiBYSRXpg
         ZOowFgaRb3njDNWu9z2NnGSB9HzipFcevfq8vuL2HZWyI+pAR4aIgxLccZ2CKrXce3En
         Y7LRCxqfor3T8SYNJYFsolwj5XsvjhZVfC5bw=
Received: by 10.42.156.6 with SMTP id x6mr8736997icw.90.1300781074087; Tue, 22
 Mar 2011 01:04:34 -0700 (PDT)
Received: by 10.42.225.138 with HTTP; Tue, 22 Mar 2011 01:04:34 -0700 (PDT)
In-Reply-To: <4D879516.3060204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169707>

On Mon, Mar 21, 2011 at 7:12 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> W dniu 21.03.2011 17:41, Johannes Sixt pisze:
>> Assuming you did not 'git add' the file yet, you are looking at the
>> "condensed combined diff" after manually resolving the conflict by d=
oing
>> the "+line" manually that the cherry-pick should have brought in. Of
>> course, a lot of context is visible here if both sides have diverged
>> considerably in this area.
>>
>> I.e. the diff will look something like
>>
>> =A0+line from HEAD
>> =A0+line from HEAD
>> + line from cherry-picked
>> =A0+line from HEAD
>> ...
>>
>> Notice the double columns before the content lines. This sort of dif=
f
>> extens above and below the conflicting section until there is a "gap=
" of 3
>> lines that changed neither on the HEAD side nor on the cherry-picked=
 side
>> since the merge base.
>
> Hm that might be possible! I'll check it tomorrow @work.

You were right - the line I've added manually have two "++", and the ot=
her
lines shown with differences only have "-" and "+" in the second column=
=2E

I'm still not clear what is exactly compared when I use plain diff or
-c version.
It might be I need to read more docs. I'll ask if I'm still in doubt
after reading
more.

Thanks again for explaining this to me - saved me from a lot of PITA re=
searching
:)


--=20
Piotr Krukowiecki

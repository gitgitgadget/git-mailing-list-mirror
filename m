From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Tabs and spaces
Date: Thu, 21 Apr 2011 03:15:09 +0000
Message-ID: <BANLkTi=XqynMpRkR=cRMTXYjr+p=Jxt=Ng@mail.gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <20110420064318.GF28597@sigill.intra.peff.net> <d74e95d4-ef16-42fb-ae8f-b1d7a8b9d91e-mfwitten@gmail.com>
 <20110421000701.GA10987@elie> <1235e29d-6cbb-445b-9b6f-4e174c03ba8f-mfwitten@gmail.com>
 <20110421021825.GA23373@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 05:15:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCkN1-0005GZ-0u
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 05:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968Ab1DUDPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2011 23:15:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56205 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab1DUDPj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2011 23:15:39 -0400
Received: by iyb14 with SMTP id 14so1101744iyb.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 20:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=eUb4NHQ++flySDY5OwcdgjFS2CWcHOT0dkEI0ErEySA=;
        b=YBpsyo7X49wehIfgjhSWufGP4QYmDcC63O4mwDuoO5Izt9BG58C4RBQGGPO4NGqb5X
         r5dkDMbLcLGGhg4KoJvL/2isAwVH4rkTHPbfpQNWTBETZoqKfDzldm7TGkQLG1SKgatz
         Jg8JzNN8Xe8KtAKkSmVv2NdkXYerJwHHJEu+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XIG/EZIJkQbw8WzJYClQRAGhMH9IkGxmqPXUWbKv/l6xbuX8XU8wdBjGDxsHYBWrjK
         OHzbueIdQ6su3YepGS8QQ9niweSflWeqUqFtHq9xYlGGIXt1q180b8KIhlKR9o59wX1h
         SmMifpBGDO7kNSSKbpStl1h8cjKzu++h8KI+w=
Received: by 10.43.62.210 with SMTP id xb18mr10518079icb.349.1303355739062;
 Wed, 20 Apr 2011 20:15:39 -0700 (PDT)
Received: by 10.42.178.196 with HTTP; Wed, 20 Apr 2011 20:15:09 -0700 (PDT)
In-Reply-To: <20110421021825.GA23373@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171890>

On Thu, Apr 21, 2011 at 02:18, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Michael Witten wrote:
>
>> You just need an editor that [...]
>
> which many contributors don't have (or haven't configured that way).
> Really.

to which I already said: "if your text editor can't do that, then any
style of indentation/alignment is going to be painful."

>
> [...]
>> However, with a tabstop of 2, it looks like this:
>>
>> =C2=A0 if (foo && bar && baz &&
>> =C2=A0 =C2=A0 =C2=A0 qux && quux) {
>> =C2=A0 =C2=A0 ...
>> =C2=A0 } else if (quuux(quuuux, quuuuux,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 long_expresion_comes_here(quuuuuux))) {
>> =C2=A0 =C2=A0 ...
>> =C2=A0 }
>>
>> Notice that your `qux && quux' line (which follows the method we bot=
h like)
>> remained nicely aligned, but your `long_expression_comes_here' line =
has
>> moved back so much that it doesn't even satisfy the `right margin' r=
ule
>> anymore.
>
> Oh, I still think a tabstop of 2 is insane (for various reasons, some
> explained in the thread you mentioned).

That's not really the point, though, is it.

> No matter --- Junio will use --whitespace=3Dfixup to convert your spa=
ces
> to tabs anway.

Good!

That means I can be satisfied with having written sane patches, and
Junio can be satisfied with having forced the insane use of tabs. It's
a win-win :-D

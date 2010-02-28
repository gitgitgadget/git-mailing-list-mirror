From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Sun, 28 Feb 2010 15:39:31 -0500
Message-ID: <ca433831002281239j2fc17033xfa013bf896dcda2c@mail.gmail.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com> 
	<1267246670-19118-5-git-send-email-lodatom@gmail.com> <7vd3zp88gn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 21:40:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nlpvk-0004wD-Gy
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 21:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032033Ab0B1Ujz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2010 15:39:55 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:62033 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032025Ab0B1Ujy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2010 15:39:54 -0500
Received: by yxe12 with SMTP id 12so851588yxe.33
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=A0tS9DG0YGMcjd8njWSB9pkYv5ROlG2i3EQeJA32jhs=;
        b=A0EwOv8cbWc3cQP7jxE/Tu5cDOw3we+uZ+S7sF4Efeg6R+4QTEhBW6J7PniE1y9KH4
         PblBeb+QAoj8g1TKqEbhRWTnI6XV6Bz08TRuNB0Gw6difiRupVS2TIQPmHw65gI9oQ1F
         zYk60asPYvu/HlBbj9sDSrN9qUnb3yguKuhuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dLquZCixiwEwo6aiNWjQwjW1NOA1vD4ArQayvEVS9W6UdilA0oo+cd7LdnHsy5AXVx
         h+9iEILjQQ77/oG7W8i6uPMefvwGdep72hSAx+jGms/CXJGh2laFV0NWOxXBuy656rI2
         VrlpO1cLMdFIPJeyqFqyMKmRGXexkUU3HkPQ4=
Received: by 10.91.19.27 with SMTP id w27mr2694905agi.118.1267389591277; Sun, 
	28 Feb 2010 12:39:51 -0800 (PST)
In-Reply-To: <7vd3zp88gn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141271>

On Sun, Feb 28, 2010 at 2:29 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> +color.grep.<slot>::
>> + =C2=A0 =C2=A0 Use customized color for grep colorization. =C2=A0`<=
slot>` specifies which
>> + =C2=A0 =C2=A0 part of the line to use the specified color, and is =
one of
>> ++
>> +--
>> +`filename`:::
>> + =C2=A0 =C2=A0 filename prefix (when not using `-h`)
>> +`linenumber`:::
>
> Why do I get a feeling that I already said something about three colo=
ns?
>
> =C2=A0... goes and looks ...
>
> Ah, it wasn't to you. =C2=A0Please see:
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/139014/f=
ocus=3D139343
>
> BUT.
>
> I tried the three-colons notation with AsciiDoc 8.2.7 and it seems to=
 take
> it as enumeration items that are nested a level deeper, so this might=
 be
> safe.

When I wrote the patch originally, I tried to find the difference
between triple colons and double semi-colons but failed.  Now that I
look at the changelog, double semi-colons was introduced in 5.0.9, but
there is no indication whatsoever of triple colons.  The wording
implies that double-semicolon is older, so it's probably safer to use.
 I'll switch to that.

> But the last sentence about color.branch.<slot> is indented as if it =
is a
> part of description for "separator" slot, which you may want to fix
> regardless.
>

Man!  It worked in AsciiDoc 8.4.4, but evidently not in 8.2.7.  What a
pain.  I just installed 8.2.7 so hopefully I won't run into these
problems in the future.  I'll fix this.

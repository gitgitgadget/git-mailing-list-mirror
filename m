From: Michael Witten <mfwitten@gmail.com>
Subject: Re: file mode
Date: Tue, 14 Jun 2011 05:51:06 -0000
Message-ID: <ea0263ba89684f958d91bbf1fa2dcdc6-mfwitten@gmail.com>
References: <alpine.DEB.1.10.1106122055210.6124@localhost>
            <BANLkTimh=-caLH5dVaUeXXmcF21+=-o0tw@mail.gmail.com>
            <20110613053814.GA2680@sigill.intra.peff.net>
            <BANLkTikZZsuQ9PoNvMOoRCg=kAnwQOvOSQ@mail.gmail.com>
            <BANLkTimgby8-aBmXiZ72vtxoLO6Tr7zi2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Peter Kleiweg <pkleiweg@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Jun 14 08:16:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWMvk-0000Pb-P8
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 08:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab1FNGQl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 02:16:41 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62758 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab1FNGQh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 02:16:37 -0400
Received: by ewy4 with SMTP id 4so1858000ewy.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 23:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=3FDkvMZ5hiBTRf32BoHRwKYcEVIkgVIwOmayUmRwYf0=;
        b=jpZPCjrLcRqYoia/oLZZ7TlT+SSd8/x+1E0EASBcUYfywVfUeEWHnmYDImTIGNNyiJ
         DUQSkYdZ4AuDl3SnJJRmbxS9LZH2mW2dITF0ORNVim9LHodg0LMVnEaXsSj2bEvqwQ2B
         7+MnDpMu86gMXEFDXpW4rfrBVDLbtwMpd5gns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:content-type;
        b=lNOBshE0PXg+14Tu5t5pUjOr3d8+XPP16Jo6ArdYQebHfRFWN42QLPzzZiINxmKIPi
         75x0GuPbNOCwmj0kH5hmIpRr/20vQmZU0aK5NlfX2f4zqOBoYO0NEuddJi5pOlAjR/sC
         4DkRZKRkg1nOtTAznyaI1D8uaR85DlpCE9B+c=
Received: by 10.213.8.135 with SMTP id h7mr186077ebh.34.1308032195680;
        Mon, 13 Jun 2011 23:16:35 -0700 (PDT)
Received: from gmail.com (tor11.anonymizer.ccc.de [62.113.219.4])
        by mx.google.com with ESMTPS id x46sm5853251eea.10.2011.06.13.23.16.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 23:16:34 -0700 (PDT)
In-Reply-To: <BANLkTimgby8-aBmXiZ72vtxoLO6Tr7zi2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175748>

On Mon, 13 Jun 2011 23:18:58 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son wrote:
>> On Mon, Jun 13, 2011 at 05:38, Jeff King <peff@peff.net> wrote:
>>> On Sun, Jun 12, 2011 at 07:12:42PM +0000, Michael Witten wrote:
>>>
>>>> On Sun, Jun 12, 2011 at 18:57, Peter Kleiweg <pkleiweg@xs4all.nl> =
wrote:
>>>>> I added a file that has file mode 600. When I do a check-out,
>>>>> the file comes with mode 644. Is this supposed to happen? Then
>>>>> how do I control what permissions files have?
>>>>
>>>> Do some googling.
>>>
>>> I really don't see the point of a response like this. It is one thi=
ng to
>>> rudely point somebody to lmgtfy or an FAQ link. Then you're still b=
eing
>>> rude, but at least you are pointing them in the right direction. Bu=
t
>>> this seems simply to make the list a less pleasant place _and_ to b=
e
>>> totally useless to the original poster. If you didn't want to give =
the
>>> answer, wouldn't it have been better not to respond at all?
>>
>> No.
>>
>> Firstly: My response shows that there are abundant answers, which is=
 a
>> nicer answer to receive than no answer at all.
>>
>> Secondly: I didn't see the point in RE-WRITING all that has been sai=
d
>> on the subject before, and I couldn't be sure that somebody else wou=
ld
>> be willing to do the same too (I figured it was a good idea to suppl=
y
>> at least one response).
>>=20
>> Thirdly: Seriously, at least do some googling first.
>
> I think having answers like yours is much worse than having no answer
> at all. I happen to know how git handles the storage of file
> permissions, but like Jeff I couldn't find anything useful either wit=
h
> some quick searching around.
>
> But it's very useful that the list have a friendly atmosphere where
> people of different technical capability, or those that haven't found
> the right terms to feed into a search engine can ask questions withou=
t
> getting back an answer which at least to me seems very snarky.
>
> There's a tendency in a lot of mailing list to accumulate a
> self-congratulating air from regulars "in the know" where people
> asking questions aren't made to feel welcome. Let's try to not become
> one of those lists.

Peter Kleiwig, I would be most grateful if you could find it in your he=
art
to forgive a poor, misguided, mutton-faced, thistle-bottomed, pig-swivi=
ng,
ale-soused dungball such as myself.

This wretch, I, humbly prostrates himself before the feet of the offend=
ed
in earnest compunction over his unconscionably uncouth utterances; may =
I
next time guard my tongue or, if finding myself unequal to that task, b=
e
so thoughtful as to bite it off, preserve it for at least a year and a =
day
in a barrel of briny liquid most foul, and then=E2=80=94on the coldest =
day of
winter=E2=80=94dispense with it as fodder for the hunger pangs of feral=
 cats!

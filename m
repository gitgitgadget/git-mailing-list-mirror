From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Tue, 24 Mar 2009 11:06:50 +0200
Message-ID: <94a0d4530903240206k6eecdabg2cbb2c5595cd4bc@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
	 <20090323064242.GB1119@coredump.intra.peff.net>
	 <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com>
	 <49C7A8AF.9080500@drmicha.warpmail.net>
	 <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com>
	 <49C899E1.6060809@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:08:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2cS-0007w9-B1
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 10:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbZCXJGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 05:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbZCXJGy
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 05:06:54 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47021 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbZCXJGx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 05:06:53 -0400
Received: by fxm2 with SMTP id 2so2159181fxm.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BZzSYht2VCIYCOy57s8h7nO7XpRpMX3WPkXpwHJeav0=;
        b=wStgNA1IYMkLzlobK90DDeXFHtzdII4XuPZANYmS/K9cNMLvAHDA5wQb4/2zzkzvZV
         Nkugq5mVaXow72bt7AjYbZ3Y+tZ69q67PmlBQfnfIeBsdLHyKNwP0cW6hskRC/sS1y+l
         iPfZP+X//zqlxYKqEetDebp5NfUp8ViOPY4yg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vHM4wKVlrlD0RWKX/5LLdHVU7nflwutttAbj3cy/X+bZb+3UnzbO+GeBUplLyRLqQl
         TPN9v0hVajyKV5CskNw3SQpFtK3+AFLJS2cPRGcBKum5x3Oly7jGxLkyIntY/CZr63RF
         t4+o2zZenGbVTldsoNwn9lQG1IIoRMdMJdSys=
Received: by 10.86.33.10 with SMTP id g10mr4342020fgg.56.1237885610761; Tue, 
	24 Mar 2009 02:06:50 -0700 (PDT)
In-Reply-To: <49C899E1.6060809@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114436>

On Tue, Mar 24, 2009 at 10:29 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 24.03.2009 01:21:
>> On Mon, Mar 23, 2009 at 5:20 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Felipe Contreras venit, vidit, dixit 23.03.2009 11:31:
>>>> On Mon, Mar 23, 2009 at 8:42 AM, Jeff King <peff@peff.net> wrote:
>>>>> On Sun, Mar 22, 2009 at 08:05:15PM +0200, Felipe Contreras wrote:
>>>>>
>>>>>> =C2=A0tt.literal, code.literal {
>>>>>> =C2=A0 =C2=A0color: navy;
>>>>>> + =C2=A0font-size: 1em;
>>>>>> +}
>>>>>
>>>>> Isn't 1em already the default size? Or are you trying to override=
 some
>>>>> other size specification elsewhere? It's hard to tell what the go=
al is
>>>>> because your commit message merely says "improve".
>>>>
>>>> That's correct.
>>>>
>>>> The problem is that when the user has a different size for the
>>>> sans-serif and monospace fonts it looks horrible when they are on =
the
>>>> same paragraph. I thought 1em did the trick, but you are right, it
>>>> doesn't.
>>>>
>>>> It looks like the only way to fix this is to set absolute sizes.
>>>>
>>>
>>> Also, it seems that everything which is not black is blue, except f=
or
>>> terms, which are green and slanted. I don't think that looks nice
>>> together. How about slanted blue?
>>
>> What's wrong with having 2 colors?
>
> I don't mind having 2, they just don't look good together over here, =
on
> my screen and to my eyes...
>
> Right now we have "plain old asciidoc look" which doesn't look that o=
ld
> after all. You pointed out a deficiency, and I'm all for fixing it. I
> just think that introducing new colors is something that may require =
a
> ground up rethinking of the theme being used: make it informative but
> unobtrusive. Also, I'm against over-emphasizing: use slanted or a
> specific color, but not both. Unless one color means emphasizing and
> slanted means file, for example.

Take a look at:
http://people.freedesktop.org/~felipec/git/user-manual.html#bisect-merg=
es

Do you think slanting Z (and the other characters) is enough to emphasi=
ze it?

--=20
=46elipe Contreras

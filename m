From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Mon, 15 Oct 2012 20:09:12 +0200
Message-ID: <CA+EOSBnUxHW2c6r4C6cTn0P_NMAoyJL9jvaG9Du1O8BT-8EVPA@mail.gmail.com>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
	<CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 20:09:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNp6T-0000mP-Cu
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 20:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087Ab2JOSJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 14:09:14 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52499 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab2JOSJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 14:09:13 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so8296866iea.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=FMtdLaGnRoK2GMFhq2UH7Drmo2g9MiY41Rye3g5C5N0=;
        b=v5jOmfd9CYf5AEa9jO6BeFLvmoBoCZPk2xNcZzU6MdTxZOsG40AbDzqJ19YTPjMxd6
         nxyEv+N0eEkzymQeXnkvPbvn4onbdW9VuZTQvHY7jtvZpk+9rTSvrfCHjpLu9oACM2Oh
         trIdTusd1VWKmhlS4ClWV/mB1JmuTpvWVpUBAKya3qTDOPgc6s/BTmoBWaTIVg0O0OBA
         WqBhqCktrA5Xz7SfAB3yOMxspJIvBhp4fqBvpwpSdj7xtxXcCdJgGEOpVJsEydGcy8Ui
         PFdOIvetRnpqKPRblpEPMS12VwVxaZHwvRVvFNiT8jhxxkfRPHsqWHmbOuMFbE06dd6K
         kUNQ==
Received: by 10.50.236.39 with SMTP id ur7mr9464844igc.26.1350324552981; Mon,
 15 Oct 2012 11:09:12 -0700 (PDT)
Received: by 10.64.48.37 with HTTP; Mon, 15 Oct 2012 11:09:12 -0700 (PDT)
In-Reply-To: <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207769>

2012/10/15 =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>:
> On Mon, Oct 15, 2012 at 6:42 PM, Elia Pinto <gitter.spiros@gmail.com>=
 wrote:
>> Very clear analysis. Well written. Perhaps is it the time to update
>> http://git-scm.com/book/ch6-1.html (A SHORT NOTE ABOUT SHA-1) ?
>>
>> Hope useful
>>
>> http://www.schneier.com/crypto-gram-1210.html
>
> This would be concerning if the Git security model would break down i=
f
> someone found a SHA1 collision, but it really wouldn't.
I know perfectly.
>
> It's one thing to find *a* collision, it's quite another to:
>
>  1. Find a collision for the sha1 of harmless.c which I know you use,
>     and replace it with evil.c.
>
>  2. Somehow make evil.c compile so that it actually does something
>     useful and nefarious, and doesn't just make the C compiler puke.
>
>     If finding one arbitrary collision costs $43K in 2021 dollars
>     getting past this point is going to take quite a large multiple o=
f
>     $43K.
>
>  3. Somehow inject the new evil object into your repository, or
>     convince you to re-clone it / clone it from somewhere you usually
>     wouldn't.
>
> At some point in the early days of Git Linus went on a rant to this
> effect either on this list or on the LKML.
>
> Maybe it would be useful to include some of that instead?
>
What you wrote is a risk analysis. I appreciate, i am also a  security
professionals..
> It would be very interesting to see an analysis that deals with some
> actual Git-related security scenarios, instead of something that just
> assumes that if someone finds *any* SHA1 collision the sky is going t=
o
> fall.
What you wrote is a risk analysis. I appreciate, as security profession=
als, too.

I agree, of course. However, it is totally different from saying that
because exists the birthday paradox git will be immune to collision,
sure, if caused by a cryptographic attack. But clearly the risk for a
project that uses a cryptographic hash function as a hash function, as
git, is zero in the absence of a real use case. In computer security
the use of encryption is hardly the point of attack, today, as you
have clearly said. But it is the most invisible to highlight.

It seemed interesting to quote here the Bruce article because the
topic has already been discussed in the past here. That's it. No more,
no less.

Thanks

Best Regards
Best Regard

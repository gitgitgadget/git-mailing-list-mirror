From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Subject: Re: Problem with "From:" line on "git format-patch" generated patches
Date: Tue, 3 Nov 2009 16:06:39 -0200
Message-ID: <b8bf37780911031006q4bc4c487xd9db86eb0fa531e7@mail.gmail.com>
References: <b8bf37780911030830l42ea6dc2v3ef66e2a9e1ca281@mail.gmail.com>
	 <adf1fd3d0911030902x15faffcen86644733ffda43d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Nov 03 19:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5NmJ-0003sy-W2
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 19:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbZKCSGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 13:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbZKCSGf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 13:06:35 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:53958 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZKCSGe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2009 13:06:34 -0500
Received: by vws30 with SMTP id 30so1673466vws.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 10:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=svoQyXNi6aujCjlTRskMVGhmLqSpDMNWf9utH34G7Oo=;
        b=uPgvjRUdjbZU8Sr7OZVFpivQaFooqbuxRIWZWltOyjVMs1X5wouwvYTYnAJJCet/K2
         ovs+ThZXjLUxa72MmfQ+z9uFOU406/or1SQWS9tpISuVXtLSnkzKWefglwRqASOGeDIj
         6gIgDq1O6ym5Nn/Rhy5DooP/uOiuTPICP1CgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EUFeFauwH7Dw3of+PQLTKan5M4sj17+BsRP5r3JJW+tmD38ckg0z/5S1LTl9zTUryV
         iz1gd/oz4L2jW17ebmA2932HZyX78CddMzn5pspmL2Kp2RiiavT6NnR7uxi0bpkZVJtr
         ag01KC3hzLRQc7Wy5hUE1IHd2vz+KBbyCYkxU=
Received: by 10.220.126.155 with SMTP id c27mr407675vcs.21.1257271599457; Tue, 
	03 Nov 2009 10:06:39 -0800 (PST)
In-Reply-To: <adf1fd3d0911030902x15faffcen86644733ffda43d5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131982>

On 11/3/09, Santi B=E9jar <santi@agolina.net> wrote:
> On Tue, Nov 3, 2009 at 5:30 PM, Andr=E9 Goddard Rosa
> <andre.goddard@gmail.com> wrote:
>> Hi, everybody!
>>
>>    When I generate patches using "git format-patch" it always makes
>> my name garbled in the "From:" line
>> as shown below. I'm using openSUSE 11.2 RC 1 (x86_64) with the
>> following settings:
>>
>>        # locale charmap
>>        UTF-8
>>        # echo $LANG
>>        en_US.UTF-8
>>
>>    I've tried changing my environment to use another encoding like
>> ISO-8859-1, but it didn't work as well.
>>
>>    Does someone can explain why does this happens? Any suggestions?
>>
>> P.s.: the problem never occurs on the commit message (Signed-off-by)
>>
>>>> >From 584d9bfc7c1d41b76a05655b4562b98fcbef6ee4 Mon Sep 17 00:00:00=
 2001
>>>> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Goddard=3D20Rosa?=3D <andre.g=
oddard@gmail.com>
>>>> Date: Sun, 1 Nov 2009 14:09:06 -0200
>>>> Subject: [PATCH v2 7/7] vsprintf: factor out skip_space code in a
>>>> separate function
>>>> MIME-Version: 1.0
>>>> Content-Type: text/plain; charset=3DUTF-8
>>>> Content-Transfer-Encoding: 8bit
>
> This is the normal encoding for email headers where you cannot use
> 8bit characters. You have to use a 7bit characters with this
> =3D?UTF-8... encoding.
>
> You can check the From: line in your mail, the mail I'm replying:
>
> From:	=3D?ISO-8859-1?Q?Andr=3DE9_Goddard_Rosa?=3D <andre.goddard@gmai=
l.com>
>
> At the other hand the tools using the output of git-format-patch must
> deal with this all, as they do. git-am handles it well, if not it's a
> bug that should be reported.
>

Great, Santi!

     I really appreciate your reply!!!

    I was just in the process of debugging this issue when I landed
into function pp_user_info(), which calls add_rfc2047(). So I started
looking into http://www.faqs.org/rfcs/rfc2047.html , which specifies:

"Generally, an "encoded-word" is a sequence of printable ASCII
characters that begins with "=3D?", ends with "?=3D", and has two "?"s =
in
between."

Ok... I got it; it's necessary for proper signaling of the email
header when it detects the presence of certain characters outside the
ASCII range 0..127 (7 bits). It's the case for latin "=E9" letter in my
name.

So, let me explain what happened to me:

I'm not using any specific tool for inputting the git-format-patch,
but instead I'm sending the files generated by it through gmail as an
inlined patch in the email body.

I like the convenience of format-patch for generating the patch files,
but in this case, formatting the header as rfc2047 is not necessary
and makes a funny/garbled output in my patch submission.

Do you have a suggestion for my workflow?

Thanks a lot,
Andr=E9

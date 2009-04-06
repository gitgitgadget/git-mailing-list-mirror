From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Broken umlaut in my name, again
Date: Mon, 6 Apr 2009 15:40:35 +0200
Message-ID: <adf1fd3d0904060640k3fcac0d5oc09dde7ebd430231@mail.gmail.com>
References: <20090331153039.GA1520@atjola.homenet>
	 <20090406114618.GF20356@atjola.homenet>
	 <adf1fd3d0904060546j6c2fbba9r75829f2bd383458b@mail.gmail.com>
	 <20090406131747.GH20356@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:42:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqp5b-0002Im-Ln
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435AbZDFNkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 09:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbZDFNkj
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:40:39 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:34097 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbZDFNki convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 09:40:38 -0400
Received: by bwz17 with SMTP id 17so1878499bwz.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 06:40:35 -0700 (PDT)
Received: by 10.223.119.5 with SMTP id x5mr3760315faq.40.1239025235381; Mon, 
	06 Apr 2009 06:40:35 -0700 (PDT)
In-Reply-To: <20090406131747.GH20356@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115824>

2009/4/6 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.04.06 14:46:43 +0200, Santi B=E9jar wrote:
>> 2009/4/6 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>> > On 2009.03.31 17:30:39 +0200, Bj=F6rn Steinbrink wrote:
>> >> While it makes no sense to map some email address to an empty one=
, doing
>> >> things the other way around can be useful. For example when using
>> >> filter-branch with an env-filter that employs a mailmap to fix up=
 an
>> >> import that created such broken commits with empty email addresse=
s.
>> >>
>> >> Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
>> >
>> > The umlaut (=F6) in my name is broken in the commit that made it i=
nto
>> > git.git --> 5288dd58356e53d61e2b3804fc7d8d23c3a46ab3
>> >
>> > Last time this happened when I used format-patch -s instead of com=
mit -s
>> > IIRC. But since then, I pay attention to do the sign-off via commi=
t -s,
>> > yet my name is broken again. What did I do wrong this time?
>>
>> I don't see nothing wrong in your mails. It appears to be a double
>> conversion to UTF-8 between the mail and the commit.
>>
>> But I always use format-patch -s without problems, what was your
>> problem with format-patch?
>
> I don't recall the exact problem, and I can't find the mails anymore,
> the IIRC it was something about Content-type being generated from the
> original commit message, and only afterwards the sign-off line got
> added, or something like that. That causes the Content-type to say
> ascii, although the sign-off had UTF-8 in it. Or something like that.
> Might very well have been fixed since then

Yes, it is fixed (at least what you described).

> (it was almost 2 years ago
> that I hit that bug IIRC),

Uf! half an eternity in git scale ;-)

Santi

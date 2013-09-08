From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Sat, 7 Sep 2013 20:27:04 -0500
Message-ID: <CAMP44s2+nHEOupOa79EpDSLZeZhwQrT380r4KzVL9xAb1hzvMg@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
	<b677f1ae-662f-4728-b625-189bc392c74d@email.android.com>
	<CAM9Z-nmLQUrJk73pi_0a1_ccGMnqU_t=uOZze622_GEtWfMvQQ@mail.gmail.com>
	<CAA01CsqNKMqExq1PYanotzQ-wTcf=7c5BQ_49xGu4QasXSCoeQ@mail.gmail.com>
	<CAM9Z-nnGV4hMG1bAY9u+U+qU5vwi95RWFLj2-75AQUZc5mQDtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 03:27:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VITmS-0002xY-DZ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 03:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130Ab3IHB1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 21:27:08 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36988 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab3IHB1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 21:27:06 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so4001815lbi.11
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 18:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=80fT7tCTunDGJ0yn/STQkCaK0aljiBUldr9VSc+v2cs=;
        b=QPln8AUzW3IIWiQX74E/O8OgQv4ppykQBxjtp2GY81MiO8XumxAWcSP7OLK+Lv8+tk
         tdjdATyL6cxxQy9du2hIZmCiWU847F+/XcI5+Q/2HYXG3nb798O09H9WfbP43ZJ3Ui48
         3P0MgBAV3c54L4Y/jY/WVh6y9Qp5dncB2bWOf3dtmowo9yQU2mmqu5K1Kk9ww6HkJdzz
         e1L1NL7hYK+g0gph2YknmKt/n8ultMMZnd5m2WTfhICTJMnq8XLLVMG42asc1lw129vb
         +pE3jyb+XxkbJgbBXh8qybGiR2nNFRmhHghBrm7AQNCmrSwwBRiabMHcHFiX0BJA0jit
         6+mw==
X-Received: by 10.112.128.166 with SMTP id np6mr9715751lbb.7.1378603624462;
 Sat, 07 Sep 2013 18:27:04 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 18:27:04 -0700 (PDT)
In-Reply-To: <CAM9Z-nnGV4hMG1bAY9u+U+qU5vwi95RWFLj2-75AQUZc5mQDtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234158>

On Wed, Sep 4, 2013 at 8:36 AM, Drew Northup <n1xim.email@gmail.com> wrote:
> On Wed, Sep 4, 2013 at 3:13 AM, Piotr Krukowiecki
> <piotr.krukowiecki@gmail.com> wrote:
>> Just wanted to point to a Dr. Dobb's article from Monday:
>> http://www.drdobbs.com/tools/getting-started-with-git-the-fundamental/240160261?pgno=2
>>
>> The author does not use the use the word "index" at all. Instead he
>> writes in following way:
>>
>> ---------------------------------------------------------------------------------------
> <DR DOBBS QUOTE>
>> ---------------------------------------------------------------------------------------
>>
>>
>> Sorry for not responding to your comments Drew, no time at the moment.
>
> NP. What he writes [in that quote at least] is entirely reasonable. In
> fact, oddly enough (as I presume you meant it as a refutation), it can
> be seen to support my argument: don't mess with the core code much (if
> at all) but fix the documentation. That's all that I've been arguing
> since day one. We don't need to make big huge changes in every part of
> the Git metaphor set to better explain what is going on to newbies and
> casual users.

But he is using the term "staging area", forget about my patches to
the code, are you agreeing we should fix the documentation to use the
term "staging area" as Dr. Dobb did?

> (Aside from the fact that there's a huge body of
> existing documentation, tools, and usage patterns that depends on the
> currently predominant model.)

Most of the online documentation doesn't use the term "index", they
use "staging area", as the link just described above.

> I still argue that for a not insignificant group of users--people who
> are happy with the current paradigm and therefore aren't making a lot
> of noise--the current core metaphor is actually useful despite the
> name being more than just a tad bit unfortunate. Alas, for dealing
> with some of the advanced usage explanations it can be argued that the
> "staging area" metaphor (it implies _completed_ bundles ready to
> package into commits and ship--I envision shipping trailers being
> filled with _immutable_ boxes and attached to trucks) is actually
> harmful, but we can talk about that if there's a need.

Nobody thinks of the staging area that way, just you.

The staging area is an area that contains the preparation for the next
commit to be made. There's no ships, or trailers, or bundles.
Everybody understands that, and find the term "staging area" fit for
that description. Except you.

-- 
Felipe Contreras

From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 19:46:38 +0200
Message-ID: <CALbm-Ea4oAQ+JsYu6Zo06ONMbtp8AhgFqDC485BRKsM36EVQXw@mail.gmail.com>
References: <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
	<53588713347b7_59ed83d308cf@nysa.notmuch>
	<CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
	<53588f448d817_59ed83d3084e@nysa.notmuch>
	<CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
	<5358bae8ab550_1f7b143d31037@nysa.notmuch>
	<877g6fb2h6.fsf@fencepost.gnu.org>
	<5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
	<20140424134106.GA27035@thunk.org>
	<CALbm-EbBj1hCF=rFfeBbzeVmffRHVEEE=HSbVZxw-=-=p2BvEQ@mail.gmail.com>
	<20140424154717.GB7531@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>, David Lang <david@lang.hm>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 24 19:46:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdNjR-0001wx-Jy
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 19:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758262AbaDXRql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 13:46:41 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:63377 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688AbaDXRqk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 13:46:40 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so1493095wiv.3
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 10:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MUhjJPY06CprbPgpBc2EM+ivr9NcAGGTVMfmd4TOdz8=;
        b=xovrnfo0hphFfnMAsEwyC7vt3Lm+qX32M2xeclAlyqBYm1m2eJNBREetOR01jJa9ac
         F//lBt85EJxW5HLoaqm0eg1e35PQUFmTCwMfWE2bHoPLQZU1C4GCqfhv4COrKOjryRZt
         k0AoxHLigMR5MJeusNQsmI8pTuD9UmsPOJgMJt3hKzriw6nLEysr8KxLYeLplOU6fiQ3
         655IUgG5MUQb0hA+df5XJsDA9muMZwfgRvyAwC2ndfCY4qNbwziUMBEDG97e+IioF1Ex
         JBkSLKsb+b0uVz7OPp4gMLV+/knVd8Yc9tiYyhxzG6O9BY5hx+pUQXH+U48RfjQu8q05
         DClw==
X-Received: by 10.180.19.167 with SMTP id g7mr82074wie.46.1398361598775; Thu,
 24 Apr 2014 10:46:38 -0700 (PDT)
Received: by 10.180.94.166 with HTTP; Thu, 24 Apr 2014 10:46:38 -0700 (PDT)
In-Reply-To: <20140424154717.GB7531@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246982>

I may have missunderstood.

So today you cannot commit if you don't provide an email address
(usually the first time you try to commit, git asks to "git config
--global author.email=<you@mail.here>"), if I remember correctly, so
there is definitely a valid (i.e. user approved) email address.

2014-04-24 17:47 GMT+02:00  <tytso@mit.edu>:
> On Thu, Apr 24, 2014 at 05:00:13PM +0200, Stefan Beller wrote:
>> > I don't even think we need to query the user to fill out all of the
>> > fields.  We can prepopulate a lot of the fields (name, e-mail address,
>> > etc.) from OS specific defaults that are available on most systems ---
>> > specifically, the default values we would use the name and e-mail
>> > address are not specified in a config file.
>>
>> Please don't. Or you end up again with Commiters like sb@localhost,
>> sbeller@(None) or alike. I mean it's just one question once you setup
>> a new computer, so I'd really like to see that question and then
>> answer myself (at university/employer I might put in another email
>> address than at home anyway, and I'm sure my boxes have no sane
>> defaults)
>
> But that's no worse than what we have today.  What if we print what
> the defaults were, which might help encourage the user to actually run
> the "git config -e" command?
>
>                                         - Ted

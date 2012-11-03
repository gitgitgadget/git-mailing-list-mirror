From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Wrap commit messages on `git commit -m`
Date: Sat, 3 Nov 2012 14:51:02 -0400
Message-ID: <CABURp0qbX53=bnVDYNmsSixiL+G6B0dg2o8=HR-J4JNanndROw@mail.gmail.com>
References: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
 <m3a9v170ca.fsf@black.gullik.net> <CAO54GHDRBDyQYvo-g_xEvsQJRgtfbbT-4-kop8hoSK1D37G44w@mail.gmail.com>
 <20121101221203.GE6213@elie.Belkin> <CALkWK0n3nvu4neica==bXaGCtDish8cfUhcsmJT0w3ihrq6coA@mail.gmail.com>
 <20121103063855.GA8326@elie.Belkin> <CAJDDKr4ta2Xu5zO6yASSNewZXxu=LWuNO0zU8YnSP4Kq9ZJn-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, Kevin <ikke@ikke.info>,
	=?ISO-8859-1?Q?Lars_Gullik_Bj=F8nnes?= <larsbj@gullik.org>,
	git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 19:51:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUiok-0003Db-96
	for gcvg-git-2@plane.gmane.org; Sat, 03 Nov 2012 19:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab2KCSvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 14:51:25 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:52860 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab2KCSvY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 14:51:24 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3271814lag.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rDZ8Xjp/s92JSYu9dpRed2mhltc12jOVZ+DytB/nyDI=;
        b=V02WJpCxe3iH8shUF9BlAhAcJGwhMJaZsPeHlmvt5rZ69/08eS0QUr0pJg11zu++/D
         EVaYA/PRB+wjB+vmACdPOBFIXPJbPQLUzy49srUEysUAWbS0L5g6hIw5VxNHX2NH20Ts
         UGY7dDR7pebaiBGb172Lva5HgbX73yvBPlGEHFOEXTXkfq3A/R6kDDPWKg4dyQl+Fnpl
         Z20bqW5lwRvzoY2ztfiiseqx7U7qSN8rDIVq523ybfKyFr08XSrpddh1Rth3/Zy7mw7l
         fBroOYnP13g39+qPaxcfSZRWql8QD4D2pquO0w8fU87P8IBaxPZZzq+m7P90OXUBI6mL
         tMOg==
Received: by 10.152.47.97 with SMTP id c1mr4784685lan.37.1351968682926; Sat,
 03 Nov 2012 11:51:22 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Sat, 3 Nov 2012 11:51:02 -0700 (PDT)
In-Reply-To: <CAJDDKr4ta2Xu5zO6yASSNewZXxu=LWuNO0zU8YnSP4Kq9ZJn-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208982>

On Sat, Nov 3, 2012 at 3:41 AM, David Aguilar <davvid@gmail.com> wrote:
> On Fri, Nov 2, 2012 at 11:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Ramkumar Ramachandra wrote:
>>> Jonathan Nieder wrote:
>>
>>>> Ram, what platform do your colleagues use?
>>>
>>> Red Hat Enterprise Linux 5.
>>
>> Oh, ok.  In that case I blame habit.
>>
>> I think the best option you have is to just complain to your
>> colleagues about the long lines.  Then they would get a chance to
>> explore what the UI currently offers and to complain to this list
>> (perhaps via you :)) about missing features that would make their work
>> easier.
>>
>> To put it another way: I don't see yet how a hypothetical "git commit
>> --wrap-lines -m 'long message'" would make life easier than just
>> running "git commit" and entering the message using $EDITOR.  There's
>> probably a UI or documentation bug lurking somewhere, so thanks for
>> thinking about these things.
>>
>> Regards,
>> Jonathan
>
> If your colleagues do not mind using a GUI then git-cola
> might help them form better commit messages.
>
> It auto-wraps long lines and enforces a very clear distinction
> between the one-line summary and extended description.

vim also does this nicely with syntax highlighting turned on, though I
do not know how this feature is triggered.

Specifically, it wraps all lines at 72 characters; it colors line 1
yellow out to 50 characters and white after that; and it colors any
text on line 2 with a red background (should be empty).

Phil

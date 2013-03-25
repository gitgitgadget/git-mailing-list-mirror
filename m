From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Mon, 25 Mar 2013 23:57:34 +0530
Message-ID: <CALkWK0kx_uQy-97nByNXBOU4UruhvdjOeXCpKHR9mNUQHs5o=A@mail.gmail.com>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 <7v38vjz7sx.fsf@alter.siamese.dyndns.org> <CALkWK0mRnDMFLeVoG85CUZ48rf7X_jHV=0XP73WL7zp2OGpezQ@mail.gmail.com>
 <20130325182023.GA1414@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 19:28:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKC8B-0005V3-2u
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 19:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871Ab3CYS15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 14:27:57 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43795 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207Ab3CYS1z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 14:27:55 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so3330631ieb.8
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=0Ew9b/Xmzkov/skQl4DKpalDpMz62nzZDiGmH7w8SlQ=;
        b=i/zBttp6bEmnfTN69hFCkHlLzKKe5OH6TSpJcL0dWprsLvrLBv75sv/s0ezF7IdZRK
         GiXCIHP4TZfGwA16YG56dJ+9Sdfqu0uINT2aqMM8PRUP8Rk348eaFiyRAsmlKhbOmuuI
         NMNcDPTOsz6UPLkFeIzPR2jk4x7gnlMAj2nHc/BRR9GxgA75CY2wY5gbwWj0H/rZJs2F
         6GQljwpY2tYFrRIUnFTrzgQL78pnVYydOmzZlw9FpGwhbWNCs9H9yQWHIBl7bpGXXStY
         1iRiaqSpxLX5vQa9b63XJ4T6OtlNnIBw+403aypCajUMhziIlRECLiYI30vNTbPSTfRG
         4m2w==
X-Received: by 10.50.50.71 with SMTP id a7mr12006878igo.14.1364236075201; Mon,
 25 Mar 2013 11:27:55 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 25 Mar 2013 11:27:34 -0700 (PDT)
In-Reply-To: <20130325182023.GA1414@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219061>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>> Junio C Hamano wrote:
>>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>>>> Git 2.0 is coming soon, so I'm excited about breaking a lot of
>>>> backward compatibility ;)
>>>
>>> Don't.
>>
>> push.default is the necessary exception?
>
> A while ago there was a discussion of changes of the "If we were
> starting over today, it would be obvious we should have made it work
> the other way" kind and potential transition plans for them leading up
> to 2.0.  It's way too late to throw new breakage in.
>
> More generally, it doesn't make a lot of sense to save thinking about
> such questions for the last minute before a new major release.  If an
> important change will require breaking compatibility and can only be
> done using a painful 5-year transition, start today (and send patches
> to the ML when an appropriate quiet moment comes to get review) so the
> 5-year counter can start ticking.

I agree that big important changes that break backward compatibility
(like adding generation numbers to commit objects) will require this
kind of time and effort to stabilize.  Does a saner push.default
value, or even tweaking the output of 'git status' to show what 'git
status -sb' shows now (git status is porcelain, and no person in the
right mind will write a script to parse it), require this?  I'm
talking about slightly better defaults at the porcelain level, at
most.

From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 17:00:13 +0200
Message-ID: <CALbm-EbBj1hCF=rFfeBbzeVmffRHVEEE=HSbVZxw-=-=p2BvEQ@mail.gmail.com>
References: <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
	<20140422213039.GB21043@thunk.org>
	<alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
	<53588713347b7_59ed83d308cf@nysa.notmuch>
	<CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
	<53588f448d817_59ed83d3084e@nysa.notmuch>
	<CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
	<5358bae8ab550_1f7b143d31037@nysa.notmuch>
	<877g6fb2h6.fsf@fencepost.gnu.org>
	<5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
	<20140424134106.GA27035@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>, David Lang <david@lang.hm>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 24 17:00:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdL8T-0006ut-BW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 17:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757972AbaDXPAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 11:00:17 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:61758 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756849AbaDXPAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 11:00:15 -0400
Received: by mail-wg0-f49.google.com with SMTP id a1so2418203wgh.32
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yiIUAYONmuroI2Nv232xF0AaQe8Oe6xaE7DbsIfqhfo=;
        b=ds8Qg8toCkdTCiAjv2Qqe+86Eh4BoxsvqysLXG1wwFC4PlXGIrNTGdYX2bzGEZdpwt
         tB7W/DCUJeaO4ntRgekRVHML8iM0dlcLr9H5vpNB7rdM3aNCNP8m3Rx5kTGfyxXYSepI
         5fMtx0WGva/mvpTvmqIgVe0xblE778iLR+f2PtQg5Ev3PgnmIvyQyNy+E+is3nLsKtwd
         zEX9fz/pa7z/HBQY0M4+AYXec6/n2l0AI7wUsO8I5VxfLb8LZ7vZGYQVSBrZaheKRNUA
         2FzxX2w/HAiLUAsrqp4eUci6171F9o4H97Kzdi2zLOPwwkkPc3NMu/omCbzkYQUgBMmH
         BPfg==
X-Received: by 10.194.89.168 with SMTP id bp8mr1594590wjb.73.1398351613711;
 Thu, 24 Apr 2014 08:00:13 -0700 (PDT)
Received: by 10.180.94.166 with HTTP; Thu, 24 Apr 2014 08:00:13 -0700 (PDT)
In-Reply-To: <20140424134106.GA27035@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246971>

> I don't even think we need to query the user to fill out all of the
> fields.  We can prepopulate a lot of the fields (name, e-mail address,
> etc.) from OS specific defaults that are available on most systems ---
> specifically, the default values we would use the name and e-mail
> address are not specified in a config file.

Please don't. Or you end up again with Commiters like sb@localhost,
sbeller@(None) or alike. I mean it's just one question once you setup
a new computer, so I'd really like to see that question and then
answer myself (at university/employer I might put in another email
address than at home anyway, and I'm sure my boxes have no sane
defaults)

2014-04-24 15:41 GMT+02:00 Theodore Ts'o <tytso@mit.edu>:
> On Thu, Apr 24, 2014 at 03:23:54AM -0500, Felipe Contreras wrote:
>>
>> There is evidence for the claim that there won't be those problems. You have
>> absolutely no evidence there there will.
>
> Felipe,
>
> It's clear that you've not been able to produce evidence that can
> convince most of the people on this thread.  Simply repeating the same
> assertions over and over again, in a shrill fashion, is not likely to
> convince those of us who that this would not be a good idea for git
> v2.0.
>
> Creating a ~/.gitconfig file if one doesn't already is one I agree
> with, and at least on Unix systems, telling them that the config file
> lives in ~/.gitconfig, or where ever it might happen to be on other
> platforms, is a good one.  If it's in some really weird place on
> Windows, then sure, we can tell them about "git config -e".  But the
> point is to let the user look at the default .gitconfig file, where we
> can put in comments to help explain what is going on, and perhaps have
> links to web pages for more information.
>
> I don't even think we need to query the user to fill out all of the
> fields.  We can prepopulate a lot of the fields (name, e-mail address,
> etc.) from OS specific defaults that are available on most systems ---
> specifically, the default values we would use the name and e-mail
> address are not specified in a config file.
>
> We can just tell the user that we have created a default .gitconfig
> file, and tell them how they can take a look at it.
>
> In the long term, if the worry is how to bridge the gap between
> complete newbies, one way of dealing with this is to have a tutorial
> mode (off by default, on in the default .gitconfig) which despenses
> some helpful hints at certain strategic points (i.e., after five
> commits, give a message that introduces git log --oneline, after the
> third merge commit is created by the user, give a message which
> introduces git log --merge, and so on).  The challenge is not strawing
> over the line to the point where the hints become as annoying as
> "clippy", but that is what UX labs are for, to tune the experience for
> completely new users to git.
>
> Without doing a formal UX experiment, all of us are going to making
> assertions without formal evidence --- at best some of us who have
> tutored a few newbies might have some anecdates, but remember the old
> saying about the plural of anecdote not being data.
>
> Cheers,
>
>                                                 - Ted
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

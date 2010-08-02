From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: new platform & S_IFGITLINK problem
Date: Mon, 2 Aug 2010 16:11:39 +0000
Message-ID: <AANLkTikcLk_W_guvBd3s15CY9xz6utmZASb67ndbt4=o@mail.gmail.com>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
	<7vfx2b2ft5.fsf@alter.siamese.dyndns.org>
	<1279815812.7796.5499.camel@jetpack.demon.co.uk>
	<7vwrsjcvx6.fsf@alter.siamese.dyndns.org>
	<1280080833.3622.4772.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.co.uk>
X-From: git-owner@vger.kernel.org Mon Aug 02 18:11:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfxcA-0003NW-4G
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 18:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab0HBQLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 12:11:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36212 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab0HBQLj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 12:11:39 -0400
Received: by yxg6 with SMTP id 6so1315595yxg.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=6wCBvQOOlHDtFeRNqB3SdJMMJtonlXORRb0I3+RdYbs=;
        b=DpYixY8wLJym9QzBnAajJd7jv5jrKVPbzpIsWVSnEqfHfY5S1kyoUdM7ckjN0AmauE
         9zZ5WMWKhkyHsJs0sya8kG8WVhbVqHy9wK1NKsHbWggPZAy8AKm0kn3y+EpBF/PFvQcc
         S2JFv+U0VIU9gPnPFe5Ju205TivtWV292iZP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WB4RqQGlzef8tcrKX2AeH/Qf0sQzeL+7sOKTEk1FUIgNozh555TvoHSThN5IT4S0I3
         s4mAfplMzXWvYRx8b9BBNcWTqBjjsP/nCl6M/03QAdvytTeH5dy0hlZH3CtsO4qxGZqv
         p9LODscIJwqPnjNGcbDJho64uFJds34ccgzug=
Received: by 10.100.50.33 with SMTP id x33mr6472814anx.79.1280765499229; Mon, 
	02 Aug 2010 09:11:39 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 2 Aug 2010 09:11:39 -0700 (PDT)
In-Reply-To: <1280080833.3622.4772.camel@jetpack.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152420>

On Sun, Jul 25, 2010 at 18:00, Alan Hourihane <alanh@fairlite.co.uk> wrote:
> On Sun, 2010-07-25 at 10:29 -0700, Junio C Hamano wrote:
>> Alan Hourihane <alanh@fairlite.co.uk> writes:
>>
>> > Is there any ETA on fixing this up ?
>>
>> I don't think so, as I didn't see anybody who has a testable system
>> volunteered to do this nor heard that somebody started doing it.
>
> O.k. Looks like I'll have to take it on over the long term.

I've been adding smoke support to Git so that you could set up a cron
job that automatically sent us failure reports on your platform. Then
someone could fix this without your help.

Here's the preliminary smoke patch:

    http://github.com/avar/git/compare/git:pu...git-smoke-v2

Would you be willing to run a smoker on FreeMiNT?

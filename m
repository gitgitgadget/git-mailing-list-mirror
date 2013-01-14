From: =?windows-1251?B?0fLu6ffuINHr5e/27uI=?= 
	<stoycho.sleptsov@gmail.com>
Subject: Re: git list files
Date: Mon, 14 Jan 2013 19:20:04 +0200
Message-ID: <CAGL0X-p2D90aNTzAHLoz0xnU3AAR-vUEPDAoRkyd9k+8_Kc0Vg@mail.gmail.com>
References: <CAGL0X-rfrwtbtdN7O0=iMhVRYv1m0_czW8zmgT5QA3irkaeu5Q@mail.gmail.com>
	<20130113175602.GD5973@elie.Belkin>
	<20130113201027.GA4436@sigill.intra.peff.net>
	<20130114070832.GA4820@elie.Belkin>
	<20130114152836.GA18370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 14 18:20:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuni1-0005w3-Gj
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 18:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756953Ab3ANRUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 12:20:07 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:60521 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab3ANRUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 12:20:06 -0500
Received: by mail-la0-f52.google.com with SMTP id fq12so4062475lab.25
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 09:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5QrKiydmzR5NzIQnM/YDCImC1txoKuDerLcQP9MIaPk=;
        b=Vl9YTTrkgrYWkwH3zpKK0H2ucRNQDSEZp63OXbJ5a/K0+USQkSrY8jfkX+fMv3FuwM
         nl8LxdqwN9kG6pomrdfYLT+hOr3D7u9lNOqpijI/IQbNVELLwuvSdk0vYCZ+ijuVydrs
         Ce8NRfx2nsrcxf/w6CytkKKO6S5Vk1IBwtJxdrn+AOu3OjkcB2G3OpebfLJerEJBeyq7
         5Rw98bOnsSwKyxy+uV2IPvARGRCE692aY7sgd+rrDKzpW1hvdtV9i2iPRpZxB/ZFAh2S
         qsLBVSqEUd1rJHGREOBcIDZUOiYFf8v6MHD5QMWPgYip1ppp6SXuzB36LuLMiRd5bGZ8
         fbrQ==
Received: by 10.112.82.166 with SMTP id j6mr35411674lby.25.1358184004222; Mon,
 14 Jan 2013 09:20:04 -0800 (PST)
Received: by 10.112.60.36 with HTTP; Mon, 14 Jan 2013 09:20:04 -0800 (PST)
In-Reply-To: <20130114152836.GA18370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213503>

I went through your initial thread about blame-tree,
and it is really very very (+very) close to answer my question.

Thanks for writing it,
if it comes one day to git, I will use it.

As for:
'I guess people's eyes and brains are trained by the old school "file
boundaries matter" way of thinking'
-- Junio C Hamano
at http://thread.gmane.org/gmane.comp.version-control.git/168323;
http://article.gmane.org/gmane.comp.version-control.git/168333

I think it's not the case, Mr. Hamano.

>From my point of view, it is just to have a quick picture of "what
came from where in this current directory",
which is a normal reaction of human beings, I think.

Speaking of which I can't help thinking that this feature could be
provided by $git rev-list (HEAD) --no-walk -- <paths>, just don't stop
at first commit,
but at first commit for each of the paths.

Or maybe diff could have an option to not compare against a specific point,
but actually do his job and go downstears and find where the
_diff_erence for _each_ path happened finally.

(... applicable for $git status -l (--list) --porcelain ... but thats
a whim, sorry.)

Anyway,
thank you all for your time, it was a real pleasure for me,
Blind.

2013/1/14 Jeff King <peff@peff.net>:
> On Sun, Jan 13, 2013 at 11:08:32PM -0800, Jonathan Nieder wrote:
>
>> Jeff King wrote:
>>
>> > As far as I recall, that script works. However, I have a pure-C
>> > blame-tree implementation that is much faster, which may also be of
>> > interest. I need to clean up and put a few finishing touches on it to
>> > send it to the list, but it has been in production at GitHub for a few
>> > months. You can find it here:
>> >
>> >   git://github.com/peff/git jk/blame-tree
>>
>> Oh, neat.  Would that make sense as an item in
>> <https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools>?
>
> I'd rather finish cleaning it up and actually get it merged. It's on my
> todo list.
>
> -Peff

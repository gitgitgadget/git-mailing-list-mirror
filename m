From: Bart Massey <bart@cs.pdx.edu>
Subject: Re: parsecvs has been salvaged
Date: Fri, 11 Jan 2013 10:25:47 -0800
Message-ID: <CAA6gtpnDrVOfiX-bQFS2X91wsS705b60YST8DwuDaibjkYU9vg@mail.gmail.com>
References: <20130111112151.AFF924047B@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Keith Packard <keithp@keithp.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:26:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtjJY-0006Nl-6M
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 19:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab3AKS02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 13:26:28 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:47030 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab3AKS01 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 13:26:27 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so2667300iec.41
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 10:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=M9giP+VASYxgaheDu2yFK+NUW7frdPXE+qmWUWqPahg=;
        b=z27DsbnHfiYeN/wklxO+66c2yYuGzI9+gYKlN3oUTRo8q1KE2saKSCELKxawXpoC8M
         keiCdY2cNzL/4j7lQ0m4mk4cVbbvboPLogphKQblWbhm+VQ88LITh+f1MBdahVO+200z
         h3G6BiLA54SQGT94mqANFhUUMXpWeKHkVx+KtvPry2ocGQErWfIysw7H36dmDBTGymNX
         N9pk3IWybzidXBPgx1CA4cGRfLzLgr0ws0seJXUls5zxZSC+ID/bUizx12Oabl6l9ZXX
         9pN2jg5bqZBdQxsaQLyCk9mNd6OiqiWMLjDF/8ihgGgiSJ2kgfwNiLh4bq//zzBaf91c
         KXfA==
X-Received: by 10.50.12.138 with SMTP id y10mr85229igb.58.1357928787486; Fri,
 11 Jan 2013 10:26:27 -0800 (PST)
Received: by 10.64.54.193 with HTTP; Fri, 11 Jan 2013 10:25:47 -0800 (PST)
In-Reply-To: <20130111112151.AFF924047B@snark.thyrsus.com>
X-Google-Sender-Auth: r6MnrGLOpcyCWc8zP1Gd5e82VLI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213230>

Very cool! I'm glad you got it doing what you wanted; I'll be
interested to see how parsecvs compares in quality and performance to
cvs2git and cvsps. --Bart

On Fri, Jan 11, 2013 at 3:21 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Since Heiko Voigt and others were concerned about this, I report that
> I have successfully salvaged the parsecvs code. I now have it emitting
> a correct-looking fast-import stream for my main test repository.
>
> I'm not ready to ship it yet because there are several features I
> think it ought to have before I do.  An -R option like cvsps's;
> correct interpretation of a third timezone field as in cvsps; and,
> most significantly, I want to make sure it emits warnings for important
> error and problem conditions like unresolvable tags and absence of
> commitids.
>
> But these are all relatively minor issues. It is likely I will be able
> to ship early next week, at which point I will add support for
> parsecvs as a third engine in new cvsimport.
>
> This next step in the larger program will be factoring out the cvsps
> test suite and applying it to all three of cvsps, cvs2git, and
> parsecvs so I can compare results.
> --
>                 <a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
>
> Americans have the right and advantage of being armed - unlike the citizens
> of other countries whose governments are afraid to trust the people with arms.
>         -- James Madison, The Federalist Papers

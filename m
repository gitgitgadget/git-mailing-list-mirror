From: =?ISO-8859-1?Q?Gauthier_=D6stervall?= <gauthier@ostervall.se>
Subject: Re: Command-line git Vs IDE+plugin?
Date: Wed, 4 Dec 2013 10:56:51 +0100
Message-ID: <CAM8gEgi1+4EYXAMzHxWbh0qZiFWGSU52fLKSeiPS-O3Uk5ifgw@mail.gmail.com>
References: <vpqiovpfxd1.fsf@anie.imag.fr> <201311191336.31000.thomas@koch.ro>
 <xmqqbo1g9vua.fsf@gitster.dls.corp.google.com> <vpq1u2c9ukx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Dec 04 10:57:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo9Cs-0006Tk-1N
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 10:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080Ab3LDJ5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 04:57:15 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:43855 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab3LDJ5N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 04:57:13 -0500
Received: by mail-wg0-f49.google.com with SMTP id x12so14507900wgg.28
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 01:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:cc:content-type;
        bh=lYRVn3IWoF8R/ES2AdM5K9k3Ol+fme/V4pJ8aXYn9JA=;
        b=XehMzYT3LEybGQ4dbIheVTsjKie1s/2EoeugUvykPJybi+oj/zcfSx3Au+qbkO1DTd
         Uz+5Lyd0Y+oENRUwvUXmKXtDHYJRzC75iJnCvdEc+s0XlK5cLiazECh6h5Gfz7s4Tbww
         QgIP4bJEdTXmOVhHiS7W1+x5C/AUbr//A50zQ7+VRL+BdjeAKtWh9K2J18EBL2C2DBTI
         xUZ66/veO616SVsNn6nrdAgcQ122m8FQwEcpSJaGLURSJSHChCrxQeqNiYmmOX3BNn64
         Aq7m4JqTsjkfTruf8Lta9UodaPA8M/XSf9izHBsyOEoHdDvic6+6YcdHgw1iE0hpJ3yx
         fvbg==
X-Gm-Message-State: ALoCoQlQY+XtyVa7yYza/L7OugLh+orVx4LY9MH8Y6dkuPG8lRjvqlsgc76qXvjm7p7ls7T09UO+
X-Received: by 10.180.211.71 with SMTP id na7mr6343532wic.5.1386151031927;
 Wed, 04 Dec 2013 01:57:11 -0800 (PST)
Received: by 10.180.104.165 with HTTP; Wed, 4 Dec 2013 01:56:51 -0800 (PST)
X-Originating-IP: [212.247.43.194]
In-Reply-To: <vpq1u2c9ukx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238768>

On Tue, Nov 19, 2013 at 6:20 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> One thing the command-line does well is to give names to concepts
> (basically, command names, option names, ...). It's easy to write in a
> tutorial or an email "run the command 'git foo'". It's less easy to
> write "click on that red button, on the right of the green one".

And it is also easier for many to press a button than writing a
command. This is a bad thing, in my experience. In a GUI, people tend
to take chances: "Oh, reset, that sounds like what I want. What, it
did not work? Oh there is this option 'hard', let's tick it and see
what happens."

Another thing GUIs do not (often) offer is history. I would be lost if
I couldn't see what I was trying to do 5 commands ago (before someone
interrupted me), or refer to a previous error message.

But if you cannot touch-type, buttons are going to be more attractive.

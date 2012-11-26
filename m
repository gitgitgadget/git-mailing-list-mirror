From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Mon, 26 Nov 2012 10:40:00 +0530
Message-ID: <CAMK1S_g2jpa+VqnuzhNaBNkC5bJHwbEy1iP-=sG29FFKmjTjpw@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<20121125214139.GA29465@shrek.podlesie.net>
	<20121125224728.GD6937@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Krzysztof Mazur <krzysiek@podlesie.net>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Nov 26 06:10:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcqxZ-0008VX-Fs
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 06:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab2KZFKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 00:10:04 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61423 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab2KZFKD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 00:10:03 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so5364014lbb.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 21:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PZp1byg8QbLCyfXCWSc2mtYEcGBblT5znP6tHKjbEIQ=;
        b=GaKNsvWvklTzQhG3qZb7mprJFMNnCL8FKPA/1aSmNlWONiG5FpwOCoFt2bVIp5JNqo
         /anQkb93H+dYAodNhlRb8OGxpBe5t/pcHmGGNiktGJ6GmqgZ9onHNIExv9eRFryhbpxd
         20caeb/AMOSPE28upXU/QYEV19QnJnIbEPR+GWwcdlFxYk0i/DuyKhWn0OE6d/ciHdgH
         hCW/Y6oLm2lbRX2/MzKU5ytFu5uzJfaSrW9labg1BdZT8prEeZK77jKX9toWuYrz/Coz
         d8uZTsj4ziziv7m3nzsV7z2AxQDrPeLDX8mezNxWzDampVjMp2Kt8vHP7J5QLf9uV6LN
         S+cg==
Received: by 10.152.103.100 with SMTP id fv4mr9633023lab.39.1353906600745;
 Sun, 25 Nov 2012 21:10:00 -0800 (PST)
Received: by 10.112.113.103 with HTTP; Sun, 25 Nov 2012 21:10:00 -0800 (PST)
In-Reply-To: <20121125224728.GD6937@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210413>

On Mon, Nov 26, 2012 at 4:17 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Krzysztof Mazur <krzysiek@podlesie.net>:
>> What about embedded systems? git is also useful there. C and shell is
>> everywhere, python is not.
>
> Supposing this is true (and I question it with regard to shell) if you
> tell me how you live without gitk and the Perl pieces I'll play that
> right back at you as your answer.

gitk is unlikely to be used on an embedded system, the perl pieces more so.

I have never understood why people complain about readability in perl.
 Just because it uses the ascii charset a bit more?  You expect a
mathematician or indeed any scientist to use special symbols to mean
special things, why not programmers?

Perhaps people should be forced to use COBOL for a few years (like I
did, a long while ago) to appreciate brevity.

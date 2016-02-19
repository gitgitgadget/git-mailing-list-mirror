From: Stefan Beller <sbeller@google.com>
Subject: Re: GSoC 2016: Microproject
Date: Fri, 19 Feb 2016 09:50:40 -0800
Message-ID: <CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	<vpq37so26oz.fsf@anie.imag.fr>
	<CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:50:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWpCX-0002Ce-H7
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 18:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbcBSRul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 12:50:41 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35734 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030273AbcBSRuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 12:50:40 -0500
Received: by mail-ig0-f176.google.com with SMTP id hb3so40063438igb.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 09:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=TexVkKkMjIbjhVOL3QTSzpkYWpHJVK9rsYOFdTRhs3o=;
        b=FIPqbr3I2qyVssZDzBjAsf+rbYMgUaHZ5ljEG1n9Rs+YYJ/KaBSXeN6dupqwXqHILq
         lY4MhCwxoeKU+U0gitA/UrCYs8fds6ZWx0Oi360c1V8X0QMxxO9PNYTGgakPTQt5tDPW
         xWxKNf88EfgjiQ4/EjMX3h2zDuiZEYCz7jP86HCluBoJZ+8I/XmBhxBCB5Y+ZRo41I3K
         2cjJsciIzu2mmgWiJe9wTz4UUfHZ7AAfl0IgXbML7wlTV9lDGn4wKqdyYgMCSqDveWV3
         4dm3jKz0COOhBhri3A29y06AMxza2565/EsuuWOBua7kAf3zwoQhiPtXy/KD8PUeyQNY
         v/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TexVkKkMjIbjhVOL3QTSzpkYWpHJVK9rsYOFdTRhs3o=;
        b=apeQfCprFLv3CzDxAgqdYa9sA5PUV+3jCNtKI0rNH0j40FPx7mAUKSHOK4WL690oL4
         LfGRXSZKGloQUMsPaaVbTsnp8Sj8NvwEBP8p0lXC0f5YsyhSL4bhZC2DppQzKWE++5Ar
         z3aaRxEw8ipkPhYjElxy3Ri2qxAx310q33/m5AdjtG8P52NNCNj4XJDEwhLrt2Wz6/Wv
         H1WLIq7YtaLouDgenmfLyyRhDObZnH4YITj3i7p4W+M0fwszBtvYA3TRxWxNBj69H0aS
         QsTSDgoqGwtqdSXbS1r/texwH/Pz62B4mo4bIKLPugBw98Xsh/caB8R6rMC/N9AcL3r6
         GK7g==
X-Gm-Message-State: AG10YOTuz6pJF6wd7g5a6pGRZtNQpshT7W17duD8eHieEOctZ2jZIUwcjOaCGWwNl5SnkZqMfq822IM0kBeI5QCH
X-Received: by 10.50.28.105 with SMTP id a9mr10896043igh.94.1455904240238;
 Fri, 19 Feb 2016 09:50:40 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 19 Feb 2016 09:50:40 -0800 (PST)
In-Reply-To: <CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286726>

On Fri, Feb 19, 2016 at 9:39 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> On Fri, Feb 19, 2016 at 6:33 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Hi,
>>
>> This is a double-post. You've posted almost the same message under the
>> title "GSoC 2016". Nothing serious, but attention to details is
>> important if you want to give a good image of yourself.
>
> I'm sorry of this kind of behavior. It was due to a misunderstanding by my side.
>
>> I don't have all the code in mind, but I think it is. In this situation,
>> you always end up with a variable telling Git what to do (I guess,
>> autostash here), and this variable is set according to the configuration
>> and the command-line.
>>
>> You should be careful about the precedence: command-line should override
>> the configuration. And the default behavior should be used if neither
>> the command-line nor the configuration specified otherwise.
>
> Thanks for the suggestion.
> I've started the work on patch and did the change in the code which
> were necessary for Microproject. I have run the test by using "make",
> and there was no failure of any test.
> I've a doubt regarding tests. Here as "git pull" will now understand
> the argument that  "--[no-]autostash" means "rebase.autostash" should
> be set false for current execution of command "git pull --rebase". So
> do I have to write a test for this new option?
>

Yes, most likely t/t5521-pull-options.sh or t/t5520-pull.sh would be the right
place as judging from the file name of the tests.

Thanks,
Stefan

> Mehul Jain
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

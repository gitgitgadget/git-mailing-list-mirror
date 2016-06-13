From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] Document the 'svn propset' command.
Date: Mon, 13 Jun 2016 20:12:04 +0530
Message-ID: <CAFZEwPO3_gYP1fO1-3S1M0dnSVo1Ji9ALJNTdN-ZrYsNVfX0cg@mail.gmail.com>
References: <20160612191550.GA14160@elvis.mu.org> <CAFZEwPM5qnzw7RCUwOkJFo+U982kVGU8_3GUTXvHAypKtvEgTQ@mail.gmail.com>
 <81a197e2-7e0e-176a-c934-0e5f95cfda83@freebsd.org> <CAFZEwPNGz18uyLT62PsR-ybF32KJPb5PssQXJXuA4eWUFtPXnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Joseph Pecoraro <pecoraro@apple.com>,
	David Fraser <davidf@sjsoft.com>
To: Alfred Perlstein <alfred@freebsd.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 16:43:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCT4x-0002vT-EX
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 16:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424474AbcFMOm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 10:42:56 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33832 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424360AbcFMOmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 10:42:07 -0400
Received: by mail-yw0-f180.google.com with SMTP id c72so127193604ywb.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UdiioTb5KG3g/IrYTq1WlBPFGgzZ73gONumci8/BA2M=;
        b=wRqz4+elNv8pce4bA8cxbPyoeYu2xCtBqyTncwDT5CvHhO2Ni9FkHYWF8oKJxQM/aN
         VYCvQomcPrtRFRXYmdppyToLbTKXMP+wKE98selPbmwJr9kyqDyf8PpXP4e94tUlhWQ5
         0T3fnuLNrLQ154l7TA8e+pQVlYUobnSVlOvu8jNl+UpEI8lyTYVAWxw0qOZDItca6Usb
         mcXyNLFNPNIq7Se2+yqOvY5lGO3y+XWkHib4/ZKf6fNaMFIrHeWEApeBq9n0jfEArls6
         EI+Gw4F6hbTGyCxsaYI8WwC8dk/cITXMpGrd7KinzR3kZFen6tbwGGtisDH7HtpJQT4M
         EJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UdiioTb5KG3g/IrYTq1WlBPFGgzZ73gONumci8/BA2M=;
        b=CEHqwqtvsjj7ESvlXTfxoRiubD5tkwd4KMN68tHLtP9oT+sJ/WTEt9pxJq7mu7Qp8K
         DBa4vrJfpBCLDB4SNyFxWq5AIUbjgb543PMAlsM4/oYcP2x3y9QlbdoiGT49Z5reTtOH
         WeVapaSlEw2LhXEtJTilcQxPqHcZ163FtenAv8YTI8AHuIA0Myx0s/XByBQa6zDyu00v
         s3bzXTlBDcgheGxxbtTxIxQs+SjOxnoIVXVQc0kk4pXmNX1cq3PmpV/20m+3cl6+DQ3f
         muQeGg1c8F+6M3gH6o09/zyymM0FjltPVUM3zLA9M1ijInCBs8BZscZOgUR0c+/ZzRQ9
         ribg==
X-Gm-Message-State: ALyK8tLfctuNSCsAoLgzUavsQHl3ZRpMODhyO/EXz224jLTw0wccT3m5W/E8in1dn3gR7ffVoOcHsQYKTLQGpA==
X-Received: by 10.37.2.17 with SMTP id 17mr8060030ybc.21.1465828925165; Mon,
 13 Jun 2016 07:42:05 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Mon, 13 Jun 2016 07:42:04 -0700 (PDT)
In-Reply-To: <CAFZEwPNGz18uyLT62PsR-ybF32KJPb5PssQXJXuA4eWUFtPXnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297192>

Hey Alfred,

On Mon, Jun 13, 2016 at 7:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Hey Alfred,
>
> On Mon, Jun 13, 2016 at 6:22 PM, Alfred Perlstein <alfred@freebsd.org> wrote:
>> Thank you Pranit.  I thought that "signed off by" is used once someone
>> approved my patch as opposed to when it's in "proposal" stage.  This was my
>> first email with a patch for this issue, who should/could I have used for
>> "signoff"?
>
> Signoff is used to indicate that you are OKAY with releasing your
> patch according to git's license. For more details see the
> Documentation/SubmittingPatches[1]. To summarize you will have to add
> this in the end :
>
>    Signed-off-by: Alfred Perlstein <alfred@freebsd.org>
>
> Though I will still recommend you to go through [1] properly.

Oops I forgot to put the link.

[1]: https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L239-L307

Regards,
Pranit Bauva

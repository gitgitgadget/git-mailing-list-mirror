From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: Signed-off-by vs Reviewed-by
Date: Thu, 31 Mar 2016 20:27:00 +0530
Message-ID: <56FD3ABC.2000500@gmail.com>
References: <20160331123507.GC19857@collabora.co.uk>
 <CAFZEwPMzcqrd8NEP6MH5saXL2KdUKAyN51uuoS5=aeU0aPWjJQ@mail.gmail.com>
 <20160331143501.GE19857@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@collabora.co.uk>,
	Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:57:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ale22-0001jQ-W9
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296AbcCaO5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 10:57:06 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33499 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757292AbcCaO5F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 10:57:05 -0400
Received: by mail-pa0-f68.google.com with SMTP id q6so10472578pav.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RZB/Jj+RldF81NckJ/5P5No5m77l/vfQ8yFikaJ3fLU=;
        b=vIj7kFtfCfw1Pt7ITofqqYN8UE9S9menHIDwP3DiMLwk8rfWEkW53NlcdNctw7eRCL
         WVAId6R/lE54PsbyQNqOrQWTYYZY6H1R6A+H7GTf1KYc9UZTrFZ7nFkv55Q5jg+Bdx7s
         6JPtuVKxX+GZLk5RAzYB7yo+bFweQO9KBJtSlOtokky8VQhH7nLGKzlynUXmD40sooqK
         v1DrMokDYm+F8ZMj1DvlAuiVSb+RxssgHcwG4tBxP5zQ4ep44Icz0sybE6CfePIsEgeT
         c/Dyqz/flZfb+FfuWiyh7gf6o8vmBirjRa5ikbOD3C6kHtH75a6OXyyJsmiqc4qLMLA3
         HeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RZB/Jj+RldF81NckJ/5P5No5m77l/vfQ8yFikaJ3fLU=;
        b=Hkxqaf0x0FfGUBx6JZ4mCi8xmmrF8rmHbHzHjxNUnmnKP71r/COYIRWkEyg2U0F2Lx
         jA5XMHBrdPNnThKhbAfgKnyqNVYT7ntxO0l6x+NHlD7UpB5GpC/mfFDY8RsThHmIRC0X
         y2vpQ4zBGvRYyx1VnDlJKK7S8/Gqt5HauxsfdcMG3MRznS0Q5PHeNdchDg4GLq+Gh/ef
         drLAWezxYQY2LdsxhX+/dADvmI6+IGVS51Ze1Fns1wKq3xwmOOpdMhtalXnh8GYS19S1
         AHEsrU1S559kMsBg0ZzNZPCfWM4BGf8XlxiVizMy79b4tqeqtAUzhQKjYAzHLEbqspUy
         oOyg==
X-Gm-Message-State: AD7BkJJhnjuIe2VnHuogNP0TEjCA3vnuniVT/hYpxhBmEaHRgSIzGduuP+3bywCU54RntQ==
X-Received: by 10.66.244.15 with SMTP id xc15mr7258195pac.97.1459436224412;
        Thu, 31 Mar 2016 07:57:04 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.3.234])
        by smtp.gmail.com with ESMTPSA id 17sm14168591pfs.40.2016.03.31.07.57.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2016 07:57:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160331143501.GE19857@collabora.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290396>

Hi,

On Thursday 31 March 2016 08:05 PM, Miklos Vajna wrote:
> Hi,
>
> On Thu, Mar 31, 2016 at 07:54:47PM +0530, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Are you suggesting to use a different email address for commiting,
>> signing off and reviewing?
> Let's say project A has a workflow where patch authors and maintainers
> add a "Signed-off-by: A B <a@example.com>" line. This is well-supported
> by git, various commands have a -s option to add that line.
>
> However, if project B has a workflow where patch authors add no such
> line, and reviewers add a "Reviewed-by: A B <a@example.com>" line, then
> you have to add that line manually when you do a review.
When making the string configurable, would it be a good idea to
support more than one sign-off strings? For instance, often patches
here in Git have both a Signed-Off and a Reviewed-by line. What would
you suggest for such a case?


Regards,
Sidhant

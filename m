From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4 Question
Date: Fri, 24 Apr 2015 10:20:15 +0100
Message-ID: <553A0ACF.4000006@diamand.org>
References: <CAFcBi89YqRGqigR1VCJJQtu1D206rP2T8Y-10KvFnvDjXYaN_g@mail.gmail.com>	<553552FD.80703@diamand.org>	<CAFcBi89pXTKzeVkB5EN3ZYkLwa1oPfDOqdHHhHeVogswhnpOAg@mail.gmail.com>	<CAE5ih79L+RU934OYsBrXjP7PAoDYbeBS01hCgsOm+pnFD+dWwQ@mail.gmail.com> <CAFcBi88ZohscEZXVXbaf+6=ZKJAy9LRfn2-4WT0JV+1RodBTJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: FusionX86 <fusionx86@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 11:20:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlZn5-0007rX-St
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 11:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966772AbbDXJUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 05:20:51 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33130 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030209AbbDXJUt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 05:20:49 -0400
Received: by wgin8 with SMTP id n8so44158870wgi.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 02:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fh0iRfSrREB3Szzu7YYN5DsPKcCMXiy//JE2f+oY3tg=;
        b=RPs9PoZwUZTzQZiDFOkZz6rLCHifw+xfQy+Ys+8jmD821XaGLPd8mmvgrJXJL+k+RP
         YpVaxDxjavfbjJF4no/bPhRV8/X2qlvq8Noo2tmcmRZwVG8iacj4ZdgdLog5MDXyM7m2
         vM0W21VsH1nX/hArAjKnXtzloS3uEEap4yLgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fh0iRfSrREB3Szzu7YYN5DsPKcCMXiy//JE2f+oY3tg=;
        b=k07luxIjaXKjuj/z8JEVtoCjQKohE5lmXN+KZxmCzXY56nVYy8KiYnz4QQ4n4g89sI
         U380atbpCp6ewYu73ec1GPNY8BNPu/vHiZJ0P+YO+XFUpR+D5/KANuC6FhnZo/OOMVnS
         3a+GS4W2aSCxSUsglQSHfZI8lFAVLj2UU2LKOjQs0Kz0uPoGHiO5lB2PjvKPpPOnkM7q
         KTWlWNWL/mYwhFODXx3THa/Q7boHCh8AqIRHSN+9ZePitcoMr5+HkBQd4pjfR/uyUbFH
         KDAdghvAzoP0DiclmYBxxY+aiSs6uPle5BHPwYywF0ql2IcwvRlqaRUJ2sUcP6L1KW1O
         PN5w==
X-Gm-Message-State: ALoCoQkwaP3whU+AKm2gDeKiVIVUvesm25eLkHSznSoQkXWA5Mg9d4pLi38QbYnvdVq2q3smAVrF
X-Received: by 10.194.205.37 with SMTP id ld5mr10948790wjc.14.1429867248180;
        Fri, 24 Apr 2015 02:20:48 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id um5sm2214805wjc.1.2015.04.24.02.20.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2015 02:20:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <CAFcBi88ZohscEZXVXbaf+6=ZKJAy9LRfn2-4WT0JV+1RodBTJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267726>

On 23/04/15 14:42, FusionX86 wrote:
> Hi Luke,
>
> I found a silly mistake I was making in the command I've been using.
> The folder under the depot should have been capitalized, but it
> wasn't. Also, I expected that if there was a problem with the command,
> it would fail with some message instead of creating an empty local git
> repo.

I would expect that as well - it will usually create the empty git repo, 
but it should then fail with an error message, like this:

$ git p4 clone //depot/main/nosuchpath
Importing from //depot/main/nosuchpath into nosuchpath
Initialized empty Git repository in 
/home/lgd/p4-hacking/git/nosuchpath/.git/
Doing initial import of //depot/main/nosuchpath/ from revision #head 
into refs/remotes/p4/master
p4 returned an error: //depot/main/nosuchpath/...#head - no such file(s).

$ echo $?
1

If you get a moment can you send your command output; if it's not doing 
something like the above, then it's a bug.

Thanks!

Luke

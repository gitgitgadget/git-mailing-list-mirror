From: Stefan Beller <sbeller@google.com>
Subject: Re: Git issue report : issue with capital letter in folder name
Date: Thu, 17 Dec 2015 10:29:27 -0800
Message-ID: <CAGZ79kbi-qdaNorabfZkFFL=FDZSgD332+N8bUrqfvu621EYvA@mail.gmail.com>
References: <5672D895.7030209@mail.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: PFDuc <pierre-francois.duc@mail.mcgill.ca>
X-From: git-owner@vger.kernel.org Thu Dec 17 19:29:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9dIz-00067Q-AB
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 19:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbbLQS33 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2015 13:29:29 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:35919 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbbLQS32 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2015 13:29:28 -0500
Received: by mail-io0-f177.google.com with SMTP id o67so64281453iof.3
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Hv6OX3x7Mxf/67Jlq6smdr/UMi+i/zE1NTmGnDjsHQ8=;
        b=kLglhMBVHcani1R5aPfCBxeU2y6CjE21YN+siKVrgF4clupFXc5nqg+RAf5IGZISgA
         9nx26cuiBHhNGt8Uuu55MxaVtYXYzn74i3gNhxyRQq9ycxQphOQVCXIDY3A3vU+LiAiW
         ZIXsd2YeEsVxJ4Z1zul5DtVh7CdDj1ovtl2w2B3PqjZkjXhL/lyWPq76m7BHpFb4mC5e
         tvgpefn3Ab9GLLLGWsyJQMUjCqR56ep7p8RGHFmqjYjnQkLNaZ49zaYqplMCnQ+EvKJb
         Y+oCNczvqrxuX9XR5hOqColYCWlvULy/NrKkYoRYQnxBfOtpz62ztTR4shaupf89Cug8
         kTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Hv6OX3x7Mxf/67Jlq6smdr/UMi+i/zE1NTmGnDjsHQ8=;
        b=HeoLGPS/1jR3q41wUf8sGfd1xJlxtgugDeiiGb6z+GL9MV8PSFTV0lmqzwG869JPa0
         AL4m+LB4ohg18ZBRlRGqiARmEVe5X6IqeyKoXWznhqjSBAHQmO7m5TjPrutyEEjqGRcq
         hjG1Bk433W6CHlNnm2MgR2PFwZoc2fagm6BPBGNo4lIxqlZPRdrUolWtwR+fQfdzT2Og
         +uM/lqLLP3o3X5l7P39FU2ow/s+P9SM/3QeMIUud9Y7H55SJPqlUpP90PNztRM/i33PQ
         baM3QLg+EybUcaaTgXsznWLG+dq0o3DnQ8pZ4mbRqjl370x4XrvPbgUxxw/q99xqSrx+
         oDag==
X-Gm-Message-State: ALoCoQne+pmnhBIldKlKSCUurRlTlVk+IwDa1rbbWS24wg+Q8+GEycNE8+WZsUzPbb5VANVgx9HkCtnxEye690THor2stZ/n20MtlnS3Ev5K4A89bViLEVQ=
X-Received: by 10.107.168.203 with SMTP id e72mr8541964ioj.96.1450376967469;
 Thu, 17 Dec 2015 10:29:27 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Thu, 17 Dec 2015 10:29:27 -0800 (PST)
In-Reply-To: <5672D895.7030209@mail.mcgill.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282664>

On Thu, Dec 17, 2015 at 7:45 AM, PFDuc
<pierre-francois.duc@mail.mcgill.ca> wrote:
> Hello,
>
> first of all thank you for developping git !
>
> I had an issue with a capital block in the folder name inside my git =
repo.
> The folder in my local was named "Display" and the one at origin was =
named
> "display" resulting in error when importing python code from this fol=
der for
> users who got the repo from origin.

By any chance, were different operating systems or file systems
involved in creation of
this problem?

There are file systems which care about the capitalization, and others =
don't.
So if you have a file system which doesn't care about capitalization
of the folder/file name,
you can use a different capitalization and it still works. If you take
the code to
another system then, which is a bit more careful there are problems of =
course.

The main question which remains, is how is Git involved? i.e. would it
also happen
if you just transfer a tarball? Did Git itself break anything?

>
> I tried to change the folder name on bitbucket.org but I was unable t=
o (or
> wasn't smart enough to find how to).
>
> I fixed the issue by deleting the file from my local, then commit, th=
en
> push, put the same folder in my local, then commit then push.
>
> I am therefore only writing to tell you that story which is not so
> important, but I had the thought that because it is not so important =
maybe
> nobody reports that and the bug (if any) cannot be fixed.
>
> Have a good day and happy end of year season!
>
> Regards,
>
> Pierre-Fran=C3=A7ois Duc
> PhD candidate Physics McGill university
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

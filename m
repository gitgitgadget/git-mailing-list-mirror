From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Mon, 22 Feb 2016 13:40:37 +0530
Message-ID: <CAOLa=ZQqyfGDOVr=nxKbuZXJw2rsCu0KbomG+tuRkeS+R9xzFw@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
 <vpq37so26oz.fsf@anie.imag.fr> <CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
 <CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
 <CA+DCAeRTtECCZSAPYUe2=AoQEvc6LRG1B+qYCCj9C6_nyUJrhw@mail.gmail.com>
 <vpq8u2er7ae.fsf@anie.imag.fr> <CA+DCAeQWeUodaBtHOdzGB3RTZTQ672ZUSV-=eh-nA+8Bvn4gxw@mail.gmail.com>
 <vpq1t85rj44.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mehul Jain <mehul.jain2029@gmail.com>,
	Stefan Beller <sbeller@google.com>, Git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 22 09:11:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXlaq-0000KP-CI
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 09:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbcBVILl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 03:11:41 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:32980 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbcBVILI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 03:11:08 -0500
Received: by mail-vk0-f42.google.com with SMTP id k196so123707774vka.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 00:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4EYAFKTa8+S9Qg3nUUnohCvrANDuQhDbO3AZqZSEBVI=;
        b=QEmxkpe/mtdfvygYgnnuKAfaOCcKTUBQB9IwbTCofbHE05L8cxtTk4baIeoPoqe9Ry
         MY7aLlTzMbUAP1ETojhQDrBmGKwZ4LiDHp6ErS6CyWXB5bmkdypxh7Og60+5bxOZn/Kw
         zP37BqNmV49/60fpRPIWF+5L0Sf5FiExC2XaVhtVqKk7Q8QLWdrFfF+CutAvGnyD3AyG
         E4boNcFA1CQ2hZ/my7C/UJof9oARTxeb51uxOn2Sih4T+UCIXMiRvSDoVkgnVXjJnSPd
         PWE+QBBiXZrMfYMcpkaeoY1P5U8lEe97IyTYmbYjx09XD6vlfpizJlCQm7QXInentQM0
         JiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=4EYAFKTa8+S9Qg3nUUnohCvrANDuQhDbO3AZqZSEBVI=;
        b=gDIvErf9bf/m4gbP0tzEvZNx4Se/DSNRJ070TIN9V2ET5/1Ec8epZCFxQN8AB6Lc4s
         bUcxW92XIwR1ovwzeeFzZiZevBj5HFGwIzxnIScRGwangaSakh8rRYWrPq+cojbVrPHx
         RVGseAV4fet8C8tdxaoPs7NIHY654muihDDy5SgWSjTNidm9kIjy06xlfjhl25wSJbX2
         0kgiZ+oH0Y/DtVShA01Quvn/ifH7idDMXSh9JJU/U58n5ZzR0dd9nIa2gVFCX4Q9REMl
         6OEsqmgnVlddHb2nGaw6hT2WJeFv0dc2Xa2UF02m97ZbQrXePoM9W2NzqZRPpb3tpAUr
         H48g==
X-Gm-Message-State: AG10YOQoFIHO1guLCBs8ifYBqZ0Cs3HA7l/uKU7egS032z5Fu/HWllxEmRithNDq9atqzJe9LSs5LJ8JixETvw==
X-Received: by 10.31.54.75 with SMTP id d72mr21359942vka.30.1456128667212;
 Mon, 22 Feb 2016 00:11:07 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Mon, 22 Feb 2016 00:10:37 -0800 (PST)
In-Reply-To: <vpq1t85rj44.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286893>

On Mon, Feb 22, 2016 at 12:22 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>
>> Earlier when I was testing the master branch on my pc, I used "make"
>> in \t directory, which lead to failure of test #2, #3 in
>> t5539-fetch-http-shallow.sh .
>> Afterwards I switched to sudo mode and ran the make command again.
>
> Never ever do that. Your git source tree should be within your $HOME
> directory, and you should never run any command as root that creates
> files within your $HOME dir. If you do that, you'll end up having files
> belonging to root within other directories, you won't have write
> permission on these files. Then, anything can go wrong because any
> attempt to write to these files will fail.
>
> The simplest way to get back on track for you is probably to start over
> with a fresh clone, or (warning: destructive operations): use git clean
> to remove untracked files.
>

I think a 'sudo git clean' outta be enough. But the main point to take away is
not using 'make' with 'sudo' like you mentioned.

-- 
Regards,
Karthik Nayak

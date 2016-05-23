From: Jon Forrest <nobozo@gmail.com>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Mon, 23 May 2016 06:44:45 -0700
Message-ID: <6e4862b8-b5ab-ced4-29a0-bf975848e98f@gmail.com>
References: <nhlqd4$ekr$1@ger.gmane.org>
 <c07df4ac-08c9-8eaa-0233-06616945c857@web.de>
 <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com>
 <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de>
 <xmqqy474g3cv.fsf@gitster.mtv.corp.google.com>
 <xmqqfutcg0pe.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1605231310190.4122@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 15:45:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4qAG-0004ny-Bo
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 15:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025AbcEWNov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 09:44:51 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36765 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbcEWNot (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 09:44:49 -0400
Received: by mail-pf0-f173.google.com with SMTP id c189so66896582pfb.3
        for <git@vger.kernel.org>; Mon, 23 May 2016 06:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=iJIte5EAVXe3GV4ioOO4Uhxev1BDOff8wa5aUey+i+8=;
        b=p5NXAaaWLeruzDGAk3X2WjgR0dgZmm4azwpryEQ9VgRy0yIVFxsUb0hLeomn1HACg2
         HFJnrUm/pKl3z+iozalhm4twmR1qI8eGN7VQuEE19syTcHmhUCIpb6GuopU49d0/zK+A
         NVqNHH9TZbp9TebWB7+zyHf1dfjOAkZB8FU9bVyQV5vgHgRD7+/AaIcfLp/dXy1/dSRm
         UtMjRKrU/Vir9EFRCar5rUYY0y64aLKbxW1pnFBdJO/FxsvuQ5zC64ocLFCJcf5rxjfX
         zJhF3JBwhCHqXxu9E8JHVlYrx5lEG8FuikbG0kPlMRU/6RR+Dr1+NqfF6gZj3EWXnFOk
         ehfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=iJIte5EAVXe3GV4ioOO4Uhxev1BDOff8wa5aUey+i+8=;
        b=U1QIL/15VsOXGrbd5HowIbKjB0DgxJnv7/ZAe+d0tiP2FoNaFP9shJbCxQ8RZTAVpT
         mXN1eXHTt5pZ5jziJzA4HyR/zgVAWlKredo6rRIOYs6Ineg9zZh5041VgkIckf5XA6LV
         2bUH1c9a/1lQ6PjbJZN4IkIuDoqGeFt49p9z5/QXTwEfCzDc/L9yyG69I1pope+Bdtu6
         4xEQMMLndWsKJY6ftnOM5dF4caqSdQUtlpXQFH+ZriQzAISp10h2ZVKQwVzvoCxWrKJ0
         8YWaqmqOrHbtAb43PCFWtuL5xayN9h4iKjHslylE6j2jEUIJ6G249kqcEuZmor2JCE5o
         pprg==
X-Gm-Message-State: AOPr4FVDMu9h/xiS3B3T+YPFMOx5KtmpTNthPRmbGf5kMlE4+MhtwYVnJ77j4Gqd8Tt1fQ==
X-Received: by 10.98.3.4 with SMTP id 4mr27437199pfd.33.1464011088898;
        Mon, 23 May 2016 06:44:48 -0700 (PDT)
Received: from [192.168.0.107] (c-71-202-183-39.hsd1.ca.comcast.net. [71.202.183.39])
        by smtp.googlemail.com with ESMTPSA id p190sm4780474pfp.46.2016.05.23.06.44.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 May 2016 06:44:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <alpine.DEB.2.20.1605231310190.4122@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295323>



On 5/23/2016 4:12 AM, Johannes Schindelin wrote:

> What we could do is to make the default config setting platform-dependent,
> a la CRLF_NATIVE.
>
> I imagine that we would want this for core.filemode, core.ignorecase and
> core.symlinks.
>
> What do you think?

Would this change have any bad effects when the same repo is shared
by both Windows and *nix Git users over Dropbox or a shared filesystem?

Jon Forrest

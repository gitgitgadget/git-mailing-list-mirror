From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git am ~/Documents/mail-[1-9]-11.txt Patch format detection failed.
Date: Sun, 14 Aug 2011 08:36:51 +0530
Message-ID: <CALkWK0kmZLiSzSwZ9YqjZMpx3SzZ5gDC4Y6CFtSu3x2EcvE-rQ@mail.gmail.com>
References: <CAJfuBxx9Ayo8cHga+vK+Ynx5P7dhST7f=p87-qyjEzofSdZ=RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	David Barr <davidbarr@google.com>
To: Jim Cromie <jim.cromie@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 05:07:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsR2k-0005t9-7h
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 05:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab1HNDHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 23:07:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39181 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab1HNDHM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 23:07:12 -0400
Received: by wyg24 with SMTP id 24so2875838wyg.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 20:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hfG4Svt3p/+l9IVMYVNCBEQ2AcqddJMb9cnnHJ8iFiU=;
        b=TeTz+T5RUWnXgBr01iKzLc1dZrHzOlbiNN3PILiHqSK1iGABFAfFf++3j2vA4bOrtj
         M1f3klUasgRl5kKRaGjz+NwDwkErpZl8WoNu5PQLse3bP9HpbXd7CvDsoQ03mtwSP+x9
         wksUgGDMy0InKf4OnqkB3THFhTrNu3Y1GrfaA=
Received: by 10.216.131.134 with SMTP id m6mr1665693wei.78.1313291231075; Sat,
 13 Aug 2011 20:07:11 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Sat, 13 Aug 2011 20:06:51 -0700 (PDT)
In-Reply-To: <CAJfuBxx9Ayo8cHga+vK+Ynx5P7dhST7f=p87-qyjEzofSdZ=RQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179302>

Hi Jim,

[+CC: David Barr]

Jim Cromie writes:
> git am is giving me trouble.
>
> Im a gmail user, and have saved a patch series by doing
> show-original, save w rename for each patch
> [...]
> Ive attached mail-1-11, which applies cleanly to v3.0, but wont am.

It works quite well for me after David's recent patch: 0e8341f2 (am:
ignore leading whitespace before patch, 2011-08-08).  The patch has
already made it to 'next', but hasn't hit 'master' yet.  Could you
please try it and tell us if there are any issues?

Thanks.

-- Ram

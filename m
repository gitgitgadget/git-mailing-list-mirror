From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Fri, 24 May 2013 16:41:29 -0700
Message-ID: <CAJDDKr5==LhBCWrPNv89w3T7dXueYfUpY-zykEXkt_VLDsQhww@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
	<1369405177-7855-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 01:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug1c6-0003e8-PT
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 01:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab3EXXlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 19:41:31 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:46505 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754229Ab3EXXla (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 19:41:30 -0400
Received: by mail-pd0-f172.google.com with SMTP id 10so4689784pdi.3
        for <git@vger.kernel.org>; Fri, 24 May 2013 16:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d0YvbXlLAWPXAtav7ItLzVg5kVpECELNDdCpMbiy1J4=;
        b=eIFtIM2HLwZjGt68H/ZgvPAB29ngjwAmrSe/GLRQq2dJUImPF14vadgcI5Dje2S7wI
         cgIvsefQ13u4liYRkA3zUT2V2VystzjHuiM1CSn+ZadNTgFVVyEIbR5sXTpq5+92l1bf
         23x9Z2c+4Rx8QwjsOeevNOOIzVsovQLjSaGPJ1gwo4brdxbC7nxrnP5TdOGqyJsZmThX
         yYkRTWFucnFuspxkF9CvrEFjQh67Lyl4X+3k8Q8/vOTA0gu9c9DCeyoLQ68PHbny2tJI
         uJgPNrOeW8yKCQk9JYCvhJocmQOASyErAER6arxkPTmEBMvUhtWaRnqTGcXig65UMMtH
         E6iA==
X-Received: by 10.66.182.9 with SMTP id ea9mr20315275pac.5.1369438889982; Fri,
 24 May 2013 16:41:29 -0700 (PDT)
Received: by 10.70.55.106 with HTTP; Fri, 24 May 2013 16:41:29 -0700 (PDT)
In-Reply-To: <1369405177-7855-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225404>

On Fri, May 24, 2013 at 7:19 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Since 'git branch' misses important options like --sort, --count, and
> --format that are present in 'git for-each-ref'.  Until we are in a
> position to fix 'git branch', let us enhance the 'git for-each-ref'
> format so it can atleast colorize output.
>
> You can use the following format in for-each-ref:
>
>   %C(green)%(refname:short)%C(reset)
>
> To display refs in green.  Future patches will attempt to extend the
> format even more to get useful output.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  builtin/for-each-ref.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Can you please also update Documentation/?
--
David

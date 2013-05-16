From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 2/3] pull: trivial cleanups
Date: Thu, 16 May 2013 15:48:21 +0530
Message-ID: <CALkWK0mAWUV1KgFaY2LpSQ_+=deE5wwV=Je23MuMi=6ktE+DAA@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
 <1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=tP=v=3Q4dzPc=W0=j_7iFYdGnzkaV6U_MFSg=NCE49w@mail.gmail.com>
 <CAMP44s0sg6zQc9=cD1X61joxSd=LK7qT1k-suej3dYDD826hgw@mail.gmail.com>
 <CALkWK0=RF4cjQ4Lz4Qi2iac_NgLdzBRw5Q9uf8KjYJju8swWDQ@mail.gmail.com>
 <CAMP44s1vMTfrSaU+0S8EOM5g4L0885780SvT_THBr7u==bJ06A@mail.gmail.com>
 <CALkWK0kP1yhdhV7oLA4gYJTJ7VtU2WuhtJ_Q5UsZSS00y=FP_w@mail.gmail.com> <CAMP44s08Q3xn13iqptf5jAUThHcEWQK5b77=pWLvOnjGsBfSMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 12:19:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcvHB-0004mn-M7
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 12:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab3EPKTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 06:19:06 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:47758 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab3EPKTD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 06:19:03 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so6059789iej.30
        for <git@vger.kernel.org>; Thu, 16 May 2013 03:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5XInWiCSr2XKeeuQoi2ZtZ58PZ6hB9FhFFFO6jgK/Hg=;
        b=ZT3mVl9DzS5+f4Hzy7hIwdJd17F5jc/at+teYapj3hos8H2DJBTv3Nr+rdJP+1qq0D
         kIT3TDLji1o8vnAlD3PcmVRPbhF3i1Ru8fgOCWur0N+nsaRcZsNzLB52BMzsEdr8pc3E
         nkybN5AkWRzogUDV0FoctwNSRzBGMP/2h4jeLjiWVDRvlTRpm9Q0uWgclD9JjTcUihXg
         1/uFUGMcQ3gGutckekrETTg3KvTMub3zxGZjWXxBT2b9TVGVrI3bwVVI8A7Z6dzoUPrB
         ptJ1unMd4SyzvbO6SbZxt7ih1EqvJ2nvP0nFdQdRq3K4QibmDJ+GEvNkGkSfBhXVKNfP
         sLig==
X-Received: by 10.50.66.197 with SMTP id h5mr8460310igt.63.1368699542192; Thu,
 16 May 2013 03:19:02 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 03:18:21 -0700 (PDT)
In-Reply-To: <CAMP44s08Q3xn13iqptf5jAUThHcEWQK5b77=pWLvOnjGsBfSMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224548>

Felipe Contreras wrote:
> It doesn't matter if you think it's a bad practice or not, 'git push
> --mirror' works, and it's possible to update a branch even if HEAD is
> point to it. There should be a possibility to do the same with 'git
> fetch'.

So, introduce a configuration variable to turn off this safety feature?

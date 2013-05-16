From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/3] pull: trivial cleanups
Date: Thu, 16 May 2013 04:36:36 -0500
Message-ID: <CAMP44s1vMTfrSaU+0S8EOM5g4L0885780SvT_THBr7u==bJ06A@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=tP=v=3Q4dzPc=W0=j_7iFYdGnzkaV6U_MFSg=NCE49w@mail.gmail.com>
	<CAMP44s0sg6zQc9=cD1X61joxSd=LK7qT1k-suej3dYDD826hgw@mail.gmail.com>
	<CALkWK0=RF4cjQ4Lz4Qi2iac_NgLdzBRw5Q9uf8KjYJju8swWDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:36:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucuc8-0003uS-Bt
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473Ab3EPJgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:36:41 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:49708 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab3EPJgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:36:37 -0400
Received: by mail-la0-f51.google.com with SMTP id lx15so839522lab.38
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=1gdzjofq8avjems2+wMmBkMau3Wvo8gHCEZWcyJLEmA=;
        b=IZGXU1tPKNydXYYpt2tp36ra0PaxjdVz+MfEgpzIH9vM3Xhi8Qtcgf8npxQRlxbRV7
         17uVe1bRv1LDX6uuHBWmBaKbDFdwzok30Ysn2qzTD+yJEPA6lITnqkFvUzi8dUM0/8CM
         YwJd/34+uNte/lr89bH54al6c8Zv54PyrmK1oPZcsg83jVoB8lU1wj/Wxmh/rGNlW6g0
         ILnBKyIa5qVV0tQ+mRyeztBcxlJctQ+iG3SbwXB3K+WtlCI26xw2vG9caRf3Fr7e/k3L
         fIxMiqBFElJGV28/7lkMbkVMPqPDFOy7Yr5OYk4/nJLjjDer4kyKe6XiE0moHA5rFpjs
         lOyw==
X-Received: by 10.112.163.71 with SMTP id yg7mr10077582lbb.8.1368696996385;
 Thu, 16 May 2013 02:36:36 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 02:36:36 -0700 (PDT)
In-Reply-To: <CALkWK0=RF4cjQ4Lz4Qi2iac_NgLdzBRw5Q9uf8KjYJju8swWDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224526>

On Thu, May 16, 2013 at 4:34 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> But my only concern is that there's no way to
>> do something like:
>>
>> % git fetch backup 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
>
> [remote "backup"]
>     fetch = refs/tags/*:refs/tags/*
>     fetch = refs/heads/*:refs/heads/*
>
> What am I missing?

Actually trying that command:

% git fetch origin 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
fatal: Refusing to fetch into current branch
refs/heads/fc/fast-export/cleanup of non-bare repository
fatal: The remote end hung up unexpectedly

-- 
Felipe Contreras

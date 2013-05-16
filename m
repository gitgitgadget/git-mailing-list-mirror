From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [RFC/PATCH 2/3] pull: trivial cleanups
Date: Thu, 16 May 2013 13:54:37 +0200
Message-ID: <CALWbr2w120xDGHXB9b2UHgz5fAqX+VaSHMsaf3dhfx_5dYbruA@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=tP=v=3Q4dzPc=W0=j_7iFYdGnzkaV6U_MFSg=NCE49w@mail.gmail.com>
	<CAMP44s0sg6zQc9=cD1X61joxSd=LK7qT1k-suej3dYDD826hgw@mail.gmail.com>
	<CALkWK0=RF4cjQ4Lz4Qi2iac_NgLdzBRw5Q9uf8KjYJju8swWDQ@mail.gmail.com>
	<CAMP44s1vMTfrSaU+0S8EOM5g4L0885780SvT_THBr7u==bJ06A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 13:54:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucwlf-0004aS-Of
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 13:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab3EPLyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 07:54:39 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:45818 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3EPLyi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 07:54:38 -0400
Received: by mail-qc0-f182.google.com with SMTP id c10so959686qcz.41
        for <git@vger.kernel.org>; Thu, 16 May 2013 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tVqLwyT9Hd0SpHR/2xzxgV8EVg7/1wGPhI+syLdaLiQ=;
        b=QuwgAPJPyJ0forGR6t8mvYLmlAWG3dd8i6den6eKITkPqtappKGQX8M/FXyXDvKBDO
         sCyB71zfZpGX0X0Zkd1PzKDHZ8a59A5t/lPuMZGbS1M2xRG4+YYAphEm2gJaqn0oftok
         QtX4X4zfdz3wGQhknnjUb43dG7J5zEN6uyZo9psH75NKmy83z90bKzFAxcRxKActHtp6
         YrQu9jzT9eWq3fCBtkwXttaNHbsd0nZb6i6h1lYR4O4RwzsWImKusWnRMVxXRju2fGDg
         zyeUqnweDHIgMECFgEFVhspZS2yMqqgkSqTE79IKn5jTH75+4EuFx+0gof83oqsAD1Vy
         HD9g==
X-Received: by 10.229.180.2 with SMTP id bs2mr13300612qcb.52.1368705277990;
 Thu, 16 May 2013 04:54:37 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Thu, 16 May 2013 04:54:37 -0700 (PDT)
In-Reply-To: <CAMP44s1vMTfrSaU+0S8EOM5g4L0885780SvT_THBr7u==bJ06A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224556>

On Thu, May 16, 2013 at 11:36 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Actually trying that command:
>
> % git fetch origin 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
> fatal: Refusing to fetch into current branch
> refs/heads/fc/fast-export/cleanup of non-bare repository
> fatal: The remote end hung up unexpectedly

Can you try something like this instead ?

    git fetch --update-head-ok # or -u

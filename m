From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] .clang-format: introduce the use of clang-format
Date: Wed, 21 Jan 2015 12:06:12 -0500
Message-ID: <CALkWK0n9MCxhTyRaJgXRSeO02A-uRvW8Ft9Ns8oxXzctpEK66w@mail.gmail.com>
References: <1421530221-39306-1-git-send-email-artagnon@gmail.com> <54BB9986.2040706@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 18:07:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDykF-0007me-Sp
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 18:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbbAURG5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2015 12:06:57 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:54610 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbbAURGx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2015 12:06:53 -0500
Received: by mail-ig0-f170.google.com with SMTP id l13so22541290iga.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 09:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KKrdNwHBOrK9ocxLZECcOF4CwLO1zTsbuKplyPs+iyY=;
        b=akfBwCadV9oS9VYT0AlASKBjvfGXmnoQdzjKprRLf6cAIXePyxpIWlIlMGJVz8fge6
         a9reCreP/cPEtKHRQxWhRSePA5GKKvqriukES8sxFCnRIyYqUXQ6qDIJnLDNO+rTRjGl
         TEafaMA/2mPc4Ie9yv0AxRHQvd9iCfMUqE2QOINSofIOCIi+CPQhKrc1rUAGCX4nC2tw
         Et+AN/efMsy11XjkZbsDzV2ZcqtLxuHOPsE1QVlHs2795o02k0vruHTFL19gRsh+zk7C
         kkpLx6aOkPd8Y9Ut4Og/rc00xClAUyimVv86pH8F5V2n2NPW3JA2YD8DKJmCtl3ldR6v
         NnQw==
X-Received: by 10.42.250.82 with SMTP id mn18mr14965481icb.1.1421860012673;
 Wed, 21 Jan 2015 09:06:52 -0800 (PST)
Received: by 10.64.102.163 with HTTP; Wed, 21 Jan 2015 09:06:12 -0800 (PST)
In-Reply-To: <54BB9986.2040706@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262732>

Ren=C3=A9 Scharfe wrote:
> However, even then struct declarations that are combined with variabl=
e
> declaration and initialization get mangled:

I'm pretty sure this is a bug in clang-format. It might be
semi-trivial to fix too.

Thanks for your inputs.

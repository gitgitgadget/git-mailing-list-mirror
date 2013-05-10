From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Fri, 10 May 2013 22:12:00 +0530
Message-ID: <CALkWK0kLjf=m-_9PkXzxOpnpqfh-n004E0f7_mi-VL3SbYWFAg@mail.gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
 <1368196178-5807-5-git-send-email-artagnon@gmail.com> <7vmws2529j.fsf@alter.siamese.dyndns.org>
 <CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com> <7vr4he3kpz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 18:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaqP7-0002N0-15
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 18:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab3EJQml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 12:42:41 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:54909 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab3EJQmk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 12:42:40 -0400
Received: by mail-ie0-f180.google.com with SMTP id ar20so8508254iec.11
        for <git@vger.kernel.org>; Fri, 10 May 2013 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vi7HbCo3XMKbET+lTX57vWbuwfhE/cD0Ed/RgRIxTjg=;
        b=WSAqgja+wz1i8ZrMQPxm9dP5u2ox5zwRhlIuC2ItzNhyuXi2Du1qx1yNm7XpePjQJa
         XDeSdRc+x9Okuh1O7AAZKZWRxLRo/HDTwBtcQR8A59Y6GtIReiQwD0f4dH7W5fmE7NR3
         j/Bdm6eEE+e1Rrv7ZC8k1dv/0+War5MvOQT795pqN/7yyjDh0zXlMWKAu54QCNBRmmx/
         e5h9MvAmYa0IFiV+bbz0frrqVLAQ3EFAYTdDNL/2P7JA6NQX75BjYdmDbtSezGGjS80I
         nLuMdFHyqq0tOiqUXpOrnrEKZ4xy4q9yQL0mDZCqr9TZdxvDiV7hGY733dZwEBQ4Iz/+
         TTiQ==
X-Received: by 10.50.57.200 with SMTP id k8mr2640064igq.44.1368204160195; Fri,
 10 May 2013 09:42:40 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 10 May 2013 09:42:00 -0700 (PDT)
In-Reply-To: <7vr4he3kpz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223880>

Junio C Hamano wrote:
> Perhaps because this is a test about "rebase" and a typical debugger
> does not want to trace other "git" things while debugging this?

Okay, let's drop this 4-part series: it's too minor.

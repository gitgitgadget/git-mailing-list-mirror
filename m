From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Sat, 11 May 2013 00:44:41 +0530
Message-ID: <CALkWK0kZWrY5_B3mxuVV1cA-AqvkqJpjRAuSovXLi6OCA+3ybQ@mail.gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
 <1368196178-5807-5-git-send-email-artagnon@gmail.com> <7vmws2529j.fsf@alter.siamese.dyndns.org>
 <CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
 <7vr4he3kpz.fsf@alter.siamese.dyndns.org> <CALkWK0kLjf=m-_9PkXzxOpnpqfh-n004E0f7_mi-VL3SbYWFAg@mail.gmail.com>
 <7vk3n6206h.fsf@alter.siamese.dyndns.org> <CALkWK0kTvwxMFGUqH0wKNVpLg-qQQbN+vOcAxiEwmOeDe=87jA@mail.gmail.com>
 <20130510190705.GA3478@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 21:15:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uasmu-0001Uc-9o
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 21:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386Ab3EJTPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 15:15:24 -0400
Received: from mail-ia0-f181.google.com ([209.85.210.181]:37176 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab3EJTPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 15:15:23 -0400
Received: by mail-ia0-f181.google.com with SMTP id f27so5110451iae.12
        for <git@vger.kernel.org>; Fri, 10 May 2013 12:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ExlKx9+Uh3g1TBst72Y8EDNsE6shgJHXujhn0oAf1OI=;
        b=SOD/bumF32ntVzeLTMPqFUmnTPGMGLf+pXMnmZ7ILwUaCTIJjBx4wRjsE2PQavW/UW
         J084MMpokl79qHoohDqg9l+CoRqSu1S6Q1b62dgR/pyOujsoVlJT23dTMPKW/qWyWcnc
         P/BJ5s88UzsinTsGl4eOlkb34YwGL1/opqwzC0GZp6xvyUxfYX0gtTxCq0T0acsZVfUd
         uCP6ZlsTkK1r+q3tYmKtD5VCGkC7PURLuH3/lvRZCZDmuYMNgSkee3XQuJC7jzBnDqyW
         ditcII6WBtacAenGRB/311d0hJvRsHjpBMQLKA2BNCF1s9Y3mS62VqwZFc8AA6M4NZLY
         OHNw==
X-Received: by 10.50.3.38 with SMTP id 6mr3099525igz.44.1368213323063; Fri, 10
 May 2013 12:15:23 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 10 May 2013 12:14:41 -0700 (PDT)
In-Reply-To: <20130510190705.GA3478@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223897>

Jonathan Nieder wrote:
> I use "-v -i" together quite frequently when debugging.  I also use
> "-v" automatically to debug test failures when tests are invoked
> automatically on machines I do not have access to.

Yeah, it makes sense on remote machines.  I just found out about -i,
and the -v -i combination is useful (and the autopager makes no sense
in this case); no doubt.  Can we do better by not printing the -v
output of the passing tests though?

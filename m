From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Re* [PATCH 5/7] git-log.txt: rewrite note on why "--" may be required
Date: Mon, 29 Apr 2013 23:08:56 +0530
Message-ID: <CALkWK0=ZzE4gK4RZ8m9oAJgP76mWsYA2Z+Wasws8hnVgOQZR7Q@mail.gmail.com>
References: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
 <1366608631-21734-6-git-send-email-artagnon@gmail.com> <7vmwsn8ok4.fsf_-_@alter.siamese.dyndns.org>
 <CALkWK0m2__SZmpyQqLjkJuMWtPuD4=Oo7QrYovq_Fw6fpHEXXQ@mail.gmail.com> <7va9ohl2k7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 19:39:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWs3C-0001Zg-0L
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191Ab3D2Rjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:39:37 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:51172 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294Ab3D2Rjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:39:37 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so7617548ieb.41
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2UoNrNCa9f6FB9XpCkgWclMFFYC2O3tnFMVcVAx0cyE=;
        b=lYnJtYcNQA1GrOYg2wT0X30GrQxT2mapF2lxqzkY8Zu0yEP+LNqEbj9Xqz8/C8yopB
         bBtfLZBVEdE5j6JGpVNHE61T3zZGzZmnUtZgcCqTwmNSwH5Oi39ZQbBxCxPCAHb2ljaX
         UgfSiadY8cQLNT29GItEqvOrUZ50BI1hh0cahLOXsqr2N2OJnc1gPen2HTDiuY0qNZpw
         Hm2NK6BkNmT92Lya2/vnKHorhzZ99qc0CkhkNwXB0c52R/UCAf8Zrstk1WJj6mstf1uW
         wekznMbbWCWLNMgQ+vAxnC65AvxkXe9jlBw7932pi0vAGN66M9yG8FQpXVNsiDwSetoS
         0Sjg==
X-Received: by 10.50.72.65 with SMTP id b1mr8053583igv.63.1367257176766; Mon,
 29 Apr 2013 10:39:36 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 10:38:56 -0700 (PDT)
In-Reply-To: <7va9ohl2k7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222821>

Junio C Hamano wrote:
> That is not a problem.
> [...]
> A more important reason to have them as separate entries is to avoid
> giving a wrong impression that "--" is somehow related to <path>,

Okay, makes sense then.  Queue it for this and shortlog; we can write
it for the other manpages gradually.

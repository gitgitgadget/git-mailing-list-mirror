From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-email: allow use of basic email list in --cc --to
 and --bcc
Date: Tue, 18 Jun 2013 15:42:31 +0530
Message-ID: <CALkWK0mTWC87Z1E3eZ_gzjXrmtFb9ir6aY7mXVBfe9oHHXCHcQ@mail.gmail.com>
References: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Tue Jun 18 12:13:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uosuc-0000gw-8l
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039Ab3FRKNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 06:13:13 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44950 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916Ab3FRKNM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 06:13:12 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so9527530ieb.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bYJCxu02NxwTLW9nLoBt9rerip7s36K4VT3CZVad/fY=;
        b=qhWl2IvmfsGP5jSmZiD8+pFCGXcrKo1KfsBpNwJINORgrrVS9Jz0O6v3/UNIT8QNPH
         kiangWkJ0Ke+pNk10wjH2iMlYVmNJCe4SYJXOmtQoBBJe/8mIHNTnEZo4pQGagtFLCLe
         j7Ju7hW+q6fnE6miJFmF1hqICJ9PCB/2SH7eh0Tq8I5Tj0YaDgmzcWPVoqbW4Spvkd1W
         05NYDLa/TpHGF14i/ea02vTOSjIJbxVfthmqXU6CxxEP6nQRm4qYIwUx43vMtsnPrkc1
         +4RTqUpzz7sbI6Tau/tJgiCPqe0AjeAM/2LdzamijQbcLTeCkMoNG8fenLWgEsSnkFIu
         y3fA==
X-Received: by 10.42.80.9 with SMTP id t9mr955408ick.14.1371550391612; Tue, 18
 Jun 2013 03:13:11 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 03:12:31 -0700 (PDT)
In-Reply-To: <1371549079-19291-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228186>

Jorge-Juan.Garcia-Garcia@ensimag.imag.fr wrote:
> The format of email list handled is pretty basic for now:
>         $ git send-email --to='Foo <foo@example.com>, bar@example.com'
> We thought it would be nice to have a "first-step" version which works
> before handling more complex ones such as:
>         $ git send-email --to='Foo, Bar <foobar@example.com>'

Is this a regression?  I can't send emails to a recipient whose name
contains a comma?

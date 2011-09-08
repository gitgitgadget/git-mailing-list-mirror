From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Thu, 8 Sep 2011 15:05:05 +0530
Message-ID: <CALkWK0nt4PXfBxGcAnavUkKM6AhKpZnw1NtZsNznzmGZiguFqA@mail.gmail.com>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org>
 <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
 <vpq7h5jtngj.fsf@bauges.imag.fr> <CALkWK0nuLHpG9xqAAVL4T21N-31m7=A3_amp7Mf0Sw9jobYDRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Georgi Chorbadzhiyski <gf@unixsol.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 08 11:35:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1b19-0001Cw-Qj
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 11:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555Ab1IHJf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Sep 2011 05:35:27 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56345 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932534Ab1IHJf0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 05:35:26 -0400
Received: by wwe5 with SMTP id 5so412999wwe.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2rqL0hNcE8z2H9HjtVC9VXEARJqP3QRKsz3xgAtLgF8=;
        b=QoOkRhNO8h/1kdZG+wW+rDJ8HJ1rVPRTqhqSD8WYSu64B6CR2M7MRf207ePic4kzWM
         rCrheOQvM4UCqlEROR8UrYAvEoB9IV9OMmdh68/DUwIa7ZyLDpvG7VFBtayXhEbw/bQm
         KXm4aJwJcmIva6gZyCyMY2JfRXxI7pvInuxT8=
Received: by 10.216.173.149 with SMTP id v21mr463937wel.96.1315474525087; Thu,
 08 Sep 2011 02:35:25 -0700 (PDT)
Received: by 10.216.51.135 with HTTP; Thu, 8 Sep 2011 02:35:05 -0700 (PDT)
In-Reply-To: <CALkWK0nuLHpG9xqAAVL4T21N-31m7=A3_amp7Mf0Sw9jobYDRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180960>

Hi again,

Ramkumar Ramachandra writes:
> [...]
>=C2=A0Yes,
> I've also wondered what to do about the order in which patches appear
> in reply to the cover letter- I was of the opinion that it was a mino=
r
> inconvenience that we have to put up with that until SMTP servers
> learn to fix these things.

Another small thought- it'll probably be a good idea to teach
interfaces like Gmane and your email client some special rules: If the
X-Mailer is git-send-email or if the subject field matches [.*PATCH
(\d+)/\d+], sort the email thread by \1.  Thoughts?

Thanks.

-- Ram

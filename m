From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] prompt: squelch error output from cat
Date: Thu, 13 Jun 2013 20:15:59 +0530
Message-ID: <CALkWK0kwVahUF_kwk4jRr7Qr5_H-FY_aXWLkQcaZV-YrV_mgjw@mail.gmail.com>
References: <1371131209-32479-1-git-send-email-artagnon@gmail.com> <20130613143942.GK2091@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jun 13 16:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un8nf-0007M9-MK
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 16:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758177Ab3FMOql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 10:46:41 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:42987 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab3FMOqk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jun 2013 10:46:40 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so17919190ieb.38
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 07:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nfS1D+LkW+iRH9hbuXnzbSkH5gj5iqRHIhvcEMtKT+w=;
        b=EruZSpsAvOsiEkJj9R65MqSDv48c7QxzrhBEYYq15jw1CmymxT/D7Ww60/4v9yJFbS
         fQ7PJ+c4Zy1mWQql6IkkchaZfZVjrcncki5PQAVgFEEhVOieSLMpmiGpwcGlJ6sHlH4j
         OjIB4jXiNi20z6xLrvxNkEurLZM4WuKZG5JviKauhoUQjcT97nJIgrwMDT6kqViQ3iIy
         uaVSeTlVfKkpoVyHANBcvsQOBBnAvNUNC+D1C9dLqT+LKgPnr1tty1xRnvQUgaF3yHKF
         UoWF/jXWcw66Km/nn7mO7gxM65GqCu8m7X4tdtZpY3/j4G6S3JlFtJPWM9y8cl0OIFRA
         Jhgw==
X-Received: by 10.50.3.37 with SMTP id 5mr482331igz.0.1371134800077; Thu, 13
 Jun 2013 07:46:40 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 13 Jun 2013 07:45:59 -0700 (PDT)
In-Reply-To: <20130613143942.GK2091@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227741>

SZEDER G=C3=A1bor wrote:
> Just curious: when do those files don't exist?  When using an older
> version of git with a newer prompt, obviously, but are there other
> cases?

  # On terminal one
  $ git rebase --interactive master
  # Ignore editor, and open terminal two
  cat: .git/rebase-merge/msgnum: No such file or directory
  cat: .git/rebase-merge/end: No such file or directory
  $

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/2 v2] Documentation/git-remote-helpers: explain how
 import works with multiple refs
Date: Thu, 1 Sep 2011 18:59:31 +0200
Message-ID: <CAGdFq_gc6scerXf6PgbDE-89nmaTo8z49L2fOJ2E_m42_7ywfQ@mail.gmail.com>
References: <vpqd3fk1cq5.fsf@bauges.imag.fr> <1314895778-17482-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 01 19:00:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzAcs-00086f-Nc
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 19:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942Ab1IARAO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Sep 2011 13:00:14 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40190 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab1IARAM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2011 13:00:12 -0400
Received: by yxj19 with SMTP id 19so514984yxj.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=e9AxRkENk88rA8xX1UMZT/CQQFgvzDlyhxn0pJqEK7w=;
        b=I288zGlfsDX5MIYTTm6Qexxi7+ES5uzmGYATZ/eygmWYhedLWS+ADIVCQPwhEOGQSy
         CxwvJO7GzFFSM1noPU3NSPpSGf4BFOzwvChB5q5XhPPJ4kd2J4hHs+EC2B/gZeBLz7Zm
         zb5iaB7KPUi0n28AqFKZpX4NtHRJhnuO+qFHg=
Received: by 10.68.5.168 with SMTP id t8mr377711pbt.93.1314896411460; Thu, 01
 Sep 2011 10:00:11 -0700 (PDT)
Received: by 10.68.43.9 with HTTP; Thu, 1 Sep 2011 09:59:31 -0700 (PDT)
In-Reply-To: <1314895778-17482-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180551>

Heya,

On Thu, Sep 1, 2011 at 18:49, Matthieu Moy <Matthieu.Moy@imag.fr> wrote=
:
> This is important for two reasons:
>
> * when two "import" lines follow each other, only one "done" command
> =C2=A0should be issued in the fast-import stream, not one per "import=
".
>
> * The blank line terminating an import command should not be confused
> =C2=A0with the one terminating the sequence of commands.
>
> While we're there, illustrate the corresponding explanation for push
> batches with an example.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

--=20
Cheers,

Sverre Rabbelier

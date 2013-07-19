From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH v3 1/3] l10n: de.po: switch from pure German to
 German+English (part 1)
Date: Fri, 19 Jul 2013 18:45:49 +0200
Message-ID: <CAN0XMO+tX0zr6q07BDfp6UyPD8SKKFEZhuVaOysWDxRJY+mb0w@mail.gmail.com>
References: <1374040279-4828-1-git-send-email-ralf.thielow@gmail.com>
	<1374078276-3510-1-git-send-email-ralf.thielow@gmail.com>
	<1374078276-3510-2-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	git <git@vger.kernel.org>, Ralf Thielow <ralf.thielow@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 19 18:45:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Doc-0008Ml-F6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 18:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933165Ab3GSQpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 12:45:53 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:64156 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345Ab3GSQpu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 12:45:50 -0400
Received: by mail-wg0-f51.google.com with SMTP id e11so4114061wgh.6
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ugd3i8OfFPUgr3UcF1xmYZRNMPsq/RO6fJRCdJggg+A=;
        b=Y9COoqVE0/sEE0J97taEhV9SY81iYMtZgxF0pAEVNGEuynPRERepWkafdwRZD+bRjL
         utgucOP8X9vkBi07tuLPnm79MXJwXFHaIZTrFWPw6Cjb+Ia10auMQqQNBTetF0jFtvQ4
         3tEO6clairzxjU2wRRMyt2EclXzqLfbF0xKxhoHX1u0b5JGRKchuBMFoLhSf1jTSh0o3
         KQ2zDcbR86/Gakscl+Obk2A7FUS9pBqGRHPbVYKbwBQLSw50KTnUiJhAQl8JBDFE/Lqd
         jtDCT+FXAcHK8SGqZc58+gF4FzxkQ4CP8qy9Vs9bd21T90oyZDObJm/adWr5HrxFWi7h
         GYDw==
X-Received: by 10.194.242.69 with SMTP id wo5mr12822230wjc.30.1374252349223;
 Fri, 19 Jul 2013 09:45:49 -0700 (PDT)
Received: by 10.194.20.229 with HTTP; Fri, 19 Jul 2013 09:45:49 -0700 (PDT)
In-Reply-To: <1374078276-3510-2-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230827>

Am 17. Juli 2013 18:24 schrieb Ralf Thielow <ralf.thielow@gmail.com>:
> This switches the translation from pure German to German+English.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 568 +++++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 284 insertions(+), 284 deletions(-)
>
[...]
>  #: remote.c:1787
>  msgid "  (use \"git push\" to publish your local commits)\n"
> -msgstr "  (benutzen Sie \"git push\" um lokalen Versionen herauszubringen)\n"
> +msgstr "  (benutzen Sie \"git push\" um lokale Commits herauszubringen)\n"
>

I just saw that I didn't change the translation of "publish" from
"herausbringen"
to "publizieren" as Thomas suggested. I don't think it's worth it to
send a v4 for
this small change. I'll change it to:

msgid "  (use \"git push\" to publish your local commits)\n"
-msgstr "  (benutzen Sie \"git push\" um lokalen Versionen herauszubringen)\n"
+msgstr "  (benutzen Sie \"git push\" um lokale Commits zu publizieren)\n"


> --
> 1.8.2.1230.g519726a
>

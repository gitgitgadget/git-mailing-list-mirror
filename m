From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v2.1] commit: add --ignore-submodules[=<when>] parameter
Date: Mon, 31 Mar 2014 23:47:14 +0200
Message-ID: <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>
	<5335A78C.60401@web.de>
	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>
	<53374E49.9000702@gmail.com>
	<533874F9.3090802@web.de>
	<5338AC36.6000109@gmail.com>
	<5338B1B0.3050703@gmail.com>
	<5339BAE4.8020306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:47:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUk36-0008HY-RN
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbaCaVrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:47:16 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:42605 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaCaVrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:47:15 -0400
Received: by mail-ob0-f182.google.com with SMTP id uz6so10003043obc.13
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 14:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HCpLbv7mvA4dPir6hsmRHX5ohcl9PX+P+3e3gIkw4v0=;
        b=LCMsxRGZUlplKvpaPbvJI/bqHqd2hG21wRA62lrelfa8tVovv67RWfJ8RutVTnb5iV
         aHyGNRAvIzPFJoATQ7WlIimZADZNURqhfd8QkIUUZ4JT78waFfIyo6mh3RLTTiXucD0+
         0rth+3NxwjfPnVe+Y9x7veTHz32O8ZAUsPy1ZB/qjWdfYiyiFJqqP8skJTdIl9EUeJpZ
         C0K3rwYgKGTesGQmlc5N/Ct1u3cxNG9MEHXHr9zH1HgN/+wzCUGHk7g7KgN8Q+uE2qHf
         KFCYMYJqNN9knyzxGH4GFc9rnogKRI1rdswyGft8RyanOkM1tAbpZG9Yhtxa79hrknre
         CFpw==
X-Received: by 10.60.227.10 with SMTP id rw10mr5271900oec.51.1396302434898;
 Mon, 31 Mar 2014 14:47:14 -0700 (PDT)
Received: by 10.76.154.68 with HTTP; Mon, 31 Mar 2014 14:47:14 -0700 (PDT)
In-Reply-To: <5339BAE4.8020306@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245539>

On Mon, Mar 31, 2014 at 8:58 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> As Junio mentioned it would be great if you could teach the add
> command also honor the --ignore-submodule command line option in
> a companion patch. In the course of doing so you'll easily see if
> I was right or not, then please just order them in the most logical
> way.

Well, if You (or Junio) really don't want my patch without another one
for git add, I may try to do it. However, git add does not even honor
the submodules' ignore setting from .gitmodules (just tested with git
1.9.1: "git add -u" doesn't honor it, while "git commit -a" does). So
teaching git add the --ignore-submodules switch in current state
doesn't seem right to me. You might propose to add also support for
the ignore setting, to make "add -u" and "commit -a" more consistent.
That seems like a good idea, but the effort needed is getting bigger,
and nobody actually complains about lack of submodule ignoring
facility in git add, while I know that the current behavior of commit
really causes trouble.

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git show doesn't work on file names with square brackets
Date: Mon, 8 Feb 2016 12:06:44 +0700
Message-ID: <CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com>
 <alpine.DEB.2.20.1602061518220.2964@virtualbox> <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
 <alpine.DEB.2.20.1602061708220.2964@virtualbox> <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
 <32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 06:07:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSe2k-0001HZ-0T
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 06:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbcBHFHR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 00:07:17 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36839 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbcBHFHP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 00:07:15 -0500
Received: by mail-lb0-f182.google.com with SMTP id dx2so76750057lbd.3
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 21:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=h8wbZxlYPz1Zo8rDfb1sSsgnr0HnBTZEvOrpd+F1Czw=;
        b=EQAnPyGQG55ApX4xceN+2sIL41yIjL2xhRThM6Y5lEoB2ewzCeu0GTKTM+JPbhxiWE
         /cd5YirMxONvWKl4jQZaPtLQRcQX0jk64Oc1HP5pRiSXdfgT4OtkYDqFTPuFh4vngmgi
         12rbLrwoqZwtINHWs++hmpy1CghCCHVlWPvwFjyVv5pjXunt+X7SZGV74PVQMEBmmK/8
         yEQUVAgehsrYBlpQmqFtUzf01BOyIUkRXoNSBqUEW4VqQ9Am0ozTkxnr+9g1C06gteaU
         24pdrByeFQY6Bo9YAXu+ubhVPejs/8bAHBuFuaD5uh9gVSCPfgPRc54bxGnUq3RSH9nl
         8ESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=h8wbZxlYPz1Zo8rDfb1sSsgnr0HnBTZEvOrpd+F1Czw=;
        b=krNd40UAvmqcHKp0chK7lXROdSRxdrMvi9fjwa+aalJ6WxIS8TIqCtLMZ1q/vYSSbU
         uElaJbeKGP5PNJ6dqyruerrJN+v6Q1N902EVHcdDQevDTI+UDfjYqn6Ay3C1K8cUCyiE
         kAjziO1wGXPBS563xHjAqYJezq4oQfJrCo+m5VNuJq3QxNigpZowPqHGFkPGgx2kG31x
         nb8zR1hKG/nj6HMIRTsUz7t2O6+sLxGZJ1k9ioUl2m8PgfiOFWzx+fbEifOlb+T2xjIv
         TIjexHNBUOx1cGDzM/gLO/dOh9jSeV1fqQfbF4DhHBDbTaw1iyrU0CmOvsj5JK3cEgEt
         mDlw==
X-Gm-Message-State: AG10YOQuxJWI7BYZWtKTOVILnmWRNa0BeDSTNHEXa17CtpW6H1UDAQ9fur2nzYZstYqaqoQNeBicR5RW/kCZmg==
X-Received: by 10.112.141.97 with SMTP id rn1mr11228528lbb.80.1454908034121;
 Sun, 07 Feb 2016 21:07:14 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 7 Feb 2016 21:06:44 -0800 (PST)
In-Reply-To: <32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285747>

On Sun, Feb 7, 2016 at 10:11 PM, Kirill Likhodedov
<kirill.likhodedov@jetbrains.com> wrote:
> Hi Duy,
>
>> It's from 28fcc0b (pathspec: avoid the need of "--" when wildcard is
>> used - 2015-05-02)
>
> v2.5.0 is the first release which contains 28fcc0b.
> I can confirm that older versions of Git work correctly without =E2=80=
=9C--=E2=80=9C:
>
> # /opt/local/bin/git version
> git version 1.7.1.1
> # /opt/local/bin/git show HEAD:bra[ckets].txt
> asd
>
> Looks like a regression?

No it's a deliberate trade-off. With that change, you can use
wildcards in pathspec without "--" (e.g. "git log 'a*'" instead of
"git log -- 'a*'"). And I still believe that happens a lot more often
than this case. Putting "--" is _the_ way to avoid ambiguation when
git fails to do it properly. Though in future we may make git smarter
at solving ambiguation (e.g. it could do glob() to test if a wildcard
pattern matches any path).
--=20
Duy

From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Wrong version of Git on your download website for windows
Date: Mon, 17 Feb 2014 10:17:27 -0600
Message-ID: <CAHd499BK6r5ydvOYrNqtihu3dePgDrxBkp1-BcTWi+-LB_V-Hg@mail.gmail.com>
References: <53022E90.90702@tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: torsten.thurow@tum.de
X-From: git-owner@vger.kernel.org Mon Feb 17 17:17:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFQsv-0006df-Tv
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 17:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbaBQQRa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Feb 2014 11:17:30 -0500
Received: from mail-ve0-f176.google.com ([209.85.128.176]:65371 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbaBQQR3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Feb 2014 11:17:29 -0500
Received: by mail-ve0-f176.google.com with SMTP id jx11so5162141veb.35
        for <git@vger.kernel.org>; Mon, 17 Feb 2014 08:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=g6j6NpkLnMaq1z9Nl3PcJs19qdbC01EI347YBywD4Xg=;
        b=xW9hXM9DmLMTkjQ7R71TgGwyKdCB/XWMUhq37BNWYh1UQlVVqZMlN0Zb9PFjjYCwmN
         9t2+V3/qZdC8iTqNg/jgZKfiaAtGg569ii6GkmD/AC/ym56kTjYzmisjCu+Lxp3Hlwky
         JcxqxvLFx5jxlmmthm5lgawPbzfP8xAvuIGKl6IHD3BCWrzzmx3G6QiYM3q0XIbdXFGQ
         QDmDbIdbbYxQNNq6UNeSxzZ5nUQ6Aco3WJMextNx0kRqZ9C/2/2JCtr6SnkAhkggH4c8
         vRDGyxDX7VpznOI0m4sa+3LzG4CBOfZrpZ4z6b0f1hgyLIuhiTb94GreSOihV+qzTeWY
         Tp3w==
X-Received: by 10.52.157.8 with SMTP id wi8mr1489936vdb.46.1392653847413; Mon,
 17 Feb 2014 08:17:27 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.49.68 with HTTP; Mon, 17 Feb 2014 08:17:27 -0800 (PST)
In-Reply-To: <53022E90.90702@tum.de>
X-Google-Sender-Auth: DGmLiQsalvHevZskfr1W1EXJduE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242264>

I looked into this and they seem to be deliberately holding off onto a
release due to some max path issues on Windows:
https://github.com/msysgit/git/pull/122

Also there are some unofficial builds for 1.8.5.4 I think, you just
have to Google for it.

On Mon, Feb 17, 2014 at 9:45 AM, Dr. Torsten Thurow
<torsten.thurow@tum.de> wrote:
> Hello,
>
> many thanks for all your working. Git is a very good help tool. A sma=
l bug
> is on your download website for windows. Here we can read:
> "Latest stable release 1.9.0 Release Notes (2014-02-14) Download for
> Windows", but the link loads Git-1.8.5.2.preview20131230.exe
>
> --
> Mit freundlichen Gr=FC=DFen
> Torsten Thurow
>
> _____________________________________________________________________=
_
>
> Dr. Ing. Torsten Thurow | computer scientist
>
> Technische Universit=E4t M=FCnchen | Faculty of Architecture
> Chair for Architectural Informatics | Prof. Dr.-Ing. Frank Petzold
> Arcisstr. 21 | 80333 Munich | Germany
> fon: +49 (0) 89 289 22-184
> fax: +49 (0) 89 289 22-179
> email:  torsten.thurow@tum.de
> web: www.ai.ar.tum.de
> _____________________________________________________________________=
_
>

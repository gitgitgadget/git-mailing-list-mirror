From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Dependency query regarding contrib scripts
Date: Tue, 1 Dec 2015 12:52:04 -0800
Message-ID: <20151201205204.GE18255@google.com>
References: <20151201165209.GA28230@salo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Richard Ipsum <richard.ipsum@codethink.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 01 21:52:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3ruO-0005oX-LC
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 21:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877AbbLAUwN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2015 15:52:13 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34963 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756807AbbLAUwH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 15:52:07 -0500
Received: by pacej9 with SMTP id ej9so16302180pac.2
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 12:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OWhAmLb5l92xEV+IwOIPhpTZVZto1oJbDArysyQc+lY=;
        b=dOiSNKOAeLuT4yKpVNIlEOKdER+d6FwjVRCgs8DHp1xTdiA6FeG19/WIp9HF0Sy/QM
         TDozyuCye8GWBVHYwF3XABGtPRgzDaLNVnSd/lhn7iar60QrsTU0qtesTLqsMsfF6d3U
         60/8Eu8cSD5W+1m09yt7TBHxCATrMFMFsILBKdZ7K6ozRFKhPhHkGtsa6uOKxjATXFbA
         /Yqe4MuZq5ki0R5ZPvm2FoS5GFNLTJMawgk2Nd2zf/cn19qAJWGCrPjNAAoW6Njeft74
         mdiNBgAtQX5pyb/dVju8WYIlbUvgHdOPjdVTEnF1f3awO6VPCGX0moJ+Kierf6nLrW8q
         77gA==
X-Received: by 10.98.18.194 with SMTP id 63mr83215292pfs.43.1449003126843;
        Tue, 01 Dec 2015 12:52:06 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5d66:f78a:ca3a:530b])
        by smtp.gmail.com with ESMTPSA id a27sm59732605pfj.36.2015.12.01.12.52.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Dec 2015 12:52:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151201165209.GA28230@salo>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281853>

Richard Ipsum wrote:

> Having read the docs for integrating new subcommands into git[1] I am=
 looking
> for some clarification of the following,
>
> "While we strongly encourage coding in portable C for portability,
> these [C, shell, perl] specific scripting languages are also acceptab=
le.
> We won=E2=80=99t accept more without a very strong technical case,
> as we don=E2=80=99t want to broaden the Git suite=E2=80=99s required =
dependencies"
>
> Does this also mean that use of non-core modules by, for example, per=
l scripts,
> is out of the question for contrib scripts? Or is it acceptable but i=
deally
> minimised?
>
> In particular I'd like to be able to make use of Git::Raw[2] and also=
 ideally
> the Moo framework[3].

contrib is its own world.  Your best bet is to ask the maintainer of
the relevant contrib script what kind of portability they require
(cc-ing this list).

If you are the maintainer, then go wild. ;-)

Thanks,
Jonathan

> [2]: http://search.cpan.org/~jacquesg/Git-Raw-0.58/lib/Git/Raw.pm
> [3]: http://search.cpan.org/~haarg/Moo-2.000002/lib/Moo.pm

From: Matthieu Brucher <matthieu.brucher@gmail.com>
Subject: Re: git p4 clone not processing branches properly
Date: Fri, 5 Jul 2013 19:11:55 +0100
Message-ID: <CAHCaCkLpobqTOUMeK2TP_=VkjRo4P3-dMwt85_CaasSuRNE1Kg@mail.gmail.com>
References: <CAHCaCkJ+zRwu67QsYidmvcwtWtPPd4XPBYDaTnHLt9HrTSDM3A@mail.gmail.com>
	<CAHCaCk+8EehnwMP98EX=cdoyQof=zPj65Vyd_YaADVquztOYww@mail.gmail.com>
	<loom.20130705T195116-413@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 20:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvAUC-00031n-Iw
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 20:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433Ab3GESL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 14:11:56 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:52159 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab3GESL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 14:11:56 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so3750151oah.10
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KVTYsoccA/b23xG370+MyWJI+5Z+OFuTS2fofbm06Kw=;
        b=UtAoi1IBKV7Na8Co3XRnVr7JyKKxA1MOpu69b20aLdepn2votLuZrwHE/sfg75jTIU
         scEc6SLCx9ngGi9TKsbrkfBgHCT981nrqw1z6AetS3RcJsPdII83WW6KPvnkvlJs8kQF
         d4CHgvVjflg8gGxKJAqxxYXLrmpU1lx0fDvmh0onb3yH4vABA4NN5bX9ArNhSlGhYmHE
         DXoa7CeEbpmbMoNvuT+YiJNMqU7ul397rirTNqk02Dq6ry6uChjmCQoNHpf4KUt7byj3
         TuFvrwQHImMdkDxhCW19S7NBQtsF2bUJpZ5tCkSlWPVm7flbLXaKXuzzJ5JfrUwvPrqT
         oFHQ==
X-Received: by 10.60.133.14 with SMTP id oy14mr12276425oeb.84.1373047915521;
 Fri, 05 Jul 2013 11:11:55 -0700 (PDT)
Received: by 10.76.153.5 with HTTP; Fri, 5 Jul 2013 11:11:55 -0700 (PDT)
In-Reply-To: <loom.20130705T195116-413@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229672>

> Hi Matthieu,
>
> Could you please try using //Depot/Project<at>all instead of selecting a
> specific revision?

I can try. Indeed, at this revision, the two other branches do not yet
exist. But @all will get everything? Last time, I only got head
(IIRC).

> Also, by using that command it means that the following depot paths must
> exist:
> //Depot/Project/Branch/Main
> //Depot/Project/Releases/2013
> //Depot/Project/Branch/Feature1

Yes, they indeed do.

> I've never used the --use-client-spec, so I'm not sure if that will not
> break the branch detection code.

I need to do that because if I don't, the depot is clobbed with
binaries. Or perhaps if I put some .gitignore stuff, I might not do
this?

> Cheers,
> Vitor

Thanks for the tips, I will try tomorrow.

Cheers,
--
Information System Engineer, Ph.D.
Blog: http://matt.eifelle.com
LinkedIn: http://www.linkedin.com/in/matthieubrucher
Music band: http://liliejay.com/

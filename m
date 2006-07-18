From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: comparing file contents in is_exact_match?
Date: Tue, 18 Jul 2006 09:15:15 +0000
Message-ID: <f36b08ee0607180215n7a68d8dfl935ff00194d23484@mail.gmail.com>
References: <20060706055729.GA12512@admingilde.org>
	 <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <87fyh1ncm0.fsf@mid.deneb.enyo.de>
	 <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
	 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de>
	 <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <17595.48003.145000.414361@lapjr.intranet.kiel.bmiag.de>
	 <f36b08ee0607171332k1da1ef77j352b31c78039d06c@mail.gmail.com>
	 <17596.4771.377000.843941@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 18 11:15:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2lfm-0007eV-VC
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 11:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWGRJPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Jul 2006 05:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWGRJPS
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Jul 2006 05:15:18 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:56028 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932093AbWGRJPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jul 2006 05:15:16 -0400
Received: by py-out-1112.google.com with SMTP id c39so1844784pyd
        for <git@vger.kernel.org>; Tue, 18 Jul 2006 02:15:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i2gc+8EeCcdNW+3vOQ461N/D1X23GKDRHPIXN9jVcqq/4j6cCakDGaowrla0ywCR5bur4o3XfmYA4uqxbHgVCXYBDJEU3qgmEKD5UbbuW6DecP1OA/ZFNRvt+mm37QAL4IfYoGsM4xsDTK70f66qfR7c78FiRffpIG/mdg/SIpg=
Received: by 10.35.121.9 with SMTP id y9mr5237248pym;
        Tue, 18 Jul 2006 02:15:16 -0700 (PDT)
Received: by 10.35.14.14 with HTTP; Tue, 18 Jul 2006 02:15:15 -0700 (PDT)
In-Reply-To: <17596.4771.377000.843941@lapjr.intranet.kiel.bmiag.de>
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23991>

On 7/17/06, Juergen Ruehle <j.ruehle@bmiag.de> wrote:
> Yakov Lerner writes:
>  > On me, it failed me on git-apply with more than 1 patches on
>  > the commandline.
>  >
>  > git-apply with 1 patch on the commandline passed, with two, failed.
>  >
>  > git-apply with two patches on commandline is the simplest
>  > testcase that exposes this problem, AFAIK.
>
> In that case tests 4109 and 4110 should fail, shouldn't they? They
> succed for me on NTFS (and fail on other FS).

Mine FAT32 FS.

Yakov

> But anyway, I did some
> quick performance check and the NO_MMAP code path seems to be as fast
> as the mmap one (even much faster in some cases). So the combination
> of windows' memory management and git mmap usage doesn't seem so hot
> (especially considering the fact that git runs about twice as fast on
> FAT32 for me).

Yakov

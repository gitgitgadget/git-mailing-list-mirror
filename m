From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Add Russian translation to gitk
Date: Mon, 27 Apr 2009 12:39:53 +0400
Message-ID: <20090427083953.GB15723@dpotapov.dyndns.org>
References: <20090426132452.GB30825@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 12:17:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyMOd-0004Zk-OP
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 10:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbZD0IkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 04:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbZD0IkX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 04:40:23 -0400
Received: from mail-qy0-f112.google.com ([209.85.221.112]:60081 "EHLO
	mail-qy0-f112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbZD0IkW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 04:40:22 -0400
Received: by qyk10 with SMTP id 10so1325373qyk.33
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 01:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dUNPvxPSPC/wcTRKcC0LFmo+t0aeC+4gw095NqgXrew=;
        b=ZinopGroQh1vgIdENUqLPDbunGW/YBxjRUxfsnp0vb43R3HhY4Xe2lhV8/ZMrywsN4
         AH5a3nlaYGh9r/f/UcyNcNMlG4H0WYP1uxzyWgb0kaQ8f+EyTXkVZ+0CW8Tfj08YpSP3
         CDjgzWDP/5fRj+XQR/AzlYCCdJpvp7xU30SyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Hoq3Sn9JaIHusdf3I86jNLVmcV7emRGhcrXg1SvfpiunWLRnIcKw5rhi4GzF9hYPqh
         pMG6EP2B/2kYLAbwgfBDcj8lT497s6QL0+hGSVWOkW8v3NdHGkVNa9y2Lguy1bgMidgI
         z70W39SqR1bWNG6WbH0TtWur3zkmbLnmMQtAE=
Received: by 10.224.6.131 with SMTP id 3mr5369556qaz.366.1240821621348;
        Mon, 27 Apr 2009 01:40:21 -0700 (PDT)
Received: from localhost ([91.78.48.223])
        by mx.google.com with ESMTPS id 2sm6316916qwi.3.2009.04.27.01.40.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 01:40:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090426132452.GB30825@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117641>

On Sun, Apr 26, 2009 at 03:24:52PM +0200, Alex Riesen wrote:
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>=20
> As with the git-gui translation, if someone understanding russian see=
s
> this, could you please take a look and drop me a note if you find
> something "strange"?

The translation uses a single Russian verb "=F0=C5=D2=C5=CA=D4=C9" in d=
ifferent
meanings (where the original English phrase had "check out", "move",
"go to", "focus) and that creates some ambiguity. For example:

> +#: gitk:2347
> +msgid "Check out this branch"
> +msgstr "=F0=C5=D2=C5=CA=D4=C9 =CE=C1 =DC=D4=D5 =D7=C5=D4=D7=D8"

> +#: gitk:2644
> +msgid "<Home>\t\tMove to first commit"
> +msgstr "<Home>\t\t=F0=C5=D2=C5=CA=D4=C9 =CB =D0=C5=D2=D7=CF=CD=D5 =D3=
=CF=D3=D4=CF=D1=CE=C9=C0"

How one is supposed to know that when we speak about branch, "=F0=C5=D2=
=C5=CA=D4=C9"
means "check out" but when about some commit then it is "move"? Only
because gitk does not allow to check out arbitrary commit _yet_?

IMHO, it is very very confusing.

I think "Check out this branch" should be translated as "=F0=C5=D2=C5=CB=
=CC=C0=DE=C9=D4=D8
=D2=C1=C2=CF=DE=C9=CA =CB=C1=D4=C1=CC=CF=C7 =CE=C1 =DC=D4=D5 =D7=C5=D4=D7=
=D8" (which literally means: Switch worktree
to this branch).


Dmitry

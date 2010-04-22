From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 08:38:21 +1000
Message-ID: <x2l2cfc40321004221538qade3dd4dkc149f2748b94ef81@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	 <20100422155806.GC4801@progeny.tock>
	 <87wrvzs590.fsf@frosties.localdomain>
	 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	 <87sk6n4426.fsf@frosties.localdomain>
	 <x2qc376da901004221448i373a342p1d7b763383e80472@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Goswin von Brederlow <goswin-v-b@web.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 00:38:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O552T-00025u-JX
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 00:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066Ab0DVWiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 18:38:23 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:33764 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab0DVWiW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 18:38:22 -0400
Received: by qyk9 with SMTP id 9so12031648qyk.1
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RK0DmgkZMc4Y8A8ujfryvvtGaeV9BoIaS77gk9/En5M=;
        b=sAigeS7imuGTVUHzApEzy3jTPAdEnRgNwhqa5UymWN9Tha+8xkTaeZhzz8z4Yk8WCK
         DQHbDPvSvJzNOuw9yCHVOij6HeW2zpghaG5nEsYBYnpP9HXSXnNm++5+O383tglaw1d/
         iRsttFA5f5ql2pmjKxwgj5w70YfqFdOY8L+QM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=beXCoAj0enPkHApRgPpkU4O2WQtc3jZRtncOQ3DjesJFqBX9DbyrwX7jobFo4E3BFZ
         sdA75cVncGHkWzjeN62BGfohwmhoUTmJ/+xfI9MgpFxtg2yCrf3BbUz99QAkDeneRNFa
         tO/6xV9BF3e4F7pfM4S1oGqfrXaKQRl9L6Y+U=
Received: by 10.229.251.66 with HTTP; Thu, 22 Apr 2010 15:38:21 -0700 (PDT)
In-Reply-To: <x2qc376da901004221448i373a342p1d7b763383e80472@mail.gmail.com>
Received: by 10.229.218.2 with SMTP id ho2mr1471302qcb.51.1271975901634; Thu, 
	22 Apr 2010 15:38:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145575>

On Fri, Apr 23, 2010 at 7:48 AM, Adam Brewster <adambrewster@gmail.com>=
 wrote:

> Consider
>
> $ echo -e '#!/bin/bash\nif git diff-tree --quiet HEAD; then git commi=
t
> -a; else git commit; fi' > `git --exec-path`/git-ci
> $ chmod 555 `git --exec-path`/git-ci
>
> Adam

Perhaps I am missing something, but I would have thought git
diff-files --quiet would be more useful in this context...

jon.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

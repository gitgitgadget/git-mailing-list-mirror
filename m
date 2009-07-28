From: Scott Chacon <schacon@gmail.com>
Subject: Re: Pro Git Book
Date: Tue, 28 Jul 2009 09:14:27 -0700
Message-ID: <d411cc4a0907280914v520d3c25xefc4e0f74046c4bb@mail.gmail.com>
References: <d411cc4a0907271056x458d7b15lc1b2868a46884175@mail.gmail.com>
	 <20090728085600.GA33224@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVpK1-0004aj-Lh
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 18:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbZG1QO3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jul 2009 12:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbZG1QO3
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 12:14:29 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:12259 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbZG1QO2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 12:14:28 -0400
Received: by an-out-0708.google.com with SMTP id d40so118271and.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XNw3ldUKVJm+bEc35RF5oNzEqBlbsEtSzyY/hG3nfxg=;
        b=nQEMHp/M1HJo8QD38xe6S/e+iBmYclQMY53akZmByObJXGt1gwjW0kbxeIy8ISwKxW
         z1Mb7DUyO+3BO31sRc7VUYi6gK08ZQJQ1PL7MbKxXW+lbUuYGmI2lUeo7aE6tVJnOnrW
         IHokdgrc9xJwXlBqPyAN3Zxifi5ugCmjnMrok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=teQtshMD47C8PiLgYD4C8lkvECyjUrS5TEfdUDpG1NGt97N2hh3JbgQ3DunsVIYR0W
         lcRcUOM4Ro7A9t8gJn9dS6NfbHAUFcbY6zURdoIrC2A2mz51tor8/CVvnDWFAtlhGkr2
         T86Cx8QLXaGj21ovO1hltVLEilSrIR9YjwTaA=
Received: by 10.100.251.6 with SMTP id y6mr10228912anh.44.1248797667834; Tue, 
	28 Jul 2009 09:14:27 -0700 (PDT)
In-Reply-To: <20090728085600.GA33224@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124260>

Hey,

On Tue, Jul 28, 2009 at 1:56 AM, David Aguilar<davvid@gmail.com> wrote:
>
> Good stuff,
> Thanks Scott.
>
> In http://progit.org/book/ch7-1.html we go through a
> lot of machinations to setup an external diff viewer.
>
> That might be a good time to introduce git-difftool, even if
> only to mention that the setup is much simpler when difftool is
> used. =C2=A0It allows you to do without the wrapper scripts.
>
> $ p4=3D/Applications/p4.merge.app/Contents/MacOS/p4merge
> $ git config --global difftool.p4.cmd "$p4 \"\$LOCAL\" \"\$REMOTE\""
> $ git difftool -t p4
>
> $ git config --global diff.tool p4
> $ git difftool
>
> It's even easier if you use one of the several built-in tools,
> e.g. opendiff, kompare, meld, etc., since it requires no
> configuration.

That's a good point - I never actually covered that, it looks like.
I'll put that in the list of things to cover for the second edition :)

>
> Mentioning that it's a fairly new feature is probably important,
> too. =C2=A0Hmm. I guess I should've send a patch ;-)

If you are interested in contributing and don't mind releasing the
rights to your contributions to also be published commercially under a
second edition in the future, please feel free to fork the project on
GitHub and send me a pull request for anything you add.  I've already
gotten errata in this manner, which is pretty cool. Otherwise I'll try
to get this in eventually.

Thanks,
Scott

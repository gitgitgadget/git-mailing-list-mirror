From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Mon, 9 Jan 2012 08:44:49 +0700
Message-ID: <CACsJy8CKK0EAy79Fahi64bUw2kfr=eunegbeA7oX_XaXEBFr2g@mail.gmail.com>
References: <20120108213134.GA18671@ecki.lan> <20120108220127.GA4050@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 02:45:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk4Ih-0001sc-Cd
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 02:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab2AIBpW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 20:45:22 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60524 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab2AIBpV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 20:45:21 -0500
Received: by bkcjm19 with SMTP id jm19so1192689bkc.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 17:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=L4AOCEfDZqz9SehEUQFMo/Eftjux55rygHMUfRmDcN0=;
        b=uOlJe9ERv34l86VLd7/fW+r2jZvU8whaU4/TIyeDV+PSsn6/59FahZp4fwh7i1UGGT
         OFH+bFy3jQlgk1OdQouVDCcKcEIx18qFC1JLvrO7AZ5V3jK5N+ovRJOmqaBNEttQDY60
         0ydTaJAH12RwLzP2Q9TT20FGieJ5bTR0JGOkk=
Received: by 10.204.156.83 with SMTP id v19mr6593502bkw.40.1326073520141; Sun,
 08 Jan 2012 17:45:20 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Sun, 8 Jan 2012 17:44:49 -0800 (PST)
In-Reply-To: <20120108220127.GA4050@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188153>

2012/1/9 Jonathan Nieder <jrnieder@gmail.com>:
> Funny. :) =C2=A0I wonder if this is possible to generalize, to someth=
ing like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git rebase -i foo^{last-merge}
>
> or even something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git rebase -i foo^{first:--merges}
>
> (where "<commit>^{first:<rev-list args>}" would mean something like
> "the first commit listed by "git rev-list <rev-list args> <commit>").
> What do you think?

Is something like this over-generalized?

http://kerneltrap.org/mailarchive/git/2010/12/24/47502

A good thing I see from having a specific option for "-i HEAD~n" is
that it's potentially shorter to type. For someone who does rebase a
lot and has CapsLock turned to Ctrl, it helps. Maybe "rebase -I" =3D=3D
"rebase -i HEAD^{last-merge}" (or "rebase -i
<the-revision-used-last-time>") and "rebase -I <n>" =3D=3D "rebase -i
HEAD~<n>"?
--=20
Duy

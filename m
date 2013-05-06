From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Mon, 6 May 2013 03:02:31 +0200
Message-ID: <CA+gHt1Aq+Hi5Uf-s+q5WaigHXP1Qyq100N=C4x4pwFf8-Q=GcA@mail.gmail.com>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
 <7vr4hmuk20.fsf@alter.siamese.dyndns.org> <CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
 <7v8v3tuu6i.fsf@alter.siamese.dyndns.org> <CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
 <7vvc6xt5ov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 03:03:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ9pf-0006h5-5d
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 03:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845Ab3EFBCy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 May 2013 21:02:54 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:59819 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3EFBCx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 May 2013 21:02:53 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so2960454lbi.18
        for <git@vger.kernel.org>; Sun, 05 May 2013 18:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=HJAlCvnwPMRhTXqkZik24mXXDeGql97HtHU0EnIWf+c=;
        b=RiMuPCRbYLp7c0rkA0kELTfgN44FKQx10GgY1o8lWMKy2ampsuNicB9ueu4BDmRxg/
         bN+fvGvN8T+UrYWPVqeU5jgxwwpGn6gCD33cg7qB4EsebEFY76aMh1/J2drsPaTyH7eU
         GfjmjQFiUG0LrTiThgAR/usHFNkfTGMPcaWl/hhde4FreYJG/RnG2BoEdy1xhCFIGXQ1
         frtxHBOFEfsTqKUD7xhy/DMuwC2JTTZRlKpts2ijLWca1r5DRgsUTcRXzMIdvWdqxqbp
         s17tOijweduhm9PFioBWy7Oj20htWuq2VOIYmo2moFIFMXpdQ1smdV2pVaGInv+bea8O
         zd5g==
X-Received: by 10.112.163.105 with SMTP id yh9mr7276121lbb.63.1367802171728;
 Sun, 05 May 2013 18:02:51 -0700 (PDT)
Received: by 10.114.184.180 with HTTP; Sun, 5 May 2013 18:02:31 -0700 (PDT)
In-Reply-To: <7vvc6xt5ov.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmIqMMRuaYYN88k89X8NYPXkHZVFXquOghut6B2Iz7otbiaViHCYeJBZZHcje05MA1u1xRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223426>

El 06/05/2013 00:36, "Junio C Hamano" <gitster@pobox.com> escribi=F3:
>
> Johan Herland <johan@herland.net> writes:
>
> > This would not allow the user to use the relevant $remote_name for =
$nick,
> > which I argue might be the more natural name for the user to use, s=
ince
> > it's the same name that is used for otherwise interacting with the =
remote.
>
> That is where we differ.
>
> The thing is, when you name a local ref (be it "refs/heads/master"
> or "refs/remotes/origin/master") with a short-hand, you are still
> dealing with a refname, not interacting with the remote at all.
>
> Taking notice of remote.$nick.fetch mappings only to complicate the
> refname resolution logic is absolutely unacceptable, at least to
> somebody who comes from the "we are interacting with refs, not with
> remotes" school, like me.

Maybe we could mark it explicity with a double slash: "$remote//$branch=
",
or similar. And it even allows a slash in the remote nick: "bar/baz//fo=
o".

See you,
Santi

P.D: Resend because the list rejected it, sorry for the duplicate.

From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Sun, 11 May 2014 21:33:51 +0200
Message-ID: <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com> <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com> <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com> <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 21:34:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjZWI-0005S2-Ex
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 21:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933601AbaEKTeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2014 15:34:25 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37434 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933002AbaEKTeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2014 15:34:23 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so7185530obc.33
        for <git@vger.kernel.org>; Sun, 11 May 2014 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u02jjysd9G8+6Tf96NEMnSGvkD8+uQtMr8JME/cj3n8=;
        b=vdf9A/mGyu3k/xWuvsGGDLyQLc6NyAbG8ewz4Bcml58NyZ6EcFWJex+KEwWXRnqEUE
         RSHEagWjdOlA2GPHG71BWF7EFKsKEdl++sixTclvaRWuuY0glAaPdVLd+GV0VOg7EjUA
         3Se/LnMtBHDxHPthj0bC2rpUp4jEUO3L7a+BtgOadKsyq3gISwmkx6qSb2Z5GJ4bKy+W
         ZfBk2WMYy1EF7fhf+xxW1PEeI11fVaeKK80qxhEy34dMJ5bC8KjbPUH7cSO7RHlKItPc
         E6orkaCHUKEKfWJp81aYvOtcFeHpje2j98vhb+oMlpizU1tvV/bsQAGxMSBHbS/xBWD0
         I7Zw==
X-Received: by 10.182.33.99 with SMTP id q3mr28687049obi.33.1399836862991;
 Sun, 11 May 2014 12:34:22 -0700 (PDT)
Received: by 10.76.76.228 with HTTP; Sun, 11 May 2014 12:33:51 -0700 (PDT)
In-Reply-To: <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248680>

> I addressed every issue reported constructively, every bug report was
> fixed, every patch reviewed and usually improved by me. I made sure
> users of older versions wouldn't be affected negatively when the marks
> file was upgraded, and I even setup automatic tests for different
> versions Bazaar and Mercurial that run every time I push to my
> repository.
>
> It is *way* beyond the quality of any other tool in 'contrib/' and even
> some tools in the core, like 'git-request-pull' (which has known bugs),
> and probably even 'git-pt'.

Junio, can you comment on this? I understand this probably doesn't
really affect the issue at hand, but it'd help clarify if it's ever
possible to move out of contrib/ nowadays.


> If git-remote-hg belongs out-of-tree, so does git-svn and git-p4. If
> git-remote-hg belongs in the contrib area, so does git-svn, and git-p4.

Here too, can you clarify a bit about what should be out of tree and
what should be in contrib? I understand that not all rules are set in
stone and that there is an historical baggage for which applying all
rules is probably more trouble than it's worth, but again it's nice to
clarify for future users. Also it'd probably be worth commenting on
unwritten rules about human factors (easyness of communication,
response to criticisim, ability to make concessions, etc).

Philippe

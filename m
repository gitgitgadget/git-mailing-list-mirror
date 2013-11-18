From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Command-line git Vs IDE+plugin?
Date: Mon, 18 Nov 2013 18:42:26 +0100
Message-ID: <CAGK7Mr7EpkE3mL2p9idNr7HdnBNxqiQ8qWs+QuyhR9DvW=Pd1A@mail.gmail.com>
References: <vpqiovpfxd1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:43:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViSqj-0001Xy-LV
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab3KRRm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:42:58 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50151 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab3KRRm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:42:56 -0500
Received: by mail-oa0-f46.google.com with SMTP id o6so1079799oag.33
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 09:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=d0wuphzc54lUKbtgIKRJF17YdDTMvWomAYpyK/xb7kw=;
        b=lHWgUYWiGz64iNxlHo+xQLvlk/AYcHLKMcEt2RcbsVcy0tw1pFDx7n2h6x7B1RXxUl
         lksc9filJFcfJtIMnoA5TIIoRZqHxGNbpmEWw/jfYjuIGOtmSrBXyXrQaMmUhiBO7Ux5
         cwwkcGeQ8zxgoTnkA/CA2aZVBiuOaLJsnPF+IubPnEvp1ZzwP9RWBmkupQCYxmFaAbpR
         MWwHo/lZNUD5cBc/ksAIy2yLng7wBU/P/qujkzAe5wSUJBnrWB/SF8vMoaI5z5fRQsf9
         u8M4zPKUdaJwW35qgnVTtuRqG/JqvVXIQKzJgt3lw8XoYXHyx8MSRPg3E69R1WEgdP5r
         Vtag==
X-Received: by 10.60.115.164 with SMTP id jp4mr20836433oeb.19.1384796576291;
 Mon, 18 Nov 2013 09:42:56 -0800 (PST)
Received: by 10.76.187.102 with HTTP; Mon, 18 Nov 2013 09:42:26 -0800 (PST)
In-Reply-To: <vpqiovpfxd1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237993>

> I'm normally an Emacs+command-line user, but I also use Eclipse or
> Netbeans on some projects.

Did you give magit a try? It's really an awesome emacs plugin, which
gives me pretty much the same control as the command line experience
without the pain. Ask me more about if if you're interested.


> I was wondering whether others had similar (or not) experience. In
> particular, as a teacher, I'm wondering whether I should push my
> students towards the GUI in the IDE, or advise them to keep using the
> command-line (we teach them git with the command-line first anyway, but
> after a year of practice, we may want to show them the GUI equivalent).

In my experience, most people prefer the GUI version, simply because
to them it's more intuitive and stuffs like visual diffs tools are
integrated, which makes them quickly realise the benefits. That said,
because it's "easier" they tend to not dig deeper and are lost at the
first little problem, e.g a simple conflict becomes difficult to
solve.

In my opinion to *learn* git it's useful to learn with the console
first, just like when you learn C++ it's useful to start with simple
exercises and not jump straight to GUI programming. When they become
familiar with the basics, I think it's nice to show them about  `git
log --graph --all --decorate` and the gitk/gitg equivalent, or "git
diff" and the vimdiff/ediff/visual merge/kdiff equivalent.

When they understand git reasonably (or if they are not lazy people
and willing to learn), then show them full integrations like
TortoiseGit (or probably the Netbeans plugin), which are nice when
everything works but you have to know console git to fix things or
simply to be aware of their limitations.

TL;DR, I think both are necessary, the command line to understand git
and the integrations/wrappers to add sugar to your daily workflow.
Visual tools are great, especially visual diffs for merging.

Philippe

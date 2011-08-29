From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] Add a remote helper to interact with mediawiki (fetch
 & push)
Date: Mon, 29 Aug 2011 08:41:30 +0200
Message-ID: <CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr> <7v4o14dppz.fsf@alter.siamese.dyndns.org>
 <CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com> <7v4o1092hn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?Q?Sylvain_Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 08:42:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxvY1-0006oJ-07
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 08:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab1H2GmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 02:42:12 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35669 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab1H2GmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 02:42:10 -0400
Received: by pzk37 with SMTP id 37so7934389pzk.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 23:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z18LKeDzDyGjZ/gXys+uWS7m+6pEJ3NQXk/28ex9zu0=;
        b=RhWB2zJjF0Q+jFbDLtHpsU0A60S4HpkpsvjbsdCvivm2vYV46g1WJ6nNffTBJm+WB3
         0JVAgB4vpFXNFMGdTZDZHe5nQERv+U074ryWKPuyAzdsYNMBUqwi+dGzMr038SeZ2PL7
         4A39UIxMeAdgDAadpxYDi95+8CtcQ0V/1pjvc=
Received: by 10.142.187.12 with SMTP id k12mr2564043wff.38.1314600130163; Sun,
 28 Aug 2011 23:42:10 -0700 (PDT)
Received: by 10.68.55.170 with HTTP; Sun, 28 Aug 2011 23:41:30 -0700 (PDT)
In-Reply-To: <7v4o1092hn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180302>

Heya,

On Mon, Aug 29, 2011 at 08:05, Junio C Hamano <gitster@pobox.com> wrote:
> Does this exchange suggest that at least we would need an update to
> documentation around "done", as Matthieu's "why is 'done' needed even
> though I am not calling with --done?" sounds like a very fair question.

No I think the documentation for fast-import is correct. If you pass
--use-done-feature or print 'feature done' in the stream the use of
'done' is required, otherwise it isn't. We did recently changed git to
pass '--use-done-feature' to the fast-import process though :).

-- 
Cheers,

Sverre Rabbelier

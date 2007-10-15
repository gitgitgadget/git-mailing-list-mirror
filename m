From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Mon, 15 Oct 2007 21:53:29 +1000
Message-ID: <ee77f5c20710150453g1220d968k9a23f2b8329a67db@mail.gmail.com>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
	 <471302D2.6010405@trolltech.com>
	 <ee77f5c20710142315j192b9f65m22d7980769a46cec@mail.gmail.com>
	 <200710150902.52653.johan@herland.net>
	 <7EDF99A4-00BD-4F89-A31F-DCA33723CDD5@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"David Kastrup" <dak@gnu.org>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	"Junio Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 13:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhOVz-00008K-FY
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 13:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383AbXJOLxc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2007 07:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757563AbXJOLxc
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 07:53:32 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:44735 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756996AbXJOLxb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 07:53:31 -0400
Received: by nz-out-0506.google.com with SMTP id s18so874762nze
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=p+JO56b0iEqe3BUHQaIw+14XF5la3a04lCn1sTs+OGU=;
        b=czXLAXwjVknGbrOgjhtDSx5adyF42+Kn60GpvvC21A6IxDQgC0qQL7rzd8rpxA8qjDxkcfAJM8pUxi9lL3jiSepi+/QVnL8MwGdFklRDl9gIS5yEJstg3RgGrYQ5inlIZyqkW7bAZsIdT0+oA/x/JPDSQnHy2h1cx2JDoSOgruU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b/8myNDzzPrlimaqdlLQEjE6lY53i3e3t6GzHs3PyfgMUJx6/qefcIFt7mY/Wl70MiTXRu2yZJUSGNFLvMl3aID2klCANqKp3NSH5yqJfRJuwuz+z0ZeMf884YuJunCz5tYOKqTIxOqG1NJGwkAgYTmpZQkK+Qj83BLaUTmyyGQ=
Received: by 10.141.115.6 with SMTP id s6mr2594801rvm.1192449209912;
        Mon, 15 Oct 2007 04:53:29 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Mon, 15 Oct 2007 04:53:29 -0700 (PDT)
In-Reply-To: <7EDF99A4-00BD-4F89-A31F-DCA33723CDD5@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60986>

On 15/10/2007, Wincent Colaiuta <win@wincent.com> wrote:
> El 15/10/2007, a las 9:02, Johan Herland escribi=F3:
>
> > On Monday 15 October 2007, David Symonds wrote:
> >> On 15/10/2007, Marius Storm-Olsen <marius@trolltech.com> wrote:
> >>> David Kastrup said the following on 14.10.2007 19:48:
> >>>>
> >>>> "unknown" clearly is much better than "dunno" though even if my =
own
> >>>> favorite would be "undecided".
> >>>
> >>> What then about a good'ol programming favorite, "void"? :-)
> >>
> >> "skip"? That would make semantic sense, right?
> >
> > ...or we could go all spaghetti western, and call it "ugly".
> >
> > (as in "git-bisect [the <good>, the <bad> and the <ugly>]")
>
> <personal opinion>
>    Yes, it's funny, but I don't think an SCM interface is a place for
> jokes or puns. Git already has one big tongue-in-cheek attribute:
> it's name, so let's leave it at that.
> </personal opinion>

That's also why I suggested "skip"; you might not be able to test a
particular commit, but you might also not *want* to test a particular
commit for some reason.


Dave.

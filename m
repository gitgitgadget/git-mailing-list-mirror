From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: specify charset for commits (Was: [PATCH] Fix documentation copy&paste typo)
Date: Thu, 21 Dec 2006 11:11:15 +0100
Message-ID: <8aa486160612210211n64dc2973jcc4e7670fec2cabc@mail.gmail.com>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
	 <20061219141618.GA2539@cepheus>
	 <7vac1jre1u.fsf@assigned-by-dhcp.cox.net>
	 <20061221085907.GA2244@cepheus>
	 <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=" 
	<zeisberg@informatik.uni-freiburg.de>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 11:11:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxKtV-0003yW-Gb
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 11:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbWLUKLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Dec 2006 05:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWLUKLR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 05:11:17 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:10292 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965189AbWLUKLQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Dec 2006 05:11:16 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2331534wxd
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 02:11:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DOZ9bBIQplt+eflgIzgcGxb7TcuPR3B0UR1oWjPoCtfmZBq0aZe62jFamzrAPaeOjaE2xiaMioFec56kH5z4eTa5KuVQjTMEbrEe9rty9z+GB49Az8lEaG4NNSiXt/VhkUZ6/MeRwH+CJW7oiPI3VKTzxibdbp2761Qr5WCDBLo=
Received: by 10.70.117.1 with SMTP id p1mr14039767wxc.1166695875720;
        Thu, 21 Dec 2006 02:11:15 -0800 (PST)
Received: by 10.70.46.19 with HTTP; Thu, 21 Dec 2006 02:11:15 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35046>

On 12/21/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 21 Dec 2006, Uwe Kleine-K=F6nig wrote:
>
> > Junio C Hamano wrote:
> > > Me, keyboard and Emacs screwed up and stored it in ISO-2022
> > > instead of UTF-8.  Sorry.
> > It's a pity, but too late to change.[1]
> >
> > What do you think about a patch that makes git-commit-tree call ico=
nv on
> > its input to get it to UTF-8 (or any other charset).
>
> We had this discussion over and over again. Last time (I think) was h=
ere:
>
> http://article.gmane.org/gmane.comp.version-control.git/11710
>
> Summary: we do not want to force the use of utf8.
>

Maybe git could have an example of the hook "commit-msg" that checks
that the commit message is in certain charset.

Santi

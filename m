From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git notes: notes
Date: Sun, 24 Jan 2010 15:27:35 +0100
Message-ID: <fabb9a1e1001240627t60f0ab0fmfe910b80439f94c@mail.gmail.com>
References: <20100120050343.GA12860@gnu.kitenet.net> <201001201148.11701.johan@herland.net> 
	<20100120182438.GB31507@gnu.kitenet.net> <7vhbqg376b.fsf@alter.siamese.dyndns.org> 
	<20100120195626.GA6641@gnu.kitenet.net> <7vska01qrt.fsf@alter.siamese.dyndns.org> 
	<4B576F5C.2050102@drmicha.warpmail.net> <7veilk1o3s.fsf@alter.siamese.dyndns.org> 
	<vpq7hr7zism.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jan 24 15:28:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ3Rh-0001l0-OY
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 15:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab0AXO15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 09:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281Ab0AXO15
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 09:27:57 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:61498 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab0AXO14 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 09:27:56 -0500
Received: by pwi21 with SMTP id 21so1736596pwi.21
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 06:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=nEodL5xLUEi3n/QV626ERb+OC0kjQ5PhvMSsJI7UIXw=;
        b=iiITyAXq1MjKGIL6CsCMkYC3JdrR9EMfkYyZuMpTqXfzVxWL5VbVolG2EDQ+YNWTtr
         croNcZQFsfq7fOlb8ZJjF2qN+zZGSHmPtieqb378IiN5M5I4DFScKd6dlKUUk5ajND/i
         ezBQTH4uyv+kttMFcpjr8YSboV2ObibORGlqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Dvut7Ahq05AXC51qc2EmnInYsCjhPAJneD8jy691rCPQf4QOqDg1vDy5dm4E2QIx4G
         9QLIJSXx1ZqDzAymfpUlY0K5XTggZZo/x2TusS4OqmX1JBJ16u1j6PknxKtUGcj6oBl0
         Xd03sgbyRALTfMIxNFnSyP+C2Mf+n/uqa9rcw=
Received: by 10.142.55.3 with SMTP id d3mr3732535wfa.273.1264343275105; Sun, 
	24 Jan 2010 06:27:55 -0800 (PST)
In-Reply-To: <vpq7hr7zism.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137900>

Heya,

On Sun, Jan 24, 2010 at 15:20, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:

> OTOH, format-patch could give the notes, below the ---, where it will
> be ignored by apply. That would make notes handy to prepare a patch
> serie with additional messages: prepare everything within Git, and use
> git send-email to send it.

I like that idea, but as an orthogonal feature, prepare notes in a
special namespace, say refs/notes/format-patch/, and then teach
format-patch a flag to honor that namespace.

-- 
Cheers,

Sverre Rabbelier

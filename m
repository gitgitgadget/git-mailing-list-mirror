From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 0/4] Extend mailmap functionality
Date: Mon, 2 Feb 2009 06:26:03 +0100
Message-ID: <bd6139dc0902012126g605eb6d3v2a2d788a983dc65c@mail.gmail.com>
References: <cover.1233520945.git.marius@trolltech.com>
	 <7vpri1o801.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 06:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTrLO-0008Fp-I2
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 06:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbZBBF0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 00:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbZBBF0H
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 00:26:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:43788 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbZBBF0F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 00:26:05 -0500
Received: by fg-out-1718.google.com with SMTP id 16so489798fgg.17
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 21:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=43aTml/ReS8/8fVdS2L81goYkZB1yhKdp+2DuFhrKEs=;
        b=bZSWZukvDRgC+1bbt4H/6QvXKOEz8d34YW+GtIzH05K3P9axGFICJyujgg+xpAkPVy
         bDOml3P9SKpmTE+amtHo88he43HI3qSQndoqj3RklY5oVIZPeK9ZfZNA7NtRwGl5VYi4
         SU12rHzYn4ZXN05n/eeSl3DYZvs8xZB05uVPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ay4VQ2raDFYs2Ye3jENQk9JlTd/zavSaWdEdijfMIDK0uftROSGHedLyK/DVPKQGcB
         x4glyF9XVa6nar5aAhWGNjgUNXrQn7B5xYeU4FyOxOSNw/n9G5xI91eFccvBuOqirxLO
         ZE6hwlFTr9GR6Fg808PunKAPw6w5bV6V2wRR8=
Received: by 10.86.71.1 with SMTP id t1mr2037538fga.3.1233552363172; Sun, 01 
	Feb 2009 21:26:03 -0800 (PST)
In-Reply-To: <7vpri1o801.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: d210f0260ffd17de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108050>

On Mon, Feb 2, 2009 at 04:03, Junio C Hamano <gitster@pobox.com> wrote:
> The new mapping however brings in more flexibility, and there may be other
> use cases where people benefit from that flexibility.  I am slightly in
> favor than neutral to this new feature.

It sure does, I use git-svn for a project hosted on Google Code, and
the e-mail addresses are totally borked (e.g., "gmail-account-id"
<gmail-account-id@the-svn-repo-uuid>). Not only that, but some
developers (including me I must admit) have a rather obscure
gmail-account-id, which is uses as the user's name for the commit
message. It would be very nice if I could provide a mapping from
"borked svn id's" to "normal, sensible e-mail addresses, including
real names", a feature which this series seems to add :).

-- 
Cheers,

Sverre Rabbelier

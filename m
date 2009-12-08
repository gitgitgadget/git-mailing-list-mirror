From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Tue, 8 Dec 2009 21:29:55 +0100
Message-ID: <fabb9a1e0912081229l7990a148j9cd2daa338662dd@mail.gmail.com>
References: <20091208144740.GA30830@redhat.com> <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian@couder.net>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 21:30:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI6he-0006Kz-Eg
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 21:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966055AbZLHUaL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 15:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966054AbZLHUaK
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 15:30:10 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:65183 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966011AbZLHUaJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 15:30:09 -0500
Received: by vws35 with SMTP id 35so2627725vws.4
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 12:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zesZ6/wV372ui1zhQOTxC+LbjjMiaiksaY3P5fEyGWY=;
        b=uyCeLBViGy/+s7B5/TF51ajRJE0JjuJVuiwEnfZsUnmjq4uQggCZIyINxw4vhnpRoj
         xlIFry/JwQokThYi5B2upHltOSTEbQrnAog+A8zAOBI4/L80fd7hBQtkKAHqyQVYokDI
         4uHDMaENgEDOblaq6UaH8pqZ4bbLo9+1/SH+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=R3WY7yR7YV/cDXpfeGhC7LYbKhUycDSRnW3k+b9wyP8CfDLiOTe5Tl9hhoFlQL8VWp
         t1izSeKH/iVtl/v23d1Z/Lfbp2621X1O7iGJiDlOHSb/cvuL7Ps30C88PBlRrLUd+IQ0
         FgzJTyJ1I7Neap88DyzZ0G4LSo0QO+QGZkB4s=
Received: by 10.220.125.40 with SMTP id w40mr1095882vcr.17.1260304215186; Tue, 
	08 Dec 2009 12:30:15 -0800 (PST)
In-Reply-To: <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134909>

Heya,

On Tue, Dec 8, 2009 at 21:22, Junio C Hamano <gitster@pobox.com> wrote:
> But I think it is a reasonable thing to _implement_ the feature to
> range-pick commits reusing the sequencing logic already in "rebase" a=
nd
> "rebase -i". =A0That essentially is what we wanted to do with "git
> sequencer" that would be a sequencing logic backend shared among reba=
se,
> cherry-pick, and perhaps am.

Speaking of which, what's the status of git sequencer? I seem to
remember some activity recently to slowly rewrite git rebase in c, but
I haven't seen anything since then. Is it still moving forward? Is
anyone interested in doing so? Just curious...

--=20
Cheers,

Sverre Rabbelier

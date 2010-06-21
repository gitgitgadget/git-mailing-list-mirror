From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 0/3] teach git-checkout -B WAS builtin/checkout: DWIM with 
	-f -b
Date: Tue, 22 Jun 2010 01:24:06 +0800
Message-ID: <AANLkTikBFKdeuqQZOTRzxKE_6nR3bNDDsEtGIJVT0nhz@mail.gmail.com>
References: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org>
	<1277140782-4064-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>,
	Erick Mattos <erick.mattos@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 21 19:24:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQkjG-0000zY-Ln
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 19:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab0FURYJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jun 2010 13:24:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55159 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758063Ab0FURYI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jun 2010 13:24:08 -0400
Received: by iwn36 with SMTP id 36so1088140iwn.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hAiSGQ7+zq+jiZdK0Qs9OUez5Kmr0AJTJU8CVBoZTe8=;
        b=XlyFRScY4WYueXboOBMkpG6899WMFCNzbqYTB6sDJxq1oDNk9tHwsSwkLRF4DNUxay
         DCTNe1BfevG30DdvyK2Q0pzmRTqA5Ge0JSVsD3zJy6XdQPAuQ+0cDjX+sr1AQuT1J1e8
         qSTsc+McZ1GosMa4U+3ATuvvL44Iu0QeCKz0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hgq9W0S6AOtkc3q3wFqOLRRNaCW2iG5SJkTpVLx2GcAtHOlD9XGw+aTMmKWK57bAqz
         YSASBzQPBY5kP/CnkKWHJ61dgD1iwVKHNaLnBhTb52eBIm7buSM6/CDJpR/qZCjhFTdR
         bMtNKbH4QXt6WyQRYJWg2DTZSnCk1b9u4P7v0=
Received: by 10.231.183.19 with SMTP id ce19mr6023934ibb.35.1277141046810; 
	Mon, 21 Jun 2010 10:24:06 -0700 (PDT)
Received: by 10.231.17.193 with HTTP; Mon, 21 Jun 2010 10:24:06 -0700 (PDT)
In-Reply-To: <1277140782-4064-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149424>

On Tue, Jun 22, 2010 at 1:19 AM, Tay Ray Chuan <rctay89@gmail.com> wrot=
e:
> Right now, the -f/--force in git-checkout doesn't carry over to -b
> operations - ie. you can't do git checkout -b branch on an existing
> branch.
>
> This patch allows you to do this with the -B option, so that one can =
do
>
> =A0git checkout -B branch ref
>
> which is equivalent to
>
> =A0git branch -f branch ref && git checkout branch

oops - forgot to add this to the cover letter:

Jeff, I've tried my best to check that the --track DWIM-ery still
works; could you second this?

Erick, does this series change how --orphan should be used?

--=20
Cheers,
Ray Chuan

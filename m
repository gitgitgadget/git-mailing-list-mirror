From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: FEATURE suggestion git commit --amend <ref>
Date: Fri, 27 Feb 2009 09:37:06 +0100
Message-ID: <fabb9a1e0902270037s3355e8e3m1533f86fd3ce2e8f@mail.gmail.com>
References: <81bfc67a0902262345i63386076rbcf6d71ed88c29ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 09:38:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcyEw-0002pe-Fh
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 09:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbZB0IhL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 03:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbZB0IhK
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 03:37:10 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:39060 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbZB0IhJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 03:37:09 -0500
Received: by fk-out-0910.google.com with SMTP id f33so466764fkf.5
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 00:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FHNbEvyxjSgJ8XV+Tr4Ql2dOyzmIjv1zQ7qJDjKSHC0=;
        b=SOZ+txzZ2u91FYDRcrbfLCOInt9bo/TChcDOId6CiHpUxezUuKE3bgZl8ocr56AT04
         V43Z1LHPgPNlzlp9lv95v7jX5/oSBkzJG4xainpa4GYMh19CUp6ZR2K7+x13QKX26RFI
         PSZQttcLKesBOdq5zNCpNlrQ+weAq2y3wRL5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FbCkxhE6i+3rYX2kRXkV6UV4fQ9dqpQJk7WdR0iunR1kPY/bSNVHssoDud9ikLeK09
         guP8qlYJVcW0zb7kb1sQLybuzC3jSZ235HZD/hyXxaVLnXH0al34leTNio3nL9dWU9dg
         37LzLkY6dr7Gpl9xkXL7uzZNdLTQpfy2IMOFA=
Received: by 10.103.11.7 with SMTP id o7mr1161362mui.103.1235723826113; Fri, 
	27 Feb 2009 00:37:06 -0800 (PST)
In-Reply-To: <81bfc67a0902262345i63386076rbcf6d71ed88c29ac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111646>

Heya,

On Fri, Feb 27, 2009 at 08:45, Caleb Cushing <xenoterracide@gmail.com> =
wrote:
> git rebase -i seems a little more tedious/unfriendly than I'd like if
> all I want to do is edit HEAD~2 (assuming no merges) it's a bit of a
> pain to do a rebase -i and then pick which patches to edit. might be
> nice to be able to do stuff like git commit --amend <ref> and have
> that call rebase =A0(as I think not rebasing is impossible?) with edi=
t
> only on the ref I picked.

Ah, yes, I would like this feature as well. But this could probably be
solved with a custom editor script that does a simple sed 's/pick
$TARGET/edit $TARGET/'?

--=20
Cheers,

Sverre Rabbelier

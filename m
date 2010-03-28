From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [Bug?] rebase-i marking the last entry for edit gives a barf?
Date: Sun, 28 Mar 2010 12:14:54 -0600
Message-ID: <fabb9a1e1003281114r3253cd0eg67a917fb67331af9@mail.gmail.com>
References: <7vd3yo2vno.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 20:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvx19-0001OX-7x
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 20:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941Ab0C1SPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 14:15:17 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:48021 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab0C1SPP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 14:15:15 -0400
Received: by bwz1 with SMTP id 1so3040362bwz.21
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=+TOQA9fNKyewGJ0BWn4gMYtxPiKFL6MeqhC53wgKjBQ=;
        b=t3lukGHYJwD3Lx3hlO6uZV9zl+gRPLHLL36yCaczMRrv+TUP/R/Qq/ykl4T8ufiFoV
         yqL6gVmkgXJbJGYm8IGCr/TfUBUWDRUfdQ4j8pLOJVpL6JB9oOdivpVIslmQySIIFggb
         pTtEZgq8/uKTg82+lmsMpDuXHR6rlFu8snYG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xvOGNPqOYFfFqiEmwTDZyiy3YZTTH396cng4BcFfHVULflzdjxOqSD6YdaHCH1Rb9Q
         pKlW0bjp28Pt8lIUIhR0wVwvrI9KnDreUzhh7PGrFYZeATquiMTDS7wl6VhrK7eicYHx
         c5A6Jsw+QWm/5gr3z6Q9mV67noA+ml3WRdnn4=
Received: by 10.204.142.7 with HTTP; Sun, 28 Mar 2010 11:14:54 -0700 (PDT)
In-Reply-To: <7vd3yo2vno.fsf@alter.siamese.dyndns.org>
Received: by 10.204.32.9 with SMTP id a9mr3269548bkd.44.1269800114187; Sun, 28 
	Mar 2010 11:15:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143416>

Heya,

On Sun, Mar 28, 2010 at 11:39, Junio C Hamano <gitster@pobox.com> wrote:
> This was after marking both commits in a two-patch series for "edit" in
> rebase -i, running "commit --amend; rebase --continue; commit --amend";
> saying "rebase --continue" at this point gave this error.

I noticed the same as well, so it's not just you :).

-- 
Cheers,

Sverre Rabbelier

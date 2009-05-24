From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Mon, 25 May 2009 00:28:36 +0200
Message-ID: <fabb9a1e0905241528r7b5102b0w5d064727125654d@mail.gmail.com>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7voctirzu6.fsf@alter.siamese.dyndns.org> <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com> 
	<7vfxeurwh0.fsf@alter.siamese.dyndns.org> <cb7bb73a0905241518l43048416i34cb905c143c63e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 00:32:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8MF3-0001iu-G2
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 00:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759847AbZEXW25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 18:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759843AbZEXW24
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 18:28:56 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:33666 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758965AbZEXW2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 18:28:55 -0400
Received: by ewy24 with SMTP id 24so2787430ewy.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zEqMNqMI0aT8W+V7V592N9j+okYu57qxuy6M6w/v8iA=;
        b=ee8Ixyo15Ec/dHxzLq2m7tjRpePZNu8DBQLha1rcJ95gR7IKJs7iT3pFonn9y25VGG
         HS+F2E1kABlTWdnQdORQ4CTfi+SFyWMwfvkYcQe338yLIBq00lNeoWstapnmfkxtiYLU
         DHX5fb4gDfr0S4VpPxorSBjvEGV/uye4YkiQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bYCcUz59K1+343ZEDaPBoRZzkjJFMpSUTrSVhimkhwJ4DFa3PNvLelRrKr1mbpjlcb
         UuXjVL68h+fJXSCrtkjP9tFbb/oePK6fxv9WaQ22heKQXoTzaiw794/ns/t6w9PTggLJ
         rF8mnFQE+LiDuiFB0vojgOCUiE2SAloW/xyvA=
Received: by 10.216.7.209 with SMTP id 59mr1234342wep.213.1243204136077; Sun, 
	24 May 2009 15:28:56 -0700 (PDT)
In-Reply-To: <cb7bb73a0905241518l43048416i34cb905c143c63e0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119870>

Heya,

On Mon, May 25, 2009 at 00:18, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Sorry, that's totally not the idea was trying to convey. In fact, just
> after sending the email I went back to the code to look for a better
> solution (I should have probably also made the first try a RFC).

Perhaps a more elegant solution is a script that munges a hg/stgit/svn
patch into a mailbox format before feeding it to git-am? 'git munge'
is free :D

-- 
Cheers,

Sverre Rabbelier

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Confusing git pull error message
Date: Sun, 13 Sep 2009 00:37:06 +0200
Message-ID: <fabb9a1e0909121537l37fcaaaewdbab37bbd61630b3@mail.gmail.com>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com> 
	<20090912211119.GA30966@coredump.intra.peff.net> <fabb9a1e0909121437q4eb432e3idde98993ac552b5@mail.gmail.com> 
	<20090912223137.GA8748@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Tapsell <johnflux@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 00:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmbDo-0003wn-Py
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 00:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbZILWhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 18:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbZILWhY
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 18:37:24 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:60983 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZILWhX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 18:37:23 -0400
Received: by ewy2 with SMTP id 2so2017091ewy.17
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 15:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=cioGWTdStPzrc+dwzIPgmR83mES65eXo1Ja7SH5epIw=;
        b=NOYrHRiLXviRvSyHy3Xq2tUl8J0ArthSR0za+8nmBcS+IKAvK/ICHVjoi00Q6hyDs7
         7qV4nP+/GJV1uPV8x6aqRkzRqmQz+jDIen8M3+wycngew4i2tNeLe6HPtpTIA5f1xEqD
         0TBSi24PzhmbIJW6fmS1OYXAtNcBbdL9zlAPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=yCibDu9jCh83/DvlAwAz3OVYSgC3f11iSHmUrXii4hpd2EsYfVS+9sIx1Zgd//6jfu
         X1H3rvOeJ3X61G4wrqwhwpkT4FlciD7HvgFDsb/KiRP8kcAVubrz00EfhByTYiAkTG7d
         FXgF1rH6RY2YxZqqz+nxgAiCvZ6lDz6gUdnQA=
Received: by 10.216.51.129 with SMTP id b1mr390523wec.109.1252795046130; Sat, 
	12 Sep 2009 15:37:26 -0700 (PDT)
In-Reply-To: <20090912223137.GA8748@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128309>

Heya,

On Sun, Sep 13, 2009 at 00:31, Jeff King <peff@peff.net> wrote:
> Fair enough. I'll change it to "I was unable to fetch" in the re-roll.

Actually, from grepping through the source there's a lot of we-ing
going on already (although mostly in the comments), and fairly little
I-ing (not based on actual numbers, just what I could judge at a
glance), so maybe changing the ones above to "we" instead is more
appropriate?

-- 
Cheers,

Sverre Rabbelier

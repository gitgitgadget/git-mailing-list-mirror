From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH 2/4] bump rename limit defaults (again)
Date: Sat, 19 Feb 2011 18:54:47 +0100
Message-ID: <AANLkTim2ETC0T8=8D5pWstZRZ95eo5V0+Pr62mNXRBH1@mail.gmail.com>
References: <20110219101936.GB20577@sigill.intra.peff.net>
	<20110219102128.GB22508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 19 18:54:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqr1B-0002vg-TR
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 18:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab1BSRyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 12:54:49 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50116 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406Ab1BSRys (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 12:54:48 -0500
Received: by vxi39 with SMTP id 39so202184vxi.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8FU0sK5PckKprM2XTnoMShX/TGn+P/q+1tFuLxAba0I=;
        b=cQUtiR0v8gTIcIUxnecTmeB55YUQ6AewzyxsIVloctQjZ8G1F+462U8ZNpUIAKFXXd
         npiSSo8KmlHx2Vh8QXAVvhxhcdz2FzjHvQA6NVVI+wckrGN3/jyiLP4QTp1ehkgVO32q
         JTR8wOMgj9ML/XNbjn6imRN6ee2czbeoCiY8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DzZqn7ox8VftWP3dV4cHCaAahlNTR0OH0vXyF3iis+dKMSRnuPCTgxABgwxc7YdiPr
         E+EbBt8/tVZm0tdxn3TOoo0ebFlN2pan5r/C3IReMpCjSaNTCWSG0SkUeqGKDblafT+8
         PSevAtXZah87oiXTCrskx/89is1kNEfygOm5Y=
Received: by 10.52.160.170 with SMTP id xl10mr3517229vdb.257.1298138087490;
 Sat, 19 Feb 2011 09:54:47 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Sat, 19 Feb 2011 09:54:47 -0800 (PST)
In-Reply-To: <20110219102128.GB22508@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167303>

On Sat, Feb 19, 2011 at 11:21 AM, Jeff King <peff@peff.net> wrote:
> Let's bump the diff/merge default limits from 200/500 to
> 400/1000. Those are 2 seconds and 10 seconds respectively on
> my modern hardware.

Just curious - what is your modern hardware?

-- 
Piotrek

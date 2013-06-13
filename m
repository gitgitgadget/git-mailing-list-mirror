From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] rebase -i: write better reflog messages for start
Date: Thu, 13 Jun 2013 22:35:27 +0530
Message-ID: <CALkWK0=hTYEq8w=jfMN_Zp1-vSGj7h=yx=nfB9_hRETLsnrknQ@mail.gmail.com>
References: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
 <1370881332-9231-4-git-send-email-artagnon@gmail.com> <7v8v2hizpc.fsf@alter.siamese.dyndns.org>
 <CALkWK0mmSKDH2vrz4a8Qb8=++NSAp2x5mCUEuLpPo9HLfmgFLw@mail.gmail.com>
 <CALkWK0=o0OxTjim=+qoBhpHkWQoVWLWjkJPqknPbr29T5ax46Q@mail.gmail.com> <7va9muvtkj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 19:06:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnAyW-00022L-6q
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 19:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756925Ab3FMRGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 13:06:10 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:48180 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab3FMRGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 13:06:09 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so7500853iea.4
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hIp90BEVMXyanQl373aZiK97t92p3U/bUmOEGfKTRvg=;
        b=gfyR6ee9/K1jbwvBA/LmHpB2JaA/8y4/K18M2CtXS+DSa8RzviOY9MLVVr+StExlOd
         KOPvCXmnpQ7UTEr4uq6m2ymopGysWeSm+5f4Rj0Qmg1qgQtYkK7zjGR4s01VBgmSyMhz
         IbXqeYsLeXo/thhsVQw8NWaODripkzk99PNEKNY5CuFQMoF6rUKD/g4cpySFuTJhuYt7
         zCpGpFRVVKrvK9LW84At9e2icJuShFyXo+LC9dvdAr4XLt2p5WXQmsqpmdWEFj/Y9aqK
         KwftpW8lXAdkdzNRFwPqbZy9WaAvKE6lgbDbUHu9gY4Zi8bmqeS8CAhj/OjE/blaq7YH
         KrAA==
X-Received: by 10.42.73.138 with SMTP id s10mr669263icj.10.1371143167622; Thu,
 13 Jun 2013 10:06:07 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 13 Jun 2013 10:05:27 -0700 (PDT)
In-Reply-To: <7va9muvtkj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227748>

Junio C Hamano wrote:
> But what does it have to do with rebase polluting the reflog?

See the series I just posted.

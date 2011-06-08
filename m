From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 01/19] transport-helper: fix minor leak in push_refs_with_export
Date: Thu, 9 Jun 2011 00:08:35 +0200
Message-ID: <BANLkTin6mYLJyusmyOycNzmZsNHOKgDWKw@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-2-git-send-email-srabbelier@gmail.com> <20110608215723.GC13021@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 00:09:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUQwE-0004rf-Cd
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 00:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab1FHWJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 18:09:18 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53509 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab1FHWJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 18:09:16 -0400
Received: by qyg14 with SMTP id 14so529869qyg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=hBmP2daQn3kuyLbkLwYqQkzBH8Hk07f5ybP0pQcJpFA=;
        b=nwLGF+tnH18CIwfJujxf7/6KuopnNy8Bq3W+cE3HKWNRYSrin6nelOLr0v6cpsTgth
         zMj3IR03qQCPw1izwxZWBJedUlHuwlAl8oLql4Q20o0c3op2eZ5fC07jUL5oydrfzaHr
         ulbhYvSmyvBE+cW9fRYnX7+UKirQpPDBMGKzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=wtRiKppMee5zwuEug+1jHtCSuxPuMEPCSMP1/pC7uzibGFzgonV2gCt8Wq62u4x9mT
         NteA12am32ho6qphGLUGOwQg32W7apRgKsYdsqcuJpakk0hbefh07ckSgwr37tSG9hzq
         71UWTuZX0Y3BFYpA6YtWgNfPlmFH+uosGoikw=
Received: by 10.229.100.20 with SMTP id w20mr5969342qcn.129.1307570956191;
 Wed, 08 Jun 2011 15:09:16 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 15:08:35 -0700 (PDT)
In-Reply-To: <20110608215723.GC13021@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175465>

Heya,

On Wed, Jun 8, 2011 at 23:57, Jeff King <peff@peff.net> wrote:
> Hmm. This and the other ones from me lack my S-o-b. I'm pretty sure my
> originals included it, so I'm not sure what stripped it out.

I'm using gmail, so since I can't really apply from the list I pulled
from your github, where you hadn't added the s-o-b it seems :).

-- 
Cheers,

Sverre Rabbelier

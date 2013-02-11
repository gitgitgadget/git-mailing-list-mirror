From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: Pushing a git repository to a new server
Date: Mon, 11 Feb 2013 13:17:29 -0500
Message-ID: <CAE_TNi=ZN8L=Qy08=UPBi_1sOixJS6qwtKF6o9KFEfTSQnAs5g@mail.gmail.com>
References: <CAE_TNin0Kb_38gnx9W36VZ8CTxYBZ9T1Dkhar1DUFHyQUq7ebg@mail.gmail.com>
 <20130211075040.GJ5210@localhost.localdomain> <CAE_TNin6-weutRDToZ7-BBGJTCcf0dwJn0ChUbFcACRU=SbjzA@mail.gmail.com>
 <20130211162714.GB16402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:18:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4xxG-0001fg-M5
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 19:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758734Ab3BKSRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 13:17:51 -0500
Received: from mail-qe0-f45.google.com ([209.85.128.45]:65442 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758709Ab3BKSRu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 13:17:50 -0500
Received: by mail-qe0-f45.google.com with SMTP id b4so2672749qen.18
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 10:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Hb+R579MwGLGJDdIgiNM1+AdzAMCg4BD6xgvYCzoZQ4=;
        b=EjqPAatlbYPEIH3hFLqaPURScStduyxX2a6doL3h7gSaJj/F1iIY2kKxPIjwP9KWdz
         HIJN/eVRPRrlTLuV9FUNmpzcamrY+NlcmBbzQ4art6vwIhhVeZFU8TduIJ5ZJuOsOTI2
         mmM0EzaUC6Eo9rpQsdocu0W70FWt4758iPbRL8xKdbJGwBciSlud4O2rsVLD4artzCbq
         1hMA8QFEjZ25zswywJ3lqRBO8yHVGlU7KYvqqVzMsyHudMoq2e5IDhVaE/0+buWG1+fn
         5a8jazd7NY6J7sdh5fjsg4e7hwIzjcFTg1LOZ9NuJi/AqMB+hgPatueyNGQKslASmTZ+
         AxXg==
X-Received: by 10.229.111.130 with SMTP id s2mr1390838qcp.91.1360606669571;
 Mon, 11 Feb 2013 10:17:49 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Mon, 11 Feb 2013 10:17:29 -0800 (PST)
In-Reply-To: <20130211162714.GB16402@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216070>

On Mon, Feb 11, 2013 at 11:27 AM, Jeff King <peff@peff.net> wrote:
[...]
> We talked about this a long time ago. One problem is that it's
> inherently unportable, as the procedure to make a repo is potentially
> different on every server (and certainly that is the case between a
> regular user running stock git and something like GitHub or Google Code;
> I imagine even gitolite has some special procedures for creating repos,
> too).

I was more interested in creating something for my self rather than
making any changes to the mainstream git.

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 20:14:04 -0800
Message-ID: <20130211041404.GA15329@elie.Belkin>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:14:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4kmz-0002Li-Do
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 05:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab3BKEOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 23:14:17 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:40905 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab3BKEOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 23:14:16 -0500
Received: by mail-da0-f48.google.com with SMTP id v40so2532539dad.35
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 20:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=hH0+2aICN2gtIcpTD3AMesgmWe84qm766Pbpec1KJCE=;
        b=U0tQ/CWltihyI+4qSt68/B4UbPH9i5457RN5htKN3w7xqtmjHE+ejxDLDT/JSccyS3
         0qjoDst9JW2HuWtkQ/ZP2lmPBRQaFMPhjqiWTG0ARMd/WwOwkB6IgOZ2hVVJmY03we2w
         fcd8c1Egx5brLIU/8pDi37pcO0eFgn+8/dh08oKifhnio3+v1j7LgWJWtw0ddwUjZRGh
         1ovjfTEgxlBP3jtwHal/hX55pTlwmjmlBZAUBOj5z0PVJFYiKephOAtKEaqjrrOAW+rd
         RysrRIPGo3AhllKI3kzJR2pUPZdjlEsfOHQaOjLpnocRtD1Zp1BlgmM4bTgOUsOiW6kA
         ZJXQ==
X-Received: by 10.68.253.104 with SMTP id zz8mr15402580pbc.39.1360556056087;
        Sun, 10 Feb 2013 20:14:16 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ps6sm6306606pbb.27.2013.02.10.20.14.12
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 20:14:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130211035908.GA4543@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215983>

Jeff King wrote:
> On Sun, Feb 10, 2013 at 05:20:16PM -0800, Jonathan Nieder wrote:

>> +When run interactively (with no arguments), 'git-shell' will
>> +automatically run `~/git-shell-commands/help` on startup, provided it
>> +exists.  If the 'help' command fails then the interactive shell is
>> +aborted.
>
> Doesn't that mean that people who currently do allow interactive access
> and have a ~/git-shell-commands/help (that returns zero) will get
> spammed by its as a motd each time they connect?

Only interactive connections.  That's the existing behavior.

[...]
> What about "ssh example.com foo"? Do we want to allow a custom message
> there, too (it might be different there; e.g., an allowed list of
> commands might make more sense)?

I wouldn't mind, but it's definitely not my itch.

Hoping that clarifies,
Jonathan

From: John Szakmeister <john@szakmeister.net>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Thu, 8 Sep 2011 11:02:11 -0400
Message-ID: <CAEBDL5VAFaWYctJotxTA8ajy_0KtR8H_4SoDHK29Ofd65mYdKw@mail.gmail.com>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
	<4E6769E3.4070003@drmicha.warpmail.net>
	<CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com>
	<4E68C04F.9060804@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kyle Neath <kneath@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 08 17:02:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1g7Q-0005yQ-BJ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 17:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab1IHPCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 11:02:13 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46126 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab1IHPCM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 11:02:12 -0400
Received: by vxi9 with SMTP id 9so264297vxi.19
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=k2DFyncT8HBjuukmYNzFTYx7Aj+c+jagfXg/4XPcsDw=;
        b=vEj9U46ioNu3nA79wheNfQldsK3kifWantgThVEdMJ+mutW7z3V81olvS5OUyQemcU
         NfP9+I2BNKafiLiztmStHnsi5Gug30hE++Tkp1/m5XPTodWAENE/khdEpg0UG/q7ldib
         Oi5yNFcE8Fy2+KO4e6gyAqXmv1fbcVtYqBP0E=
Received: by 10.52.68.137 with SMTP id w9mr817236vdt.258.1315494131424; Thu,
 08 Sep 2011 08:02:11 -0700 (PDT)
Received: by 10.52.160.196 with HTTP; Thu, 8 Sep 2011 08:02:11 -0700 (PDT)
In-Reply-To: <4E68C04F.9060804@drmicha.warpmail.net>
X-Google-Sender-Auth: puJpSu-N_5s5My_JRhaNX5FSr4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180977>

On Thu, Sep 8, 2011 at 9:17 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
[snip]
> It would be interesting to know what we can rely on in the user group
> you're thinking about (which I called ssh-challenged). Setting up ssh
> keys is too complicated. Can we require a working gpg setup? They do
> want to check sigs, don't they?

I don't think you can require a working gpg setup (at least for not
addressing the ssh-challenged group).

[snip]
> Or that in C, probably using Junio's gpg-lib. That would be secure and
> useful *if* we can rely on people having a convenient gpg setup
> (gpg-agent or such).
>
> So: What credential store/password wallet/etc. can we rely on for this
> group? Is gpg fair game?

I think there probably need to be providers for using Keychain under
the Mac, gnome-keyring and kwallet under Linux, and probably something
using the wincrypt API under Windows.  I don't think there's a
one-store-fits-all solution here, unfortunately. :-(

I'm actually tempted try and work on a couple of those myself.

-John

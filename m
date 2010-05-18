From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] WIP: begin to translate git with gettext
Date: Tue, 18 May 2010 17:02:08 +0000
Message-ID: <AANLkTikbl3jDXzdBhd0w6jSXTD-q5kai6Sy6CKLVmRdD@mail.gmail.com>
References: <20100517160503.GA12717@unpythonic.net>
	 <4BF24467.7000204@drmicha.warpmail.net>
	 <20100518164002.GC20842@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	Thomas Rast <trast@student.ethz.ch>,
	Marc Weber <marco-oweber@gmx.de>
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Tue May 18 19:04:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEQDl-0001N3-Qf
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 19:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758203Ab0ERRCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 13:02:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37716 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758191Ab0ERRCJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 13:02:09 -0400
Received: by iwn6 with SMTP id 6so1826720iwn.19
        for <git@vger.kernel.org>; Tue, 18 May 2010 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZtGUxcFwuEv+Pj4Nu6/Zy9W0wZyT5sEoGJD41Weer1w=;
        b=xxtcCkFFhKPsOcXso3LgS4WmIF8r6IkNB9JqYffdtGy9cUm3mbX1Pw3zKSIpLWzgnw
         KzJ2s13oMvX5qF5Gxg/v1bnqv7/DdsvMA0+ZEatpdCjP/x+TDj3/0lbkciimIc5GjvX4
         CwV8ONwNOAa1FOw6he7RNTkYEeeBk81e0AKDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sv+VoiqjPYpUdnIydNS0OMTcrAK0ltysxG1JXRipCnPepLfHfLCwCHiabM29xlsRDa
         V9RFoUDTuC9xmw2ocX8EmyTdiQKPsHvkOIzZ6awmTsRiJWprUawzVqHmsrJ9Ixx2XEOx
         3QM8lJxqM9eb0U2brgwrZYiCTJSpFl3fgT0YI=
Received: by 10.231.150.18 with SMTP id w18mr2231848ibv.43.1274202128772; Tue, 
	18 May 2010 10:02:08 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 18 May 2010 10:02:08 -0700 (PDT)
In-Reply-To: <20100518164002.GC20842@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147290>

On Tue, May 18, 2010 at 16:40, Jeff Epler <jepler@unpythonic.net> wrote=
:
> The amount of work to mark all the source files and then to keep the
> marks up to date should not be underestimated--and that's just the wo=
rk
> to enable translators to localize the software. =C2=A0It is important=
 to
> gauge the interest in the git community in actually doing this work.

It's also something you shouldn't overestimate. I've been involved in
internationalizing several projects that were previously English-only.

The work of making things translatable can be done incrementally. You
also don't have to get everything right the first time, the current
proof of concept translation of `git status` for instance suffers from
numerous problems, but it's still better than nothing.

It can be used as-is and then incrementally improved by arranging the
strings more intelligently in the future.

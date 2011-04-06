From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] stash: fix false positive in the invalid ref test.
Date: Thu, 7 Apr 2011 08:47:07 +1000
Message-ID: <BANLkTimqG4XSTRGH-+EMi6vYL7N8JU1Mtw@mail.gmail.com>
References: <1302045673-59982-1-git-send-email-jon.seymour@gmail.com>
	<20110406182726.GC8205@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 00:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7bVK-0002b8-Vj
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 00:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab1DFWrJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 18:47:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37108 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027Ab1DFWrI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 18:47:08 -0400
Received: by iyb14 with SMTP id 14so1889401iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 15:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OVK3WDDaWkiGNPGbHaJFHNrz5ITzlaDteuzdkcA1mF0=;
        b=x/kGMrsrmc9scnUja/MzMB/Rw5K21xVeQIRPLetsR5wg1ytUoPDYK67l33AotQk4Va
         JXPsSQFq+U2nbH/oztqarW4WSAgmNalnyfxTS67UeQrIFvhiJN3FxLHUfXnIEpnk4zEH
         RqJbV89DhwLfsyR44jI0TVJaMct0yaEf+iNNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QgL7EUoZv+EdEt2NhQAF+ZWl0SiIq7WbAOpZQOuMucZgTP0Sn50XXAs4tCVHa5toId
         RIk88O80x/DtDvn+/HFMOLgBxV9Eg+eQd6yBsbMGwmB63bOMlUcWa7xd/DDNAP7vtnzz
         fIPAeJR1hiO7QBchFq5hpmMGqI++J7XPTVV2s=
Received: by 10.42.159.199 with SMTP id m7mr291676icx.78.1302130027187; Wed,
 06 Apr 2011 15:47:07 -0700 (PDT)
Received: by 10.42.241.197 with HTTP; Wed, 6 Apr 2011 15:47:07 -0700 (PDT)
In-Reply-To: <20110406182726.GC8205@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171024>

On Thu, Apr 7, 2011 at 4:27 AM, Jeff King <peff@github.com> wrote:
> On Wed, Apr 06, 2011 at 09:21:13AM +1000, Jon Seymour wrote:
=C2=A0 =C2=A0 git stash drop
>
> Probably we should just squash your fix in with my first patch, and d=
rop
> my test. =C2=A0Your fixed version is a superset of what mine tests.
>

I was wondering if it might be better to break up the original test,
so that each sub-function has its own invalid ref test? If there is
agreement, I can do this on top of 9355fc which is the tip of the
branch containing these fixes that has been merged into pu.

jon.

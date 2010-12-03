From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Way to specify an exclusion refspec?
Date: Fri, 3 Dec 2010 02:20:15 +0100
Message-ID: <AANLkTimXg0M8H_WrgqMJx=_r+Q=ghp1N9WaQq8NSgWCX@mail.gmail.com>
References: <AANLkTi=YPJKvNW3PKcaSTRSPFCARHC=hn2OtSYOoe7DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 02:20:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POKKH-000069-Kk
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 02:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758312Ab0LCBUg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 20:20:36 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63250 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758251Ab0LCBUg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 20:20:36 -0500
Received: by gxk1 with SMTP id 1so1562350gxk.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 17:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/i8w3oq+I3Z0jFS10w6Ze52AGidqxxFJ8QsulxFJ5IE=;
        b=COqifFBytJtRV6ZPo858nHxCNY1p0Yu/6/xPRspNSixwZQSSnEZ9GebdZXkTBoIgeF
         qDe7UdO+BLrmOdhgALhhdEDljwm2Qr4TWk1ZPdfP2v48gZkNa+8+uHHnwImE/vog4FLF
         R/omhIF6YY42KT7jhnCmyYaItIrWybIVi0IB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ryE2Vk7bTlut6E2ZHpKKhSdf4vKvnEn2AL1ewSkpLPuTSyrK1fxUAvv+/iAs/FFdWF
         PnPfQWtMMztDf0lRQ8s4R8zYIjBphwOl/Bs0QW0DDx4+Yj3qm2c8RrI7ePSJRoSg7INm
         kghHZCOgDgs9a6hTJpgmBFrPCjpRzyStkni/Q=
Received: by 10.150.196.17 with SMTP id t17mr2616863ybf.302.1291339235310;
 Thu, 02 Dec 2010 17:20:35 -0800 (PST)
Received: by 10.151.100.19 with HTTP; Thu, 2 Dec 2010 17:20:15 -0800 (PST)
In-Reply-To: <AANLkTi=YPJKvNW3PKcaSTRSPFCARHC=hn2OtSYOoe7DA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162757>

Heya,

On Thu, Dec 2, 2010 at 23:17, Dun Peal <dunpealer@gmail.com> wrote:
> But how about specifying an exclusion refspec? =C2=A0For instance, we=
 want
> to fetch all heads (`*`) except `foo`, or all heads beginning in "ba"
> (`ba*`) except `bar`.

This has come up before, it's not currently possible, but I think
there's interest in having it implemented.

--=20
Cheers,

Sverre Rabbelier

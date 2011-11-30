From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: log: option "--follow" not the default for a single file?
Date: Wed, 30 Nov 2011 19:38:23 +0100
Message-ID: <CAN0XMOJGm1frOi7FEke7LfHCSBt2DRn_npkdKe0m3qZ=hQPNHw@mail.gmail.com>
References: <CAN0XMOJsiw0c4j_LooRrj80CVVy0omGLUcjDg4QoD4mNS3y1GA@mail.gmail.com>
	<20111130063743.GB5317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 30 19:38:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVp38-0003jU-GZ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 19:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411Ab1K3SiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Nov 2011 13:38:25 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52356 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1K3SiY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2011 13:38:24 -0500
Received: by ggnr5 with SMTP id r5so920854ggn.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 10:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OxhjhN4Lh8Mkp0bBdpg7FWPZ+SvljklUfYTClyHsQ7U=;
        b=VOSWCvkLrL0dGbw5GCAr16WN/kxJ3gxx8ZrSBHXuKEJeOrMnnFz5Gi30XXTUnzdMaI
         eCjG9D0/YGRHciC4aIpCAveAu0dCpQMIPAUQwlJ8XG/LPaMmKi9VC9kq/vFTDo8fXgRY
         9Zva96QIhRmwK6XEwXYawCm6EXQeJVl5s2xkA=
Received: by 10.236.185.9 with SMTP id t9mr5915041yhm.50.1322678303970; Wed,
 30 Nov 2011 10:38:23 -0800 (PST)
Received: by 10.146.249.18 with HTTP; Wed, 30 Nov 2011 10:38:23 -0800 (PST)
In-Reply-To: <20111130063743.GB5317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186134>

> =C2=A0 =C2=A0 pathspec. That may happen to match a single file in the=
 current> =C2=A0 =C2=A0 revision, but to git it is actually a prefix-li=
miting pattern, and
Is it possible to detect the case of a single file in the current
revisionand use "--follow" by default for exactly that?

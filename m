From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 21:00:56 +0100
Message-ID: <AANLkTikAfSrfKRaK3ozXV_eT6Rd-VRbXQUQLk3SY8QnJ@mail.gmail.com>
References: <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
	<alpine.LFD.2.00.1009040040030.19366@xanadu.home>
	<5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
	<AANLkTi==yv2CkgKEPJbTLf0P2XMtLmny1t6Zqhwh8wbV@mail.gmail.com>
	<20100904181405.GB4887@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: "Ted Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 04 22:01:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OryvD-000831-PN
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 22:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab0IDUA6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 16:00:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36073 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab0IDUA5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 16:00:57 -0400
Received: by vws3 with SMTP id 3so2280778vws.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zZG8Nx6nFl0tClrFDz9rNVfCNiPYyHrJ/8d+ppjY94c=;
        b=G8xdqi+5KXRGOeOisZH8nROEYrPKYppsRPC6DjSx9szAKgKEj7CRFvuz4jAPjfQEec
         HE5iy7HiNRSrcSX0PXcH9JoxgIyIU99DXXNP65hoR8Cdv6eJF731N2kBfJhGmP33xtfM
         kJpYhtxQH396yqbXiiFgW6eKWX0d+2PMcATCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IE8dAE62SB4k3lIOUNSzh1sMQvLB4w3Pi+K9V10rB6qbv+wWAPiOx86Axoo9FLEKZG
         zEAEu0rZHzwogcS7dYgSby+E718YqbIOjtfbdD6FEJFgisPOXoLzgPSL4aOXBHqbVKq6
         NothaEU1aub2MU60vAALJ5gD+4l+u3evG/pY4=
Received: by 10.220.129.13 with SMTP id m13mr971318vcs.132.1283630456403; Sat,
 04 Sep 2010 13:00:56 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sat, 4 Sep 2010 13:00:56 -0700 (PDT)
In-Reply-To: <20100904181405.GB4887@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155353>

On Sat, Sep 4, 2010 at 7:14 PM, Ted Ts'o <tytso@mit.edu> wrote:
>=C2=A0At least
> where I live, my local ISP (Comcast, which is very common internet
> provider in the States) deliberately degrades the transfer of
> peer2peer downloads.

 if microsoft can add ncacn_http to MSRPC for the exact same sorts of
reasons, and even skype likewise provides a user-config option to
specify "port 80" or port "3128", then it's perfectly possible to do
likewise. ncacn_http actually has HTTP 1.1 headers on it, and, once
you've negotiated enough to look like HTTP, the raw socket is hander
over to MSRPC for it to play with.

> Which brings me back to my original question --- what problem exactly
> are you trying to solve? =C2=A0What's the scenario?

i described those in prior messages.  to summarise: they're basically
reduction of dependence on centralised infrastructure, and to allow
developers to carry on doing code-sprints using bugtrackers, wikis and
anything else that can be "git-able" as its back-end, _even_ in the
cases where there is little or absolutely no bandwidth... and _still_
sync up globally once any one of the developers gets back online.

 so i'm _not_ just thinking of the "code, code, code" scenario, and
i'm not just thinking in terms of the single developer "i code,
therefore i am" scenario.  i'm thinking of scenarios which increase
the productivity of collaborative development even in the face of
unreliable or non-existent connectivity [carrier pigeons...]

l.

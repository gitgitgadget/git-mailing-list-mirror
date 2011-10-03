From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 03 Oct 2011 02:49:15 -0700 (PDT)
Message-ID: <m3d3eeo17l.fsf@localhost.localdomain>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com>
	<20111003074250.GB9455@sigill.intra.peff.net>
	<4E8975E7.2040804@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 11:51:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAfBA-0006zX-9g
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 11:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524Ab1JCJvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 05:51:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50746 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab1JCJvO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 05:51:14 -0400
Received: by bkbzt4 with SMTP id zt4so5086164bkb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=rH9uAaGbAujZDYCILQT+4ONZG419fYk5WqcerqbeMVw=;
        b=aFt8Q08TOPiO8pk9mfUwZr57XFEgMchrDkTQ9qFTZ/OUjdE1vjF0DqshlZ3Btj+set
         VMUT+6P0DHDJRYX1J5FqXnQ5d+4f7P5fTlCGRHdWqB7O6oF3tkfWOnW6V6Ik6RrxIsiP
         LZPPplEiEZuRs1vyXOSMobzZC9A4FTAWkc1u8=
Received: by 10.223.29.69 with SMTP id p5mr6915209fac.35.1317635357265;
        Mon, 03 Oct 2011 02:49:17 -0700 (PDT)
Received: from localhost.localdomain (abwl123.neoplus.adsl.tpnet.pl. [83.8.235.123])
        by mx.google.com with ESMTPS id k26sm20571780fab.12.2011.10.03.02.49.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 02:49:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p939mbkN014820;
	Mon, 3 Oct 2011 11:48:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p939mFQw014813;
	Mon, 3 Oct 2011 11:48:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E8975E7.2040804@viscovery.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182645>

Johannes Sixt <j.sixt@viscovery.net> writes:
> Am 10/3/2011 9:42, schrieb Jeff King:
> > I still think push-over-git:// is a bit insane, and especially now =
with
> > smart-http, you'd be crazy to run it. And in that sense, I wouldn't=
 mind
> > seeing it deprecated.
>=20
> You must be kidding ;) It is so much easier to type
>=20
>   git daemon --export-all --enable=3Dreceive-pack
>=20
> for a one-shot, temporary git connection compared to setting up a
> smart-http, ssh, or even a rsh server.

I wonder if that is the case... but 48% responders of "Git User's
Survey 2011" (3424 out of 7100 responders who answered queston=20
"23) How do you publish/propagate your changes?") answered that they
use push via git protocol.

See https://www.survs.com/results/Q5CA9SKQ/P7DE07F0PL

--=20
Jakub Nar=EAbski

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 03/13] introduce credentials API
Date: Sat, 10 Dec 2011 03:43:01 -0800 (PST)
Message-ID: <m3r50chcvm.fsf@localhost.localdomain>
References: <20111210102827.GA16460@sigill.intra.peff.net>
	<20111210103111.GC16529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 12:43:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZLKk-00008E-F2
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 12:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab1LJLnK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 06:43:10 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35088 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab1LJLnH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2011 06:43:07 -0500
Received: by eaak14 with SMTP id k14so2115345eaa.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 03:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=RREDSyS9kHuA4B/A2fOJ9ech1rPNGW5CJ00jvJDXv/Y=;
        b=MrqFAZLwgvnNCdYoTylXps2dGOmVRTmZ1RhqhETZYqkvJPmB9ogZxp2ulmR4lm5n/l
         83AV/ZF8bubSmP0qjO/wOyyKSXcw3jW9l5fR67h5q0IoH/LYtK054h0LlvxLWpo/7cUg
         rnwO/ZQViYzxNdtV0OgyWov3Ajp1WfvjyZpsg=
Received: by 10.213.9.68 with SMTP id k4mr2316968ebk.8.1323517383366;
        Sat, 10 Dec 2011 03:43:03 -0800 (PST)
Received: from localhost.localdomain (abwc156.neoplus.adsl.tpnet.pl. [83.8.226.156])
        by mx.google.com with ESMTPS id 58sm44567740eet.11.2011.12.10.03.43.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 03:43:01 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBABgNg5001422;
	Sat, 10 Dec 2011 12:42:28 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBABg6jZ001418;
	Sat, 10 Dec 2011 12:42:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20111210103111.GC16529@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186761>

Jeff King <peff@peff.net> writes:

> There are a few places in git that need to get a username
> and password credential from the user; the most notable one
> is HTTP authentication for smart-http pushing.

A question: does it work also for access via SSH, either without
public key set up (i.e. 'keyboard-interactive'), or with encrypted
private key without ssh-agent set up?

It would probably require URL i.e. ssh://git.example.com/srv/scm/repo.g=
it
or git+ssh://git.example.com/srv/scm/repo.git and not scp-like
address i.e. user@git.example.com:/srv/scm/repo.git, isn't it?

--=20
Jakub Nar=EAbski

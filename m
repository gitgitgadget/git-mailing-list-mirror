From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 14:53:29 +0100
Message-ID: <AANLkTin_qX2S+orrj25=GjB6kf8B6GRSE+HVFUAkDGSb@mail.gmail.com>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
	<20110321215310.GA2122@sigill.intra.peff.net>
	<7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
	<7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
	<20110322111844.GA32446@sigill.intra.peff.net>
	<20110322132820.GA14559@sigill.intra.peff.net>
	<AANLkTin3fXkGaC5cTVny5adU=FusQV0WAcPHLUEeEzLi@mail.gmail.com>
	<20110322134358.GA19064@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 14:53:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q221n-0001ml-4M
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 14:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab1CVNxc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 09:53:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64517 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab1CVNxa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 09:53:30 -0400
Received: by bwz15 with SMTP id 15so5846407bwz.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9OeSlZgLtC293k0cQxymg240mzpDQboUx7g2HW3R/FE=;
        b=bWwe8UeLWvg4TLrdou8PZ36Hth5Vim667SHuPSCZ64D5p9R+ulklRR4Fgynnxchiz+
         ApzplTlEYpchSWPRSsx6RlbUKrnw0eDKm0Zlz1siaA4VO2QpsVG/q7VpfXg+3kPL7u9U
         4Gad2UhIlF3PY1aGEmc5lsEVF2UBwibp39Df8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HSMAHSl7wqwFhZ8BQB+Ac7XMsohtteeguL8+wmupI0TtBR/KNlbuJVmWsuQMcfQjgy
         j8Xw/mgTmvouGoz/ZFMpgtnn6xBTZptNgbON49doPHzTEEajvjwYUjc4GSyFsuzByGt2
         /Ka7bE0NQ+lcURJN1kE4mLKTtnUZkTIOlU62Q=
Received: by 10.204.154.199 with SMTP id p7mr4884260bkw.114.1300802009257;
 Tue, 22 Mar 2011 06:53:29 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Tue, 22 Mar 2011 06:53:29 -0700 (PDT)
In-Reply-To: <20110322134358.GA19064@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169738>

On 22 March 2011 14:43, Jeff King <peff@peff.net> wrote:
>
> Yeah, that certainly improves the situation.
>
> A small formatting nit: Those long commands with punctuation get hard=
 to
> read in the middle of a paragraph. Maybe something like this on top:

Thought about it but wasn't sure of the asciidoc formatting... I'll
fix it and submit a proper patch...

> PS Your patch was wrapped on the @@ line. You might want to check you=
r
> =A0 mailer settings.

Yeah, gmail is sucky in that regard... :-/

--=20
/Lasse

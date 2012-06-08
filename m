From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.7.11-rc2
Date: Fri, 8 Jun 2012 11:02:56 +0800
Message-ID: <CANYiYbFYjm47iW3NfvHoKj31Q5b2L22ayp7TKGF=WiGqOuQ4Qg@mail.gmail.com>
References: <7vd35ag8ul.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 05:03:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScpTa-0006Ch-Fa
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 05:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760442Ab2FHDC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 23:02:58 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63965 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab2FHDC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 23:02:57 -0400
Received: by gglu4 with SMTP id u4so959178ggl.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 20:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+PN2w2MfwtmEUqQXBoSQEE1PdjaNjzJFLOxbbs5uEwQ=;
        b=Cp3iJyK3WWddUvF223JJP9OMg/kM9VJrUaxVglAPlNPbyQK5QqHtENDCQXS76ez5ag
         W1dAnVmLIzts02VsqLIfc+Lh0kgXL1VBRZBqsAmIevpqxGaO+a0575gDeJZi2iGghrpR
         mXXqCLXz1nwsZfF4GnwtSyxPRCCgmj06qbto4VIZfXKln/c+VB+ke7Wsu/lIB0WC/CAo
         +pOyUrp+LgaFzhruFhes0LlvL3DEUHXmGMJYPv6BhXpH/8YC5m1V0cSb4pcJJw8yJmwH
         qIwn9XKKZ44s+wszCK2tS0pWKR876RLssJoucuSbk10beg24m5n3KzXEIVhMxGi7BGRj
         W1Bw==
Received: by 10.50.212.66 with SMTP id ni2mr2342775igc.66.1339124576623; Thu,
 07 Jun 2012 20:02:56 -0700 (PDT)
Received: by 10.50.111.194 with HTTP; Thu, 7 Jun 2012 20:02:56 -0700 (PDT)
In-Reply-To: <7vd35ag8ul.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199463>

Hi all,

New "po/git.pot" was generated. See this commit:

 * https://github.com/git-l10n/git-po/commit/7256fd7c8024e3886556d9a19e84a8d20ded1a17

Even though the patch ([PATCH 1/2] i18n: Extract msgs marked
by sh gettext wrappers) was not included in git 1.7.11-rc2, I still
generated a new "po/git.pot" with local hacked Makefile. It is
because I will be on a consultant service for 1 week, no much
time for me to track git.git update.

In this update, there are 27 new messages marked by previously
ignored shell gettext wrappers (gettextln and eval_gettextln).
Much of them are for git-am and git-bisect.

-- 
Jiang Xin

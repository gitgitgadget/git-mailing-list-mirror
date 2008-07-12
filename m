From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] t/: Use "test_must_fail git" instead of "! git"
Date: Sat, 12 Jul 2008 09:04:21 -0700 (PDT)
Message-ID: <m3vdzbccoq.fsf@localhost.localdomain>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net>
	<1215877672-17049-2-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 18:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHhbA-0002wR-4s
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 18:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbYGLQEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 12:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbYGLQEZ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 12:04:25 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:28754 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbYGLQEY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 12:04:24 -0400
Received: by gv-out-0910.google.com with SMTP id e6so782107gvc.37
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=CXGaYoyzLfBg0Ude7Z9UqC0FC/nHna9Q/PDOHb760ss=;
        b=vFK3e17rS5sEifhw1ra1L6pUPKn8MJf2OQgY6kxzBQL7Rnx/Qm7iRYH3nlNl7X9YF0
         Bg3oFEOqqySLqzrbFe+1UVBMZ1yvK5gQFyErOppl5GWB9CFGBfQTju+yVJbqJsNRObNB
         nOeZNpkU2TpMdjd+ETDvX0BBv/bJv3Zyd1Hho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=WuGu2VuJmNvOvkS8feAMwHtiwkiimnoECcEEZU740wLe+EhL0PIsvCsajOkBn8BTRF
         e8kMNudD+jWua9/et4epLynqM0UgUurkUMeaPjG/UZna1ez4hDIu0V1RO4AdsA1Zvj6u
         acnQySmbqU41bgFGVJjmuyWmc6tEzSEiFl940=
Received: by 10.103.215.4 with SMTP id s4mr6347935muq.13.1215878662718;
        Sat, 12 Jul 2008 09:04:22 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.204.111])
        by mx.google.com with ESMTPS id s10sm4280083mue.16.2008.07.12.09.04.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jul 2008 09:04:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6CG3dm5022196;
	Sat, 12 Jul 2008 18:03:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6CG3H3Y022190;
	Sat, 12 Jul 2008 18:03:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1215877672-17049-2-git-send-email-s-beyer@gmx.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88254>

Stephan Beyer <s-beyer@gmx.net> writes:

> This patch changes every occurrence of "! git" -- with the meaning
> that a git call has to fail -- into "test_must_fail git".
> 
> This is useful to

>  - advertise the use of "test_must_fail" for new tests.

Hmmm... I think advertising the use of 'test_must_fail' would be
the best served by adding information about this function to
t/README

-- 
Jakub Narebski
Poland
ShadeHawk on #git

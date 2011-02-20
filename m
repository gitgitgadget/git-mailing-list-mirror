From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/72] t/test-lib.sh: add always-set NO_GETTEXT_POISON
 prerequisite
Date: Sun, 20 Feb 2011 16:36:00 -0600
Message-ID: <20110220223600.GB32455@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <1298143495-3681-4-git-send-email-avarab@gmail.com>
 <20110220021031.GB17305@elie>
 <AANLkTik9ieR=pWLQ9JEabNm2trSsyfFuYgfKMojnbzfb@mail.gmail.com>
 <20110220215533.GB32142@elie>
 <AANLkTikJbwp+-=sgX2RLo-aXA_gmmO2gLsC=+MxEYxXg@mail.gmail.com>
 <20110220221033.GD32142@elie>
 <AANLkTikRv9BGWXrf5u7xptgZ9hajeju-QU7WS9Zj3sYP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 23:36:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrHsx-0003kI-28
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 23:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab1BTWgG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 17:36:06 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54377 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab1BTWgE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 17:36:04 -0500
Received: by iwn8 with SMTP id 8so1304195iwn.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 14:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nbDzdEZiMOniz+miowrERfFViFrYS33QWeDPRX7bgmg=;
        b=apkTgJJMzgGmJDHIIQ6UUIMSfaY5bkLgRT/ijm3Us8XAxnCNMudnN+fNwnwa69yVGn
         s7CLJcwI7BMzLf5ZDliqD2L+Rx1DAqzftyyzZoTFP0+XelLip+F3f2aLN0ey2JuNvN+W
         G2AtRmeAB0NyI6ba1pRL8ZJyYBOhM97+QlmH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QrM5OcFBR056NXyZxtTa6APk5tahLAaYq9Ko4wu2cYyyMyB3apOlV6iAhV2v9/LMrC
         ubKLTY3qIJTF3QE00svPYjBgIbHaRogDnqnapN9zKn8xODXJF1Eexgl7eJGFe/wuRhCB
         qdiRvGmYXdDl1l4iD7KmxFS5umhTuuoPCgpn0=
Received: by 10.231.11.139 with SMTP id t11mr603752ibt.189.1298241364384;
        Sun, 20 Feb 2011 14:36:04 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id u9sm4491811ibe.2.2011.02.20.14.36.02
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 14:36:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikRv9BGWXrf5u7xptgZ9hajeju-QU7WS9Zj3sYP@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167434>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The only reason I can think of to have it is to make sure that
> messages like the "enter the commit message" ones have the correct
> newlines in all languages, but msgfmt --check catches that anyway, or
> to somehow test Git's output in different languages, but I'd rather d=
o
> that differently (not test output, but behavior).
>
> So given all of the above I might never get around to implementing it=
=2E

I guess I'm confused.  I've been saying (repeatedly, and probably
annoyingly) that anyone seeing the NO_GETTEXT_POISON prereq for the
first time isn't going to have any clue what it means.  I think that's
a problem.  Do you not think so?

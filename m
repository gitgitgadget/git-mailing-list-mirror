From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/6] Add memory pool library
Date: Mon, 7 Jun 2010 16:35:48 +0200
Message-ID: <AANLkTilorbTSy0Va7wX2BauiiVlAEUdzDi87DNF-SGNP@mail.gmail.com>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com> 
	<1275658871-1473-2-git-send-email-artagnon@gmail.com> <20100604182928.GB20909@progeny.tock> 
	<AANLkTimzuJXjX4OJUkmQtLwjGDgHBaZUHSGA0xUUi6kY@mail.gmail.com> 
	<AANLkTimd_l0uKHTqgS211fv30hxd-k0pR55YoY4xCua1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 07 16:36:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLdR2-0006d9-Bx
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 16:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab0FGOgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 10:36:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42414 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab0FGOgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 10:36:10 -0400
Received: by bwz11 with SMTP id 11so954872bwz.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=9tlpg6c8wV7WY1zHGsBTOCfDos+VCpN6MIowMXGK7Mg=;
        b=wJFqEv8AhivUSQo8ecgWqdtQLVkiG91HJybPa6sQUiGWe4Fohg5ByMksM4iXpavn0g
         n8sZqokM4WEGHUriTCj8FAZZHivrPU9M64NYUvkNuthr05pdHcCHM1alIIAdy65ecJ+D
         rVngHiHSjXralWEUUYZ7KzSz/qTafTDQlTZ8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=DfdCs2eNmaSQqc5pv9LoXc5BNfD/uEGUN9Nve2TGyVhr/8VSsdZY5tD5QNspDWEHff
         aFM4Dui3FiSCAniADsg7YSEymRD91BActw1TEmGZP7ZG/fHCPT7C2pcv5bTL4aZWvKiF
         v50p+IAf38umrMLxu+RK0rYMVzAapQZHbMT1w=
Received: by 10.204.8.144 with SMTP id h16mr6841834bkh.211.1275921368399; Mon, 
	07 Jun 2010 07:36:08 -0700 (PDT)
Received: by 10.204.76.11 with HTTP; Mon, 7 Jun 2010 07:35:48 -0700 (PDT)
In-Reply-To: <AANLkTimd_l0uKHTqgS211fv30hxd-k0pR55YoY4xCua1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148600>

Hi Erik,

Erik Faye-Lund wrote:
> On Mon, Jun 7, 2010 at 3:28 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Adding a win32-implementation of sysconf for this purpose isn't
> tricky, but perhaps it's a little bit overkill. Can't we just use some
> large power of two number? Hopefully, we could chose a size that is a
> multiple of the page-size on all systems...

Until an alternative is ready, I'll just use a large power of two and
roll out another revision.

> Anyway, this is roughly what a Windows-implementation of sysconf would
> look like (not tested - only checked that it compiles):

Thanks for implementing this. Unfortunately, I don't have a Windows
box to test this- why don't you send a patch to the list and sign it
off? While I agree that just implementing sysconf for _SC_PAGESIZE is
an overkill, others can test and extend the code.

-- Ram

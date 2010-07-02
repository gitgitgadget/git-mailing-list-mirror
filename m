From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-cvsserver: pserver-auth-script
Date: Fri, 2 Jul 2010 15:04:14 +0000
Message-ID: <AANLkTin_Pd2_uJciKDzW8wLhCSFtvOOzdlwJ8eFmWc7q@mail.gmail.com>
References: <20100702095406.7af15d20@ashinlaszlo.pta.neti.hu>
	<AANLkTinGZsCLF8CFKgQJaB63Jh9anGfQK4ZSHFPl4R4N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?TMOhc3psw7Mgw4FTSElO?= <laszlo.ashin@neti.hu>
X-From: git-owner@vger.kernel.org Fri Jul 02 17:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUhmy-0006Lg-OG
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 17:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758031Ab0GBPET convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 11:04:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63211 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703Ab0GBPES convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 11:04:18 -0400
Received: by iwn7 with SMTP id 7so3340621iwn.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zpEEIb6E1e55rvILmt1vR/W6tBa2k1IaYhQUucpjJXE=;
        b=Sb3Q15vJYf37yxrNQYYO4hHj6yyx/Mk/NYqbBEdi/oNYzeok7A3YbF/izwWvXqwCg4
         da/LN4aaCuI4YqdZw1I7YID2Feko8Akv9xnchYdOXd+ERN3W8HB5iyATWZiH0uPq5iOq
         r6q3N+We++KtKQwZR7TW+pF4YjP6AYlDUoVdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kA5hLV3QV8r+3U3raz7rKpnc3YmLCwXFCtGXC1qD5LtMRPoXw7AvN56YcvRbqAVoxP
         NggJk1m0E/K1WGDXoaZcFcFV0Q5Ynk8CqtY1zqGD4GByse5X/JS+x4u5GIi2r4KY0py7
         Db9/hDFVkjRb0ziLykWt1MMfW3HezgWcsVBBI=
Received: by 10.231.32.70 with SMTP id b6mr974644ibd.99.1278083054955; Fri, 02 
	Jul 2010 08:04:14 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 2 Jul 2010 08:04:14 -0700 (PDT)
In-Reply-To: <AANLkTinGZsCLF8CFKgQJaB63Jh9anGfQK4ZSHFPl4R4N@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150136>

On Fri, Jul 2, 2010 at 14:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> Otherwise this looks good. Submit something that's against the *.perl
> (and uses git format-patch / git send-email .. ) & has docs and I'll
> ack it.

Oh, and it also needs tests. See the existing authdb tests in
t9400-git-cvsserver-server.sh.

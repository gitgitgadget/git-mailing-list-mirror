From: Schittli Thomas <Thomas.Schittli@akros.ch>
Subject: AW: Git: Please allow to use gpgsm to support X.509 certificates
Date: Sat, 19 Apr 2014 18:24:39 +0000
Message-ID: <87FCFF58480C9949AF1110DED8AC48E4E9A0DFCF@BASMX001.akros.ch>
References: <87FCFF58480C9949AF1110DED8AC48E4E9A0D636@BASMX001.akros.ch>,<20140419151913.GA29656@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:25:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbZxZ-0002a4-Jp
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 20:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbaDSSZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 14:25:25 -0400
Received: from mail.akros.ch ([91.198.79.97]:52915 "EHLO mail.akros.li"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851AbaDSSZY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 14:25:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.akros.li (Postfix) with ESMTP id BB2722039B;
	Sat, 19 Apr 2014 20:25:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at basns01.akros.ch
Received: from mail.akros.li ([127.0.0.1])
	by localhost (basns01.akros.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ng9er8owM6Ng; Sat, 19 Apr 2014 20:25:20 +0200 (CEST)
Received: from BASMX001.akros.ch (exch.akros.ch [10.7.0.44])
	by mail.akros.li (Postfix) with ESMTP id 943D820379;
	Sat, 19 Apr 2014 20:25:20 +0200 (CEST)
Received: from BASMX001.akros.ch ([fe80::ac47:db94:ad74:89e]) by
 BASMX001.akros.ch ([::1]) with mapi id 14.03.0174.001; Sat, 19 Apr 2014
 20:24:40 +0200
Thread-Topic: Git: Please allow to use gpgsm to support X.509 certificates
Thread-Index: AQHPW71ZcUnsLXRrMEet3My08U++WpsY7G6AgABT6/g=
In-Reply-To: <20140419151913.GA29656@serenity.lan>
Accept-Language: de-CH, en-US
Content-Language: de-CH
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [46.126.169.144]
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246522>

Hi John,

> Have you tried `git config gpg.program gpgsm`?

wau, thanks a lot for this hint!, it works :-)

I think a "seamless" integration for all certificate-types would be better, 
but I try to motivate GnuPG to merge the function of gpgsm.exe into gpg.exe.
This would give a great benefit for all applications using GnuPG.

Thanks a lot,
kind regards,
Tom



________________________________________
Von: git-owner@vger.kernel.org [git-owner@vger.kernel.org]&quot; im Auftrag von &quot;John Keeping [john@keeping.me.uk]
Gesendet: Samstag, 19. April 2014 17:19
An: Schittli Thomas
Cc: git@vger.kernel.org
Betreff: Re: Git: Please allow to use gpgsm to support X.509 certificates

On Sat, Apr 19, 2014 at 11:03:07AM +0000, Schittli Thomas wrote:
> last night, brian m. Carlson explained, that "Git wants a key that can
> be used by GnuPG" and therefore X.509 certificates are not supported.
>
> As you probably know, since 3 years gpg supports X.509 -
> unfortunately, gpg does not automatically detect X.509 certificates
> and we have to use gpgsm instead of gpg.
> The good thing: for identical functions, the command line arguments are identical :-)
>
> Therefore: please allow to configure git, so that it can use gpg or gpgsm.
> Or even better: if gpg fails, then please automatically try gpgsm :-)

Have you tried `git config gpg.program gpgsm`?

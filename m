From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 09:24:58 -0800 (PST)
Message-ID: <m3k4x6na81.fsf@localhost.localdomain>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com>
	<4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com>
	<4B14D381.3010706@viscovery.net> <4B14DA1A.4060505@syntevo.com>
	<4B14E934.9090304@viscovery.net> <4B150747.2030900@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 18:25:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFWTJ-0000xB-Rl
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 18:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbZLARYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 12:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbZLARYy
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 12:24:54 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:52924 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089AbZLARYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 12:24:53 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so3659203bwz.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 09:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=gqIjKonyq5SgOVT10cQQu5Y5ikUpTFYYh5/d4vb3OEI=;
        b=SBBqm69jT+28dlDn66QnK0AUdT1VjIrdhYu5Rf2FPdYsgpac8RuPcp3X34kaZKDgfc
         +p35Xuz6Wqma7DERZZsmdQuDnIhS1kaYpIYfod5HgwVQhKmwjo1rSjf8Vb4KYpKNqAe4
         UbGFsWcqyMVpFi4qi5l9Rcxp0/yPrl+n/FQxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Gg98r70cfcjbynb/186m0T9ZmYCIHeC+4Hsiou4shCwISsZXv0m+9wfs+O7iF/cR7G
         maCZeOWyUVmMJYKaYe4Wfs0UbuE+vJPgOHhd1djQKdt/FqiFyoXy+nIMSpDySYF8lh1j
         r3e7vP6Zmw3mBLuxc+eO/Y9lnWmIGj6XeGIds=
Received: by 10.204.156.195 with SMTP id y3mr6425470bkw.46.1259688299203;
        Tue, 01 Dec 2009 09:24:59 -0800 (PST)
Received: from localhost.localdomain (abwm69.neoplus.adsl.tpnet.pl [83.8.236.69])
        by mx.google.com with ESMTPS id 13sm129271fxm.9.2009.12.01.09.24.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 09:24:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nB1CZWWJ022325;
	Tue, 1 Dec 2009 13:35:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nB1CZBua022321;
	Tue, 1 Dec 2009 13:35:11 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4B150747.2030900@syntevo.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134235>

Thomas Singer <thomas.singer@syntevo.com> writes:

> Johannes Sixt wrote:
>> Thomas Singer schrieb:
>>>
>>> Is it a German Windows limitation, that far-east characters are not
>>> supported on it (but work fine on a Japanese Windows), are there different
>>> (mysys)Git versions available or is this a configuration issue?
>> 
>> It is a matter of configuration.
>> 
>> Since 8 bits are not sufficient to support Japanese alphabet in addition
>> to the German alphabet, programs that are not Unicode aware -- such as git
>> -- have to make a decision which alphabet they support. The decision is
>> made by picking a "codepage".
>> 
>> On German Windows, you are in codepage 850 (in the console). The filenames
>>  (that actually are in Unicode) are converted to bytes according to
>> codepage 850 *before* git sees them. If your filenames contain Hiragana,
>> they are substituted by the "unknown character" marker because there is no
>> place for them in codepage 850.
[...]

>> Corollary: Stick to ASCII file names.
>> 
>> There have been suggestions to switch the console to codepage 65001
>> (UTF-8), but I have never heard of success reports. I'm not saying it does
>> not work, though.
> 
> Thanks for the detailed explanation. I know the differences between bytes
> and characters and the needed *encoding* to convert from one to another, but
> I did not know how Git handles it. I'm quite surprised, that -- as I
> understand you -- msys-Git (or Git at all?) is not able to handle all
> characters (aka unicode) at the same time. I expected it would be better
> than older tools, e.g. SVN.

The problem is not with Git, as Git is (currently) agnostic with
respect to filename encoding; for Git filenames are opaque NUL ('\0)
terminated binary data.  There is some infrastructure to convert
between filename encodings and other filename quirks (like
case-insensivity), though...

The problem is with MS Windows *console*, from which you invoke git
commands, and which does translation from filename encoding used by
the filesystem to encoding / codepage used by console.

> BTW, we are invoking the Git executable from Java. Is there automatically a
> console "around" Git? Should we invoke a shell-script (which sets the
> console's code page) instead of the Git executable directly?

If you use Git from Java, why don't you just use JGit (www.jgit.org),
which is Git implementation in Java?

-- 
Jakub Narebski
Poland

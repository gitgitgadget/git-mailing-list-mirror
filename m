From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH/RFC 08/11] daemon: use explicit file descriptor
Date: Tue, 8 Dec 2009 14:38:56 +0100
Message-ID: <40aa078e0912080538p16a99a8br647dbd42e18e1cde@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <40aa078e0911270746x55946f52qd76dc4f9443aebc6@mail.gmail.com>
	 <200911272123.45163.j6t@kdbg.org> <200911272128.48974.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 14:39:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI0HU-0006ln-73
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 14:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbZLHNiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 08:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923AbZLHNiv
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 08:38:51 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:64767 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892AbZLHNiv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 08:38:51 -0500
Received: by ewy1 with SMTP id 1so2734647ewy.28
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 05:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=f+7z2eR6g65R7V7dJKyggucIXK2PukSqukY7FVFDVKs=;
        b=jHxaHgAj21XHktYpK2d0IMorZjhKtHW1a0jqLN3wvzr0IOzCqdgoINQq5FlV72P8nb
         6jJ6TabgjocN1+25PZLx/yDmcxAz2CQzYIL+7LYpiujsr70sauarqjzixScZwCraWoT5
         fOQrJrHivKt+sDYvm1dm/2ljbU0WPEL9o6C2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=jYWbPvhg2WlVqIVqC32KjxP/hRAUuHezXIXJP+qcPEIcVgk6edwmg496lz9ix7zHTh
         YZHmhJgMtV39MHxPSNF3SiiAtR/gIFs5lJnA8Kbux4rhnXbBE+828nlZXs34z9uR2Q+p
         0duZ+i2D0qUHg0DyxEC5SPcUCUK2oLO2VvO6g=
Received: by 10.216.86.129 with SMTP id w1mr2918508wee.145.1260279536883; Tue, 
	08 Dec 2009 05:38:56 -0800 (PST)
In-Reply-To: <200911272128.48974.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134869>

On Fri, Nov 27, 2009 at 9:28 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 27. November 2009, Johannes Sixt wrote:
>> On Freitag, 27. November 2009, Erik Faye-Lund wrote:
>> > When I think more about it, I might've broken the inetd-mode as it
>> > should communicate over stdin and stdout (not just stdin as it would
>> > try to do now)... I don't know the inetd internals, but this frightens
>> > me a bit.
>>
>> Do we need inetd mode on Windows? At one time a looked for a inetd-like
>> service, but couldn't find one.
>
> How foolish of me. This affects all platforms. Of course it is an important to
> keep inetd mode.
>
> -- Hannes
>

I believe I've fixed this for the next round, but I haven't been able
to test the inetd-stuff, since I don't have a working
test-environment.

-- 
Erik "kusma" Faye-Lund

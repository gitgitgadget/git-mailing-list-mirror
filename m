From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSOC] Microproject "Move ~/.git-credential-cache to ~/.config/git"
Date: Tue, 15 Mar 2016 09:32:21 +0800
Message-ID: <CAKqreuw0hafi-GwWD-UaGKwmG8xVK6ZJDcw2jpQXAAuK+XBZvQ@mail.gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<xmqqshztawwd.fsf@gitster.mtv.corp.google.com>
	<CAKqreuwgxzVTAUdZPf9+ivXCdW8F2Ksafw7V0pbLAaRPwGX9Uw@mail.gmail.com>
	<xmqqwpp494vd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 02:32:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afdqa-0002ky-7D
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 02:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982AbcCOBc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 21:32:28 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36827 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbcCOBc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 21:32:27 -0400
Received: by mail-ob0-f178.google.com with SMTP id m7so2517623obh.3
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 18:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=fmQwqHivS7ecglNoV75gjltaEdLlrHJ7gpwGPCMWOb0=;
        b=db8dNBfovUAu8LpELfO0yvolT0YQkKRij9/lTLTWO2uklrhxIM9bV/tqqUOvJS2rOf
         52B8B2o/V/RZUQ7JjzU6dwRAqF8ZWHjOtwQhQQShJdoPbclj3CfGSmdB7OI+kadvtI1O
         L/cTIx+Bp5MdjaDv8XMluk5t69gVuOsFpt4pWy80XjPuGK2OmVyCX56geSGYlrqAj5i2
         yEjNxb4krb+DzunjUMNW4m5GT0WXcDEhm0vDorRNAbsxPj+3qM8s9h2h2m+z/To/8aqc
         oAD5HRvPFsL2taxWo0eNE8knRsdvtfzLiEBKJK38mlFmzE4NimLx6L5XVowz9fE914AB
         9OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fmQwqHivS7ecglNoV75gjltaEdLlrHJ7gpwGPCMWOb0=;
        b=DC9ldqJR7lYwgtLnzXrosN34nxFk8wktmAKWKsOU/D5Y1EcIzqwUFGhcXO8HVbHS8Q
         4SQVaB5GfxqXniB8a7GFHg5/qc4bwxZj5uL83IGoHh4hHoNSRexpeWJ9tg7giMvE2u9X
         cPNJsG0D6wSrA+p79ekYPhbzgR0AojQDIuS6Oy+/HvjvV8ptW5R5VEMpP3rKLJlyl8qp
         PBCl8JuKg3O81QOfanX6x+//JEauC8WGfqPK8tW+XnOj572Vizys8vatQ11jH9TApQQ3
         qnXODP2OKMfFLnIYQ8GlpmB2bfsHqz5hTsPgiOvDvqM9lZVB+tGKn7kNce4kRkWWJ9XH
         XpgQ==
X-Gm-Message-State: AD7BkJLOXZnIvwQtTHqGk4C3IcOzzM4gSLF/RLP2nv9/QdQI7dBQHfuAc2pDFBlsuennIKMsctTtnwghmA8mjA==
X-Received: by 10.60.96.74 with SMTP id dq10mr16868713oeb.78.1458005541082;
 Mon, 14 Mar 2016 18:32:21 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Mon, 14 Mar 2016 18:32:21 -0700 (PDT)
In-Reply-To: <xmqqwpp494vd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288826>

> You sound like you think it is better to check the location of the
> existing socket,

Yes, for the purpose of compatibility, it's the only choice, as I can see.

To sum up, I'd like to implement:

1. <path> is configured by --socket, then put it here.
2. else if `~/.git-credential-cache` exists, put the socket under here.
3. else, put the socket under
`$XDG_RUNTIME_DIR/git/credential-cache.sock`,
if $XDG_RUNTIME_DIR does not exist, default to
`/tmp/git-$UID/credential-cache.sock`.

As a result, new user will use xdg-compatible path while old user will not
be surprised.

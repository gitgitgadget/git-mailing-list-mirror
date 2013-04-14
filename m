From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Why does "git config" output nothing instead of the default value
 for unset variables?
Date: Sun, 14 Apr 2013 23:03:36 +1000
Message-ID: <CAH5451=GsvVLX+08agpWgggTdYsgpD8H-JHxGOgThC=D=GObhw@mail.gmail.com>
References: <kke7o1$oo$1@ger.gmane.org> <CAH5451nL0cmTy+vwEsJnvX7OP1iSSgY9UMhvrrimk0zWM71YDw@mail.gmail.com>
 <CAHGBnuO2d9Wkez4sLLKp3Ei0vkAJBjJp1+m+Lsu3ozaKPQD29A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 15:04:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMbB-0005TC-QS
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 15:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab3DNND6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 09:03:58 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:34179 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab3DNND5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 09:03:57 -0400
Received: by mail-ve0-f175.google.com with SMTP id jy13so507097veb.34
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=M8IKxh4fNWF4IezCDoXyuh1/LjGpyCcX+V7yKjdd6qo=;
        b=fho39kaB7DDDPfCseG+0WDE9A+yQPPTd5ulvfFqs05U5ON/tbkOlFOymny5m+DuBIi
         L/GjdU4Xo1NgC/XySRz5OQeG/0P/v10a2p39RtZ4t8GSvLyEE1twbaBX968jX6osYLui
         Ef0D7e3rGGwGOweXKamy0rS8QliiRIQccmClxkAZcJv5d/4AO7wTiT39XX1GD2vJNb79
         XUHT0PXVuSVQtWiFMaD07tswyOX35BC10ocKftppKI4d2y0FyAjN+/s9stJ6fgB9XW8h
         9mSnRvp1LmpRgLo0bGIcVmQH1JuHcr/QvhiEIK1IacrYL2saRY0Xy/xQQacIdB6VTatv
         bc9g==
X-Received: by 10.52.19.200 with SMTP id h8mr7870780vde.60.1365944636472; Sun,
 14 Apr 2013 06:03:56 -0700 (PDT)
Received: by 10.220.107.82 with HTTP; Sun, 14 Apr 2013 06:03:36 -0700 (PDT)
In-Reply-To: <CAHGBnuO2d9Wkez4sLLKp3Ei0vkAJBjJp1+m+Lsu3ozaKPQD29A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221135>

On 14 April 2013 22:56, Sebastian Schuberth <sschuberth@gmail.com> wrote:
>> The closest thing I can see for doing this is git config --list, but
>> perhaps there should be a flag to check if a config item is set?
>
> Yet more command line options? Well, there's probably no way around
> that in order to maintain backward compatibility.

'--list' already exists; it shows all defined options. With your
change in place (and no others) then the only (documented) way to know
if something was configured would be by looking at git config --list.

Changing the default behaviour is probably too big a breaking change,
but a flag to change the behaviour might be nice. Then again, there
may be away to do what you want already :-)

Regards,

Andrew Ardill

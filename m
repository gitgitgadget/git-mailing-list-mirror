From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Fri, 5 Aug 2011 19:39:50 +0200
Message-ID: <CABPQNSYQ9D7NO5cx_o3csAe4bQ40kOd1f5gATUXDb7r4n3GhdA@mail.gmail.com>
References: <1312560614-20772-1-git-send-email-pascal@obry.net>
 <1312560614-20772-3-git-send-email-pascal@obry.net> <CABPQNSYSzsY-CQdi6iJQftsY1ufMpxkax=eQLgopVxMC6LoxfA@mail.gmail.com>
 <4E3C29D9.5060305@obry.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Fri Aug 05 19:40:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpONw-0002Ma-IQ
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 19:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395Ab1HERkc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Aug 2011 13:40:32 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60445 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab1HERkb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2011 13:40:31 -0400
Received: by ywn13 with SMTP id 13so1820452ywn.19
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 10:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=atux+WiKfCekx8fMU5AdPapkKSVDaWGM7ISmuelGh8w=;
        b=ur/QPVkTNWWWSC+rdYQfrGFtWvRPoHGSe9Db7Y+GyUAl6yOeaNbvIY8P6RagKHhZgm
         UDcX7tSA6cjMbQ0YzSmF3somvL3xPbfGTSOp0R5eqXj157hM3VCCw6RY/CUO6J9EFATt
         VWwI6X7dIpFcpBgbd/iYUjKIKFZCs569vYdzg=
Received: by 10.143.76.8 with SMTP id d8mr2277844wfl.400.1312566030104; Fri,
 05 Aug 2011 10:40:30 -0700 (PDT)
Received: by 10.68.56.65 with HTTP; Fri, 5 Aug 2011 10:39:50 -0700 (PDT)
In-Reply-To: <4E3C29D9.5060305@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178808>

On Fri, Aug 5, 2011 at 7:35 PM, Pascal Obry <pascal@obry.net> wrote:
> Le 05/08/2011 19:29, Erik Faye-Lund a =E9crit :
>>
>> Cygwin is a unix-layer on top of Windows, designed to play by the
>> POSIX-rules. So why would you want to support Windows-style paths on
>> Cygwin?
>
> Because cygwin toolset does support \.
>

Are you saying that the built-in Cygwin tools (like ls etc) support
Windows-style paths (C:\path\to\file)? If that is the case, I
completely understand the desire to accept Windows-paths.

>> If you want a Git that handles Windows paths, use Git for Windows...
>
> Note that Windows is a special case as even the Win32 API does suppor=
t \ and
> /, so every tool on Windows seems to handle nicely this. Why not Git,=
 be it
> Cygwin/Git. If it does not break anything else.

If the Cygwin-tools does not support drive-prefixes (i.e "C:\") but
does support both slashes as path-separators, then I agree with the
patch but not with the commit message.

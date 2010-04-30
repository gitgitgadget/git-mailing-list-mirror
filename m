From: Tim Visher <tim.visher@gmail.com>
Subject: Re: git daemon on Windows environment
Date: Fri, 30 Apr 2010 17:34:36 -0400
Message-ID: <t2jc115fd3c1004301434ofe8970fo2ea933dd450847d7@mail.gmail.com>
References: <1272532026043-4979038.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: santos2010 <santos.claudia2009@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 23:35:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7xra-00055B-2w
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 23:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757753Ab0D3Ve7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 17:34:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42156 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab0D3Ve5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Apr 2010 17:34:57 -0400
Received: by gyg13 with SMTP id 13so334382gyg.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OE2pHSOdibBEsMEJ5WCBfiKAaREaw07aWOMWekAeg/E=;
        b=c7DZbEZiPJEVhVo1NSqVVCl8Z5rjTaCLFphpZFCWnAAKXMAnFyemfkKBwNjukYrMdd
         9gPjELndXWR6/XoTTkhoObIKU3P+KH7b+mgVQnNkvYHExI7yeySoEozZXtDQoHD0VpWm
         0xoaUZk37GVFMV09ZEkUkKgrI+YtpgNGpaMLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OVaEt64wn7NZ3RiwLziRajQiXowNI+I79O11jVcziyrCAJNUAGLUbti+bNIul5nMr9
         ycIzxsWfa0J1fJAE4UPAxMmPuc3FmBhcoWSkAXwPifqElLPX4RzvUO06TmsTssGfwiKP
         41Qa9wgqM5S411PcDA4FQaekGA+uFX3TIvtyc=
Received: by 10.151.20.11 with SMTP id x11mr3064137ybi.216.1272663296196; Fri, 
	30 Apr 2010 14:34:56 -0700 (PDT)
Received: by 10.100.164.19 with HTTP; Fri, 30 Apr 2010 14:34:36 -0700 (PDT)
In-Reply-To: <1272532026043-4979038.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146064>

On Thu, Apr 29, 2010 at 5:07 AM, santos2010
<santos.claudia2009@googlemail.com> wrote:
>
> Hello,
>
> I tried to install git daemon on a Windows Server 2003 using cygrunsr=
v, but
> got this error:
> cygrunsrv: Error starting a service: QueryServiceStatus: =C2=A0Win32 =
error 1062:
>
> I googled and found a possible fix:
>
> =C2=A0" explicitly add Full Control for the SYSTEM user to
>
> =C2=A0C:\Cygwin
> =C2=A0C:\Cygwin\var
> =C2=A0C:\Cygwin\var\log "
>
> However this didn't help as well.
> Anyone has experience with this installation? Any tips?
>
> Thanks ina advance,

As far as I know, git --daemon is explicitly not supported in Windows
environments.  At least that was the case not too long ago.

If you're running git --daemon because of its efficiency, have you
considered the fact that [smart-http][] is almost as efficient?  That
should work in any http server, a plethora of which exist for Windoze.

Also, file system cloning is very efficient so if you're trying to
share a repository you could in theory share over the file system
using filesystem permissions to allow for cloning.

Just food for thought.

[smart-http]: http://progit.org/2010/03/04/smart-http.html

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail

From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH 02/15] Add define guards to compat/win32.h
Date: Wed, 16 Sep 2009 11:42:10 +0200
Message-ID: <40aa078e0909160242s4110ca8fj1e44e1e228676704@mail.gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
	 <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>
	 <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org,
	lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 11:42:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnr1o-000712-US
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 11:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbZIPJmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2009 05:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbZIPJmI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 05:42:08 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:59925 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbZIPJmH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 05:42:07 -0400
Received: by fxm17 with SMTP id 17so2142313fxm.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JT4/qsDX40+rW3a27ydA0tqLgJ9xNerAt4qOX66jGTQ=;
        b=CVti8l+5x3hdxpFzFzcEodcsN44C0KyLXC1q1Z1nr35qcdjQcsabyiGvpv53RuQLnj
         1L9blMbQszVlcOjCgbjZ9wgUnbuRBK22UhDmeX0yk5QKZ1NbxXg3asu1LOX0M8lP8WJp
         IaVunJB1cbKw3LqjkB+t5KYUzgCPQdlzMnFoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lz9mnPPblrC7XhNstD0b+x4hkP8hQteqE+wetzTQ7Vp4d7mm6lEyYHgPJDT6cHMQsy
         VNthWbUGIFIaquNGGKQ4KZdoxw3AK10j+XNSxs7pXeXRQC7znaCjzHKXCmbvNAG+YQT3
         1Q1Iojfu+q+PtHA15pJtpzMIE/bPdz8PB9OKc=
Received: by 10.204.152.151 with SMTP id g23mr6759726bkw.148.1253094130187; 
	Wed, 16 Sep 2009 02:42:10 -0700 (PDT)
In-Reply-To: <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128633>

On Wed, Sep 16, 2009 at 10:20 AM, Marius Storm-Olsen <mstormo@gmail.com=
> wrote:
> --- a/compat/win32.h
> +++ b/compat/win32.h
> @@ -1,3 +1,6 @@
> +#ifndef WIN32_H
> +#define WIN32_H
> +
> =A0/* common Win32 functions for MinGW and Cygwin */
> =A0#include <windows.h>
>
> @@ -32,3 +35,5 @@ static inline int get_file_attr(const char *fname, =
WIN32_FILE_ATTRIBUTE_DATA *fd
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ENOENT;
> =A0 =A0 =A0 =A0}
> =A0}
> +
> +#endif

Aren't these usually called "include guards" instead of "define guards"=
?

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656

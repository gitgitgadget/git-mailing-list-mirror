From: Andrew Romanenco <andrew@romanenco.com>
Subject: Re: problem with file mode
Date: Mon, 8 Jun 2009 17:08:33 +0300
Message-ID: <18e14dc30906080708x77933794r1260c3bd6954700e@mail.gmail.com>
References: <18e14dc30906080209m9eceb6ft81c77ea0345b30e3@mail.gmail.com>
	 <20090608123006.GF13775@coredump.intra.peff.net>
	 <18e14dc30906080649y2efa7facv1109fcd797614d27@mail.gmail.com>
	 <20090608135709.GC28101@sigill.intra.peff.net>
Reply-To: andrew@romanenco.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 16:08:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDfWq-0002sJ-1R
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 16:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbZFHOIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 10:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbZFHOIi
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 10:08:38 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:49278 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbZFHOIh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 10:08:37 -0400
Received: by ewy6 with SMTP id 6so4205663ewy.37
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 07:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:reply-to:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=DrGxLuoAAxZmNe68jf4S12xf2w4dVB8YNvpKJqmIW4Y=;
        b=xjJQK5MfiwICPW2UbsehmIGtSQEbtzfHsq7FofQYxX9cMk3ZxmcNOOU6M6sjjLDcuK
         0XFZZEHfi9Vpy9iZRm9I1hRFnBymDEDwwn58K8ZWWTc8iWfiqU42nMF6W5pC33RDwyP+
         grbiZ1YnsfADDIfdsA5quCbL54wy2ma53DSrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:reply-to:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=r0cve8cUxd+dzkbzi/PYuFwp8LnSvzBu3I/ZzG+Nfu415ibVyadaAMgKqWHioK70nl
         A5G8b67VZIs/O2GqelTS5ctQBuQUHJ1FzxIq24Mfo/nC9uYuqCPYKyc4Nx8DMj8U1+LE
         PnCs1XrpJrnGt03tVAPhCzrTvrCaC144+jlGg=
Received: by 10.216.47.204 with SMTP id t54mr2400669web.75.1244470114592; Mon, 
	08 Jun 2009 07:08:34 -0700 (PDT)
In-Reply-To: <20090608135709.GC28101@sigill.intra.peff.net>
X-Google-Sender-Auth: d41f4dd96c924301
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121076>

I have create repo on ext3 and cloned it to fat

thak you for your help

On Mon, Jun 8, 2009 at 4:57 PM, Jeff King<peff@peff.net> wrote:
> On Mon, Jun 08, 2009 at 04:49:44PM +0300, Andrew Romanenco wrote:
>
>> true - B is Fat
>
> Then you probably want to:
>
> =A0git config core.filemode false
>
> on B. Though I thought we automagically tested whether the filesystem
> supported executable bits when creating the repository. Did you creat=
e
> the repository on a different filesystem and then move it to FAT, or =
did
> you directly clone to FAT?
>
> -Peff
>



--=20
Best regards,
Andrew Romanenco

        Software developer
        Microsoft Certified Professional (win2k)
        Microsoft Certified Database Administrator
        Sun Certified Java Programmer
        Sun Certified Web Component Developer
        Oracle Database 10g Administrator Certified Associate

        mailto:andrew@romanenco.com
        http://www.romanenco.com

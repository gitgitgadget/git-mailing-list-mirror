From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 0/4] clone: use --progress to mean -v
Date: Sun, 27 Dec 2009 11:27:05 +0800
Message-ID: <be6fef0d0912261927p4aff3ecet5cc26bd6dfc7e1c2@mail.gmail.com>
References: <18831.46833.862.196815@hungover.brentg.com>
	 <1261761126-5784-1-git-send-email-rctay89@gmail.com>
	 <alpine.DEB.1.00.0912260952020.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 27 04:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOjml-0003eM-32
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 04:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbZL0D1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2009 22:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbZL0D1J
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 22:27:09 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:61235 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbZL0D1F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Dec 2009 22:27:05 -0500
Received: by iwn1 with SMTP id 1so6749850iwn.33
        for <git@vger.kernel.org>; Sat, 26 Dec 2009 19:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ARr2nNeunVJ1JAjdhQzq4RbVBsewPdmP5A234QTmwPo=;
        b=HeVGd1HLrRpRpzfEQJVFXleq3XkYq2617Fb91MyuRrydAWO8gTxwXLQ4u7ofGgRPYF
         AvVMaf5PXtntfl5nE45PbrmSPnVdfFDAzG0Zvf/jfhdNjtMWfkHXnaoUlBfgrJtOx1h5
         1gsegVQAcE/z0rAYEerASoiy0qHa1XIvIDpbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jDXwxH9feh/8dwxi+FXVi6F30Z6bklv/IGDUa6rk0I/OlKKN8C5tPzgK6rOY2Ij2lV
         4V+ckUizKhfC/B/JZOieEZqt9gKgtDoPuTWhOcWwNcebInxhPpAEV8giTkhA9jbTiHDX
         NQO4k3kbSaCpUCgF0E8FYWXEFSYkkScfVbw2I=
Received: by 10.231.147.210 with SMTP id m18mr2267544ibv.48.1261884425031; 
	Sat, 26 Dec 2009 19:27:05 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0912260952020.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135700>

Hi,

On Sat, Dec 26, 2009 at 4:53 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sat, 26 Dec 2009, Tay Ray Chuan wrote:
>
>> This series makes git-clone follow the "argument convention" of
>> git-pack-objects, where the option --progress is used to force repor=
ting
>> of reporting. This was previously done with -v/--verbose.
>
> No objections from my side, although you might want to advertise more=
 that
> this is a change in behavior. =A0(Meaning in the release notes)

Indeed, -v/--verbose to force reporting of progress was done sometime
last year (Thu Oct 9 2008) so there may be scripts/applications
dependent on this option.

Junio, do you have any advice on this front?

>> PS. If someone can enlighten me on the proper noun for the git
>> =A0 =A0 executable (I said "main git"), I would be very thankful.
>
> I call it the "Git wrapper", although less polite words exist, too.

I see. Thanks!

--=20
Cheers,
Ray Chuan

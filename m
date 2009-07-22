From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-svn wowes
Date: Wed, 22 Jul 2009 18:24:07 +0000
Message-ID: <fabb9a1e0907221124u345bc572mfcead0468306b6e5@mail.gmail.com>
References: <025FAAA7CA644D709E1635C497753444@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:24:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTgUV-0006Hr-NH
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 20:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbZGVSY2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 14:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbZGVSY2
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 14:24:28 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:57270 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbZGVSY1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 14:24:27 -0400
Received: by ewy26 with SMTP id 26so434575ewy.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BWJsVPM4pBR64ampMiVo6S1p7xILMKzc6Q7H9u/EXpI=;
        b=KYUlVooFiW+zRJkrDklqZIs640ccqjdiDMoI/FhuYeiU0eu8FI3EfFaWLJ8or8LR8L
         C5Gi8zZDxomWWtp8aLe1Mqo/G0FMk42SVcQpycblcddzcQdYQvXOouq+KUdrqUS+2Qvy
         E13xTM02V/hiAc32TpXM9Cf0HaQ9X5/QVE+EA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lSkg9Sxlc5Il0TUmTee2vvaYPheXKTx84lDUXYs877dJ7Pzli6zrJdKLst/HYkIOnT
         tvQJsHjbQVPVdGHfb1967pIp/ALFaioTU9/YzQ/oDp0PHTn2/55Oq6KMcQmmWEzYPxCR
         4CSwcij1ja3LdYEo+8imsZKHaY2t3EF7IKhIw=
Received: by 10.216.18.195 with SMTP id l45mr347762wel.59.1248287067093; Wed, 
	22 Jul 2009 11:24:27 -0700 (PDT)
In-Reply-To: <025FAAA7CA644D709E1635C497753444@HPLAPTOP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123766>

Heya,

On Wed, Jul 22, 2009 at 13:55, Aaron
Gray<aaronngray.lists@googlemail.com> wrote:
> =A0 git svn rebase

Should be enough ('git svn rebase' runs 'git svn fetch' first),
assuming you don't touch the working directory, which you probably
don't considering that your script blasts away all changes every hour.

--=20
Cheers,

Sverre Rabbelier

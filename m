From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git via http problem
Date: Mon, 25 Oct 2010 20:39:44 +0800
Message-ID: <AANLkTi=J=geegYAXnHmNONw8UeocePTw2EMw4frMbQZA@mail.gmail.com>
References: <loom.20101025T123323-510@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Aleksey Egorov <alekseyandni@mail.ru>
X-From: git-owner@vger.kernel.org Mon Oct 25 14:39:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAML9-0007eE-O6
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 14:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab0JYMjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Oct 2010 08:39:46 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55998 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab0JYMjq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Oct 2010 08:39:46 -0400
Received: by ewy7 with SMTP id 7so4139887ewy.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EwBR67G1a+h2ucIJCOdnkjkwgfSzMcqDS6Gtzy7sNS4=;
        b=B6eemdXJ9uyeSVzWpYuD5cjxSlMTN8ebGP3hCE6XgMGf8NcKEg6jERzQGrN1sSeR0t
         jiOgsd1RdVCAs1HVMMo9dUEMwPh24a0PLNJ4c+NUDHYNdA5JHH9rM33TQMF1PaCWeU6y
         D6axdaa1xbDsBWGNXzYcC+L+b4GBXXhfDrPGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RHPrucxz4GcjCZv7mDLkkmP/li6toOw+IcAaikZ7qaJnb14AV3MvZHIu2D/hkC8UEO
         iZE4y7lIFJ5XtTryuI0IbpuVKY/W58LPTT+TYdHOe8yuqyJnbk2r3wlXByMRqyyex8iV
         P2ej0GqLZaVoIrQFJhLw035a9nTzRvoenCcWc=
Received: by 10.213.15.140 with SMTP id k12mr5591415eba.63.1288010384639; Mon,
 25 Oct 2010 05:39:44 -0700 (PDT)
Received: by 10.213.3.78 with HTTP; Mon, 25 Oct 2010 05:39:44 -0700 (PDT)
In-Reply-To: <loom.20101025T123323-510@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159946>

Hi,

On Mon, Oct 25, 2010 at 6:34 PM, Aleksey Egorov <alekseyandni@mail.ru> =
wrote:
> If I change apache conf to
> =A0 =A0 =A0Alias /linter.git /var/www/linter.git
> <Location /linter.git>
> DAV On
> AuthType Basic
> Authname "localhost"
> </Location>

I noticed that you left out AuthUserFile here.

Could it be that you didn't load mod_authn_file? (wild guess)

Also, what version of git are you running? I'm guessing it's an
authentication problem.



--=20
Cheers,
Ray Chuan

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: pulling git -- version confusion
Date: Mon, 9 Nov 2009 07:37:15 +0100
Message-ID: <fabb9a1e0911082237x462b1203v724b51e309a2d89@mail.gmail.com>
References: <f46c52560911082214x81ae8beya139a8bcb3cbcf2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 07:37:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Nsm-0001sE-DN
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 07:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbZKIGhb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 01:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbZKIGhb
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 01:37:31 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:39390 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbZKIGha convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 01:37:30 -0500
Received: by ewy3 with SMTP id 3so2828062ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 22:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QpRR+XqRp1IrTaDHNakBlc2CB1EXsSlv6pX+WGe4ajE=;
        b=Y3OP311RIiJ3iA/ECHMwDW7hFNe239ubp8v2mXpRWzGEc9vBwfDf/faTh8pL1B9Ggp
         7pSOSbPlheKAeId2NaTNceNUntUgQ5GHIN6I3NddIpa85W+8glJnMXQfGF0YN0ibZ1lZ
         yNaT556VLG/InqXdoK1P7gesdTuLaPkLEWaHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Y6x2luolNEqm9B225nOEsP5Vix3GGz/YmL0jQ2d/IgdHL3VrDEBkWekrXlZ5aqvdHv
         m9MLXun8D7C6d900Q7enTHhDqpFkZpQ25bPsGHuSOfQWqRxzlhjQIGFdggKrnZWAXUMq
         K/3JAEhtYCS0WeBzbJ7JEPJXdg7ZDc5HqJKcE=
Received: by 10.216.89.80 with SMTP id b58mr2356993wef.73.1257748655128; Sun, 
	08 Nov 2009 22:37:35 -0800 (PST)
In-Reply-To: <f46c52560911082214x81ae8beya139a8bcb3cbcf2a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132442>

Heya,

On Mon, Nov 9, 2009 at 07:14, Rustom Mody <rustompmody@gmail.com> wrote=
:
> When I checkout branch next
> git version becomes =A01.6.0.rc1.194.g9e4e

Try either:
$ git checkout master
$ git reset --hard origin/master

or:
$ git checkout next
$ git reset --hard origin/next

=46ollowed by:
$ make
$ ./git --version

--=20
Cheers,

Sverre Rabbelier

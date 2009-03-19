From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/3] document --force-rebase
Date: Thu, 19 Mar 2009 12:01:43 +0100
Message-ID: <fabb9a1e0903190401k1127dc8ev7704c8a7bd381c99@mail.gmail.com>
References: <1237399558-27289-1-git-send-email-barra_cuda@katamail.com>
	 <1237399558-27289-2-git-send-email-barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 12:03:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkG2R-0003YF-Hw
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 12:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbZCSLBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 07:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754664AbZCSLBr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 07:01:47 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54274 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbZCSLBq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 07:01:46 -0400
Received: by fxm2 with SMTP id 2so442093fxm.37
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+jNn1VRlHU7H1aBjDwUerA/wBgdkgikLrxoGKGUcxkM=;
        b=Nz7nl2PEWbFVrGVs1L7j+QetrDEQRXUJIT47o3lm2ORwGwfg/FGZVoXLxl6UkKzFcg
         e9FWe04TQmUZp3zR4jPQWVikiYy9o6aNgJ7SWomh++1oNWTwbe+c1HhVtvruQUB7daFL
         /DvBe+A81JPU5Z3LZujyaXPqSyQm6Kzsa22eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aXmNyZFs4adbA1TO/d1uITzvGVcWKbQEFGqmeMVXtXPyWmUretCTzycGAmY9+yQPJB
         IA6QzFiRyd1xRYN9RZsaliCn2YEE3Q95Pud0nnXRzB6HIYxnIc/0NSWQcHaMwsB5i2hf
         gpEv3T3bQlqspQ65bn9rHFa8QsW4Npza/75qE=
Received: by 10.102.247.4 with SMTP id u4mr1030515muh.104.1237460503326; Thu, 
	19 Mar 2009 04:01:43 -0700 (PDT)
In-Reply-To: <1237399558-27289-2-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113757>

Heya,

On Wed, Mar 18, 2009 at 19:05, Michele Ballabio <barra_cuda@katamail.co=
m> wrote:
> Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
> ---
> =A0Documentation/git-rebase.txt | =A0 =A06 ++++++
> =A01 files changed, 6 insertions(+), 0 deletions(-)

Awesome, thanks! Perhaps you could, for extra brownie points, add a
line to the --whitespace=3Dfix documentation that it implies
--force-rebase?

--=20
Cheers,

Sverre Rabbelier

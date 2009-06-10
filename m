From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Mercurial on BigTable
Date: Wed, 10 Jun 2009 21:23:49 +0200
Message-ID: <fabb9a1e0906101223o31f4adf3o863ff380be4b1465@mail.gmail.com>
References: <d411cc4a0906101215t313b2037k713aa1ce974c30cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 21:24:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1METPH-0006O5-OX
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 21:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974AbZFJTYK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 15:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756942AbZFJTYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 15:24:09 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:34104 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861AbZFJTYI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 15:24:08 -0400
Received: by fxm9 with SMTP id 9so1040655fxm.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=V7Qt7lkrfBZFQlFtSsyyCB3iXc8eehatV11PmGr6CoQ=;
        b=if++QwRGDIads65fLYHx9l1NNrEEToYAsXb2yrA2AwS0HlOhESAdW41/qKVwCh/BOV
         mnOu8T4lBLkaaX5JLTIlTfJjEmrrMD7NWrGwzaovB75S9KMSK3S53EALI7DEPvHUBN8J
         Ia1WQYjLE5gVtMujYsGydiymQ+DpyRXsgZatw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LCjA4Mz8/jZ6kqmnRxo0uWD/QpNoiYNAONFBgouQgaSn6Ti8s5CPQak9qEqPxbi75O
         kWvXzv19wgUPEmtU1dyGuhD+4+xqM8ObmtaIo7he8VL8RNG9v+JM5LxJZ3hWGP7HuixO
         wIPu/AUdLXUQ8udP/X79HAVZv4shhiz21iqBY=
Received: by 10.216.28.207 with SMTP id g57mr630025wea.163.1244661849198; Wed, 
	10 Jun 2009 12:24:09 -0700 (PDT)
In-Reply-To: <d411cc4a0906101215t313b2037k713aa1ce974c30cc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121297>

Heya,

On Wed, Jun 10, 2009 at 21:15, Scott Chacon<schacon@gmail.com> wrote:
> in the repo MINA based server)? =A0It looks like the data structure a=
nd
> protocol exchange are incredibly similar after they threw away all th=
e
> revlog stuff. =A0Or is it just that they're fine with the speed loss =
and
> the Android project would not be?

There's one explanation for that, git's lack of a decent HTTP
protocol, no? The speed loss of http:// vs git:// is still huge :(.

--=20
Cheers,

Sverre Rabbelier

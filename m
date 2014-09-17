From: Pramod Gurav <pramod.gurav.etc@gmail.com>
Subject: Re: Query: Failed to suppress CC while sending patchset
Date: Wed, 17 Sep 2014 16:59:35 +0530
Message-ID: <CAMf-jSnx_NphQ5XR5eY6B9cFLbWPhh1vJtFw5=2jXt7-30VW=A@mail.gmail.com>
References: <CAMf-jSkjYFEsN01DZc=Xc6qb037zeVeo4cUKDJJN-Q0Z4f6B9Q@mail.gmail.com>
	<vpqd2au20md.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 17 13:29:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUDQb-00072U-U8
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 13:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbaIQL3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 07:29:38 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:51420 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbaIQL3h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 07:29:37 -0400
Received: by mail-la0-f43.google.com with SMTP id gi9so1645505lab.30
        for <git@vger.kernel.org>; Wed, 17 Sep 2014 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gQipIW68LHaU99wq5NH/MSh/RMlf6nhvkMQizg3v6Bk=;
        b=t67XhjNBw1Ud0jqbhT5YakMYU4mTpCNKfHznq/bRiOTMjtQsTs4BGQwVUcIiDJ6pC3
         tEgmiPhVGtp7/IZTIO6RQdLYdKLVpcgNiiCYQlmByfZQ56MpZNBLUKvA3nSsgWcmpRiJ
         GC8NTW1NSiJ6RgXJyGLx7NG2otv1GZzDYZa/PhkDezBM3YJkmdmD5QdD9Hy1HhnaZF7E
         GiJGo4SWTaiaWs0xs/Qf8wSLRULc5+LzclYuCY3ol+MV9Q6o4qV3MXdJc7O0zS2GHBFj
         MJwLBTIjLyvZ8iL+K+05pvxTTpJZMs8FWT7pJJHx98ff0ohG9y0jwIATpSk3FpjTaUhe
         GihA==
X-Received: by 10.112.17.2 with SMTP id k2mr41015442lbd.28.1410953375948; Wed,
 17 Sep 2014 04:29:35 -0700 (PDT)
Received: by 10.152.3.73 with HTTP; Wed, 17 Sep 2014 04:29:35 -0700 (PDT)
In-Reply-To: <vpqd2au20md.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257219>

Thanks Matthieu for suggestion.

On Wed, Sep 17, 2014 at 12:29 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Pramod Gurav <pramod.gurav.etc@gmail.com> writes:
>
>> gpramod:linux-next$ git send-email --to=pramod.gurav.etc@gmail.com
>> --suppress-cc=cc --suppress-cc=self --suppress-cc=author 000*
>
> I guess you lacked the --suppress-cc=bodycc.

how does it differ from --suppress-cc=cc? from help I understand cc
avoids people in Cc lines in the patch header and bodycc avoids people
in Cc lines in the patch body?

Patch body is commit message, right? What is patch header?

>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/



-- 
Thanks and Regards
Pramod

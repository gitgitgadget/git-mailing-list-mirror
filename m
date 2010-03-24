From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: GIT_ONE_FILESYSTEM inclusion?
Date: Wed, 24 Mar 2010 21:36:14 +0100
Message-ID: <81b0412b1003241336n71b4f5ael7ecbb72236a245db@mail.gmail.com>
References: <20100323232055.GV7038@pixar.com>
	 <81b0412b1003240229l6f7eaa18l563c3d7ba0cf6cc5@mail.gmail.com>
	 <4BA9DCDD.6060109@viscovery.net>
	 <81b0412b1003240437n799bac07sb74db749d647817d@mail.gmail.com>
	 <20100324134048.GB10190@pixar.com>
	 <81b0412b1003240659u4e6de405t7750b66ca9292cdc@mail.gmail.com>
	 <7vpr2tu1bd.fsf@alter.siamese.dyndns.org>
	 <81b0412b1003241207s4951b32cpbe105e7b3623f61a@mail.gmail.com>
	 <7vwrx1fpv9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Damerow <lars@pixar.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 21:36:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuXJP-00086Y-Tk
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805Ab0CXUgR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 16:36:17 -0400
Received: from mail-bw0-f211.google.com ([209.85.218.211]:58081 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab0CXUgQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 16:36:16 -0400
Received: by bwz3 with SMTP id 3so6820215bwz.29
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sl4v/l/p9Bgn+p625bU9td3wHUHOHG/HQckHr6x/wMU=;
        b=EXpxfVtF6dtx5UwPzrGIMzZNMy3Sp+c8pZD9M4Pmv3pTulyhB4NLjfF8OOZMb9fyNh
         EJL9DxA9uFW658qv9fv07/rxlRO5YNYSrBN+dQjXUBJVQMswl8NzJPxlYBH5T44ecw8Q
         dQB7pnr4pXoNXcC9E/puQ3VkijN1qTlFYpjEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qWnNtOqSrHlkfN1uL59txo+m+SDVwFgji7onrB/JCGGdN8EwqUSt8Yk52LekwgjDmm
         +mpIdS/1dO8EGDuImcjwK9L8KtfBa32tf1+QisXpL5eJddlPrlz1aArXATOrP9g6E4l2
         k6fEf2/lbacA+xmjT/cdQkDpdfmyeH75PzPJs=
Received: by 10.204.174.194 with SMTP id u2mr7509652bkz.40.1269462974427; Wed, 
	24 Mar 2010 13:36:14 -0700 (PDT)
In-Reply-To: <7vwrx1fpv9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143123>

On Wed, Mar 24, 2010 at 21:04, Junio C Hamano <gitster@pobox.com> wrote=
:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>>> When would you invoke this feature as "one-off"?
>>
>> Maybe when I want to make sure git status does not go all over an
>> NFS mounted submodule.
>
> But then what would you do after finding it out that it might? =C2=A0=
You stop

Postpone whatever you were about to do, maybe.

> working on that project? =C2=A0Doesn't --ignore-submodules do the sam=
e thing?

It does. I said it is obscure.

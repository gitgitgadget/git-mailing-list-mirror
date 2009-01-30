From: Pascal Obry <pascal@obry.net>
Subject: Re: Finding the name of the parent branch?
Date: Fri, 30 Jan 2009 14:35:39 +0100
Message-ID: <a2633edd0901300535mf2d9ceemd9e9009e0aa18b40@mail.gmail.com>
References: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>
	 <adf1fd3d0901300318s5a0e4c94gab5f31342643ea52@mail.gmail.com>
	 <a2633edd0901300456y48e8d78fn199675f2ae105c8@mail.gmail.com>
	 <adf1fd3d0901300516y3d1bf58dmda9c5172586d828@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 14:44:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LStfu-00079G-D5
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbZA3NnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbZA3NnY
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:43:24 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:39510 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbZA3NnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 08:43:23 -0500
Received: by fxm13 with SMTP id 13so185185fxm.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 05:43:20 -0800 (PST)
Received: by 10.223.114.135 with SMTP id e7mr1053699faq.89.1233322539049; Fri, 
	30 Jan 2009 05:35:39 -0800 (PST)
In-Reply-To: <adf1fd3d0901300516y3d1bf58dmda9c5172586d828@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107818>

Santi,

> Maybe if you explain why you want it (a use case) instead of just this
> specific problem...

To know the proper merge base to display all commits done on a specific
topic branch.

>>> Just a counterexample, just rearranging you graph:
>>>
>>>                        o---B
>>>                        /
>>>                   o---2---o---o---o---C
>>>                  /
>>>          ---o---1---o---o---o---A
>>>
>>> From you description: For B I would get C and for C I would get A.
>
> Please, if you quote text do not edit it (the 1 and the 2 in this case).

Well I've just added 1 and 2, nothing changed in the semantic!

> Yes. Compare your sentence and mine:
>
> For B I want to get A and for C I want to get B.
> For B I would get C and for C I would get A.
>
> So for B you get A while I get C, and the equivalent for C.

Ok, that's expected since you have renamed B to C and C to B.

My tree was:


                        o---o---o---C
                        /
                   o---o---o---B
                  /
          ---o---o---o---o---o---A

Your's was:

                       o---B
                       /
                  o---o---o---o---o---C
                 /
         ---o---o---o---o---o---A

So when I said:

    For B I want to get A and for C I want to get B.

It is equivalent to your (just rename B and C).:

   For B I would get C and for C I would get A.

Frankly I do not see your point... That's maybe the cause of the
problem I'm having....

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595

From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Mon, 19 Jun 2006 09:40:44 +1200
Message-ID: <46a038f90606181440q4fd03bebl9495ace131eb958@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
	 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606111747110.2703@localhost.localdomain>
	 <Pine.LNX.4.64.0606181223580.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Jon Smirl" <jonsmirl@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 23:41:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs518-0000lG-HO
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 23:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWFRVkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 17:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWFRVkq
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 17:40:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:38846 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932311AbWFRVkp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 17:40:45 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1547103ugf
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 14:40:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h9iAefr/zyJv6DJRHq2gv7qdw6IHZng6Pk3zSfAWP0YySbFa6XqAWw7yoZTJ4mt3SSi7EJSGavXc4Bl92OrPU1q7NDqXV6FBgkmEbNiZNfo3uO8rn+RLemJNSM9/Cuqdhx//wuKNICVjQMzlyMS8N/t54saZeTR0G7TrwlVLRRk=
Received: by 10.78.51.9 with SMTP id y9mr1700016huy;
        Sun, 18 Jun 2006 14:40:44 -0700 (PDT)
Received: by 10.78.128.15 with HTTP; Sun, 18 Jun 2006 14:40:44 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606181223580.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22104>

On 6/19/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Or is it just me?

No problems here with my latest import run. fsck-objects --full comes
clean, takes 14m:

/usr/bin/time git-fsck-objects --full
737.22user 38.79system 14:09.40elapsed 91%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (20807major+19483471minor)pagefaults 0swaps

BTW, that import (with the latest code Junio has) took 37hs even with
the aggressive repack -a -d. I want to bench it dropping the -a from
the recurrring repack, and doing a final repack -a -d.

cheers,


martin

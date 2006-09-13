From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Marking abandoned branches
Date: Thu, 14 Sep 2006 08:31:06 +1200
Message-ID: <46a038f90609131331p25923440w45eb49b56933f24b@mail.gmail.com>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
	 <20060913152451.GH23891@pasky.or.cz>
	 <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
	 <Pine.LNX.4.63.0609131804050.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910609131022y19327efy541ac451bdf4b009@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 22:31:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNbO4-0000Sa-VK
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 22:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWIMUbJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 16:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWIMUbJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 16:31:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:54514 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751088AbWIMUbI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 16:31:08 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1809113nfa
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 13:31:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k28AndZ92w9frTO/RNmnP9T0JIvWANz6iU5ilIMACSyFhLMyFvhLmub1r5baSczP2G7d72SU17tmsZttsOW1ITpzqFGcKV7qVqUqkcVXb6JX58P59s+nqYbt7xSShoQ2bIa/kc/E47lf40Q75a33EfBqNovhfCWWIZAJ38+1JlY=
Received: by 10.48.202.19 with SMTP id z19mr11313672nff;
        Wed, 13 Sep 2006 13:31:06 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Wed, 13 Sep 2006 13:31:06 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609131022y19327efy541ac451bdf4b009@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26937>

Hi Jon!

I guess what people are pointing at is that you can:

 - run your import
 - publish that as mozilla-historical.git
 - copy that to mozilla.git
 - rm all the old heads from mozilla.git
 - rm all the 'new' heads from mozilla-historical.git
 - run git-repack -a -d on both
 - make the historical repo read-only

later, it is trivial to 'archive'  branch. Similarly, other projects
run a repo-per-developer or perhaps thematic repos. No point in
painting 'policy'  when usage practices suffice.

By the way, gitk doesn't show all the branches by default. You have to
pass --all, which stands for... all ;-)

maybe gitk should have --recent-heads. However, I use
--since=3.months.ago all the time, and it works great.

cheers,


martin

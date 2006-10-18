From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Integrating gitweb and git-browser (was: Re: VCS comparison table)
Date: Wed, 18 Oct 2006 03:58:03 +0200
Message-ID: <200610180358.03669.jnareb@gmail.com>
References: <vpqejt76vgz.fsf@ecrins.imag.fr> <eh40e1$9g1$1@sea.gmane.org> <20061018015211.GP20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 04:04:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga0gY-0006Ji-Rz
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 03:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWJRB5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 21:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWJRB5c
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 21:57:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:13421 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750823AbWJRB5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 21:57:31 -0400
Received: by ug-out-1314.google.com with SMTP id o38so85621ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 18:57:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SNNM0paiJFq929sg54wrMhqddEufSxY4zOx0QYRTxPOs93xENsK7aetVZYF4oqghZN/LINnfuuIA7nN+jpa1qpJpxUBP/Mi5YR0kxfJjj/lQ3I3YtiMziDBpijXP2PHAivdHOR8CnS90vTCYmm8fJicoJkikVHLiid3HtPn5CgY=
Received: by 10.67.91.6 with SMTP id t6mr10913342ugl;
        Tue, 17 Oct 2006 18:57:30 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id e33sm367821ugd.2006.10.17.18.57.29;
        Tue, 17 Oct 2006 18:57:30 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061018015211.GP20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29177>

Petr Baudis wrote:
> Dear diary, on Wed, Oct 18, 2006 at 03:36:36AM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> Petr Baudis wrote:
>>
>>> so that you can add your own views, so that git-browser can 
>>> integrate to it more reasonably. (Currently it has completely different
>>> UI and you have to patch gitweb in order to get the proper links at
>>> proper places.) Sure, git-browser might get fully integrated to gitweb
>>> later but that needs to be done sensitively so that people are not
>>> scared by the horrible javascript blobs, etc.; currently git-browser is
>>> very experimental, and adding it would be quite intrusive.
>> 
>> I was thinking about adding using JavaScript, in shortlog (and perhaps
>> shortlog-extended, i.e. with date and author) views one extra "diagram"
>> column, with width set using JavaScript generated embedded style, and use
>> only part of git-browser that generates diagram to draw it there.
> 
> Shortlog is paginated and that's not very practical for diagrams, I
> think - you need to gradually extend it instead in that case. But yes,
> keeping the _visual_ difference of git-browser and gitweb as small as
> possible has been the main reason for me to think about integrating it
> more tightly.

You can have paginated graph (diagram). Although it is more natural
to have diagram on the first page only, just like gitk --max-count=100.

The idea is for gitweb to generate (short)log, perhaps with pagination
turned off (CSS overflow: scroll), and git-browser part to generate
diagram and add it to log.
-- 
Jakub Narebski
Poland

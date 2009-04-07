From: Andreas Ericsson <exon@op5.com>
Subject: Re: [PATCH RFC 6/6] send-email: Remove horrible mix of tabs and spaces
Date: Wed, 08 Apr 2009 00:10:37 +0200
Message-ID: <49DBCF5D.6070404@op5.se>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com> <1239139522-24118-2-git-send-email-mfwitten@gmail.com> <1239139522-24118-3-git-send-email-mfwitten@gmail.com> <1239139522-24118-4-git-send-email-mfwitten@gmail.com> <1239139522-24118-5-git-send-email-mfwitten@gmail.com> <1239139522-24118-6-git-send-email-mfwitten@gmail.com> <9b18b3110904071435p320e5d1dh16061d04a3a8ab57@mail.gmail.com> <b4087cc50904071442ka298564x52112c1eac9ac284@mail.gmail.com> <20090407220048.GB18144@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>, demerphq <demerphq@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 00:12:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrJWl-00017p-92
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 00:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbZDGWKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 18:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760147AbZDGWKm
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 18:10:42 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:43129 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935AbZDGWKl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 18:10:41 -0400
Received: by fxm2 with SMTP id 2so2540538fxm.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 15:10:39 -0700 (PDT)
Received: by 10.86.36.17 with SMTP id j17mr542467fgj.19.1239142239634;
        Tue, 07 Apr 2009 15:10:39 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id 3sm9167508fge.14.2009.04.07.15.10.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 15:10:39 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090407220048.GB18144@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116003>

Jeff King wrote:
> On Tue, Apr 07, 2009 at 04:42:36PM -0500, Michael Witten wrote:
> 
>> I'll have to give that a try. However, I've been entertaining the idea
>> of rewriting the whole thing anyway; it's in need of much more than
>> reformatting.
> 
> Just my two cents, but if you are considering re-writing send-email, I
> would suggest two things:
> 
>   1. Make much heavier use of existing CPAN libraries. A lot of the ugly
>      code is trying to handle corner cases in rfc2822 and mime parsing
>      and generation. And I would not be surprised if there were still
>      bugs in that ugly code.
> 
>   2. Make a new command to compete with send-email instead of using the
>      same name. This means that people who are really put off by
>      CPAN dependencies from (1) above won't be negatively impacted. And
>      you can drop any historical interface warts if you want to.
> 

3. Make it capable of sending email directly from commits rather than
   than having to generate them as files first. For bonus-points, use
   git sequencer or some other "git rebase -i"-esque mangling thing
   first, with capabilities of adding a cover-letter for patch-series.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

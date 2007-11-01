From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 1 Nov 2007 15:05:44 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711011459490.3342@woody.linux-foundation.org>
References: <20071022063222.GS14735@spearce.org> <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com>
 <7v4pg5btis.fsf@gitster.siamese.dyndns.org> <200711012232.57286.johan@herland.net>
 <7v8x5hab3d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Geert Bosch <bosch@adacore.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 23:07:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IniC1-0003Er-B9
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 23:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbXKAWG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 18:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754215AbXKAWG6
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 18:06:58 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44577 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753817AbXKAWG6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2007 18:06:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA1M5i0e026190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Nov 2007 15:05:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA1M5i1e017773;
	Thu, 1 Nov 2007 15:05:44 -0700
In-Reply-To: <7v8x5hab3d.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.431 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_33
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63021>



On Thu, 1 Nov 2007, Junio C Hamano wrote:
> 
> "git clean" is about things that git usually do not care about
> (i.e. things not in .gitignore, or even in .gitignore when -x is
> given).  Everything else including "git stash" is all about what
> git cares about (i.e. tracked paths).

Right. I *love* "git clean". Real men have everything they care about 
tracked by git, and thus by definition "git clean" is the safest operation 
possible. I don't understand how anybody can call it "unsafe".

I just wish it was quiet by default - right now it takes a _loong_ time to 
clean out your crud just because it scrolls forever talking about all 
those girly files you don't want to keep - and that it had -x and -d on by 
default, so that us *real* men wouldn't have to type so much.

But making it accept combined options, so that you can do "git clean -xdq" 
would certainly already be a huge improvement.

But yeah, I guess we could make the "clean.Imagirlyman" option (or however 
the "please-don't-hurt-me-by-default" option is spelled) the default. That 
way I'd just feel *extra* manly for immediately disabling it, and laughing 
at you wimps.

			Linus

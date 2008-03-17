From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: repo.or.cz renovation
Date: Mon, 17 Mar 2008 13:41:39 -0700 (PDT)
Message-ID: <m3myoxw0at.fsf@localhost.localdomain>
References: <20080313231413.27966.3383.stgit@rover>
	<76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
	<20080314002205.GL10335@machine.or.cz>
	<1205454999.2758.14.camel@localhost.localdomain>
	<20080317174934.GC6803@machine.or.cz>
	<1205779482.2758.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Mar 17 21:42:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbMA5-0004dU-KJ
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 21:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYCQUlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 16:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbYCQUlp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 16:41:45 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:35763 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbYCQUlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 16:41:44 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2024117fkr.5
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 13:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=8dYWJrEuDPM89r41DetMiYOp/AZg8LSOwd/VfxlShtY=;
        b=pZcWyHJAz/jT3+x2/JhlsUAyjtXGwVcbkWUQyDFa95IzJBZBO6KUaJpuvxN74Tlvl4qoSh1ZIOXGeKwg5FAorDL/zVlhnzdO4xE13hczi6hqDuyjJAzoee5I7n8aw+94JWfG3B05mN64A0lRWLvh0ccCQ5DoRrSPMLAFg3T48Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=eShweEPC2l5KsfCkjDIT+CBUqkJgdHbL5TKwYetZyYDKqKTbnaUF3Bv3zz9Moyv5FM3r24mj6j4fpA+XLn/Z1Gj4kIiMUzgr+XI6OFnXYX7lkSVzsO6+Bde1Un/klJXJU6sK6b4vH65YFB5luo9ovGlutd4WLPtFRhKKWV0K+LM=
Received: by 10.82.107.3 with SMTP id f3mr506782buc.0.1205786500369;
        Mon, 17 Mar 2008 13:41:40 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.213.235])
        by mx.google.com with ESMTPS id 4sm19919794fge.3.2008.03.17.13.41.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Mar 2008 13:41:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2HKfXjD016637;
	Mon, 17 Mar 2008 21:41:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2HKfVGf016633;
	Mon, 17 Mar 2008 21:41:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1205779482.2758.52.camel@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77464>

"J.H." <warthog19@eaglescrag.net> writes:

> BTW I'm about halfway through refactoring my tree from multiple files
> back to one, which at that point means I can start bringing it back into
> mainline and getting a patch series ready for submission.

I plan on sending email with my ideas on gitweb caching somewhere
between now and tomorrow. I'll try to cover my ideas about how to
cache (support for cache validation for external cache, caching Perl
structures / data from git commands, caching final output: HTML, RSS,
etc.) and what solutions can be used.

I wanted first to send my enchancements to Petr Baudis patch adding
caching support for projects list, i.e. third patch in the series, and
get comments (currently none) on *this* patch (idea).

-- 
Jakub Narebski
Poland
ShadeHawk on #git

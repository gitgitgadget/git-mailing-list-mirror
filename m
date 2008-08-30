From: Heikki Orsila <shd@modeemi.fi>
Subject: Re: [PATCH] Replace "git-" with "git " in *.[ch] comments and notifications
Date: Sat, 30 Aug 2008 12:54:11 +0300
Message-ID: <20080830095411.GA28666@jolt.modeemi.cs.tut.fi>
References: <20080829234751.GA2396@zakalwe.fi> <7vvdxj2ucl.fsf@gitster.siamese.dyndns.org> <20080830011509.GA16289@zakalwe.fi> <7vr6872qv1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 12:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZNIp-0002hC-G3
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 12:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbYH3KCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 06:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbYH3KCZ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 06:02:25 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:59390 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbYH3KCY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 06:02:24 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Aug 2008 06:02:24 EDT
Received: from amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70])
	by mail.cs.tut.fi (Postfix) with ESMTP id C9A7E5C06;
	Sat, 30 Aug 2008 12:54:45 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70]) (amavisd-maia, port 10024)
 with ESMTP id 04644-09-2; Sat, 30 Aug 2008 12:54:44 +0300 (EEST)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 679E75C02;
	Sat, 30 Aug 2008 12:54:43 +0300 (EEST)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id 2A0B522200;
	Sat, 30 Aug 2008 12:54:13 +0300 (EEST)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id 8B95BA313D; Sat, 30 Aug 2008 12:54:11 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7vr6872qv1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94369>

On Fri, Aug 29, 2008 at 07:12:18PM -0700, Junio C Hamano wrote:
> I however am not sure if posting a single patch that is 1300 lines long
> would be the most effective way to achieve that goal.  Splitting them into
> a handful batches, spread over a few weeks to give reviewers some
> breathing room, might make it more reviewable.  I dunno.
> 
> [CUT]
> 
> One thing you might be able to do would be to separate user visible
> strings and in-comment strings.
> 
> [CUT]
> 	... would cause git-init to fail here...
>         ... would cause "init" to fail here...
> 
> than:
> 
>         ... would cause git init to fail here...
> 
> Among these three, I think the second one is the most readable. 

Okay, will split patches into smaller ones, distribute them over time, 
and use the second form for _in-comment_ strings. User visible strings 
will say "git init".

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd

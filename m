From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 00:12:58 -0800 (PST)
Message-ID: <588099.85369.qm@web31805.mail.mud.yahoo.com>
References: <87d55pyp82.wl%cworth@cworth.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 09:13:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4C6Q-0002Ea-Sm
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 09:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbXAIINA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 03:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbXAIINA
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 03:13:00 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:33710 "HELO
	web31805.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751155AbXAIIM7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jan 2007 03:12:59 -0500
Received: (qmail 86881 invoked by uid 60001); 9 Jan 2007 08:12:58 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=aprmAqVgiGHz2ic51Dmj8gsAOUDdtBfCR9OO2ltuYHzLXTDan7Za86tBkWm58Mq6TByubt7BNK2nALypuSB9m769Ew/pi36/t2O00yxRV8qHl2M4VHgJFCMjZVu/MJTTyZ1tjfqI4UrCBVn/+7MFYPHjBKgVMAEQtKflG0iwDrQ=;
X-YMail-OSG: BPA8kd8VM1ks6yAoyfMNezU_Hga7MSAqL6zlNqBDvRjAoa20sVNQxE3U9zHClMX.Xw--
Received: from [71.80.231.208] by web31805.mail.mud.yahoo.com via HTTP; Tue, 09 Jan 2007 00:12:58 PST
To: Carl Worth <cworth@cworth.org>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <87d55pyp82.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36327>

--- Carl Worth <cworth@cworth.org> wrote:
> 
> So let's put the safety valve where it's cheap to detect and where we
> know it will distinguish between read-only and read-write use, (that
> is, put it precisely at the point where there's an attempt to create a
> new commit object while in the detached state).

Yes, I agree.

>From my point of view, the question is where does it "go" committing
changes on top of a "detached HEAD".  Commits shold probably be only
allowed on top of local branches, since creating the branch itself
shows an intention, possibly intention to do work, to commit
new things.

    Luben

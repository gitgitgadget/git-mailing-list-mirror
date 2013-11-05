From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: Re: [PATCH] Add the commit.gpgsign option to sign all commits
Date: Tue, 5 Nov 2013 01:03:30 +0100
Message-ID: <20131105000330.GY4589@mars-attacks.org>
References: <1383606881-2979-1-git-send-email-boklm@mars-attacks.org>
 <xmqqppqfag2e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 05 01:05:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdU7O-0000HF-SI
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 01:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967Ab3KEADd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 19:03:33 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:43731 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598Ab3KEADc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 19:03:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id F405D4941;
	Tue,  5 Nov 2013 01:03:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Z2-8wWvh3XWh; Tue,  5 Nov 2013 01:03:47 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 75A4C422A;
	Tue,  5 Nov 2013 01:03:47 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id B97B643934; Tue,  5 Nov 2013 01:03:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqppqfag2e.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237317>

On Mon, 04 Nov 2013, Junio C Hamano wrote:

> Nicolas Vigier <boklm@mars-attacks.org> writes:
> 
> > If you want to GPG sign all your commits, you have to add the -S option
> > all the time. The commit.gpgsign config option allows to sign all
> > commits automatically.
> 
> I'm somewhat horrified to imagine the end-user experience this
> "feature" adds to the system; if one sets htis configuration and
> then runs "git rebase" or anything that internally creates or
> recreates commits, does one have to sign each and every commit, even
> if such a rebase was done merely as a trial run to see if a topic
> can be rebased to an older codebase, or something?

Yes, all rebased commits will be signed, even if it was done as a trial
run. But I don't see this as a problem. The signature indicate who did
the rebase.

From: David Tran <unsignedzero@gmail.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Mon, 31 Mar 2014 19:35:10 +0000 (UTC)
Message-ID: <loom.20140331T213335-569@post.gmane.org>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com> <1395916370-1404-1-git-send-email-ilya.bobyr@gmail.com> <1395916370-1404-4-git-send-email-ilya.bobyr@gmail.com> <CAPig+cQeS6PAZN0nN_0LBfnFF_bGxC000cPSQFdSTVaHQD_haw@mail.gmail.com> <53351F26.9070007@gmail.com> <CAPig+cSDCJ=3BC0dDaJMtfsRx_89z-6knNuRbzY+V3uBXY6xsA@mail.gmail.com> <xmqqlhvq8fbw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 21:35:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhzZ-0006WU-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 21:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbaCaTf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 15:35:26 -0400
Received: from plane.gmane.org ([80.91.229.3]:48091 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbaCaTfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 15:35:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WUhzN-0005g4-Gu
	for git@vger.kernel.org; Mon, 31 Mar 2014 21:35:21 +0200
Received: from 50-23-65-34.revip2.marketstreetwifi.net ([50.23.65.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 21:35:21 +0200
Received: from unsignedzero by 50-23-65-34.revip2.marketstreetwifi.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Mar 2014 21:35:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 50.23.65.34 (Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.1.0.0 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245518>

> Junio C Hamano <gitster <at> pobox.com> writes:
>
> 
> I would have to say that there is already an established pattern to
> pick ranges that normal people understand well and it would be silly
> to invent another more verbose way to express the same thing.  You
> tell your Print Dialog which page to print with e.g. "-4,7,9-12,15-",
> not ">=4 7 ...".  
> 
> Would the same notation be insufficient for our purpose?  You do not
> even have to worry about negation that way.
> 

That will do, especially if the numbers are in ascending order. We won't
have the odd cases of including a test and removing it later on. I think
we won't need a --neg flag to take the negation of the tests in that range?

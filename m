From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Rollback of git commands
Date: Tue, 27 Nov 2007 23:40:42 -0500 (EST)
Message-ID: <BAYC1-PASMTP101A96ADE42981D2708652AE770@CEZ.ICE>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com> 
    <7vmyszb39s.fsf@gitster.siamese.dyndns.org> 
    <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com> 
    <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
    <9e4733910711272037r2ce3ed01y31ec8531f5803efe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:34:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKwR-0004ao-Qx
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:18:55 +0100
Received: from mail-mx4.uio.no ([129.240.10.45])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxEpD-00056f-5L
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:47:03 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx4.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxEp5-0001hB-Ni
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbXK1Eku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 23:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753513AbXK1Eku
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 23:40:50 -0500
Received: from bay0-omc2-s8.bay0.hotmail.com ([65.54.246.144]:65038 "EHLO
	bay0-omc2-s8.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753026AbXK1Ekt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 23:40:49 -0500
Received: from BAYC1-PASMTP10 ([65.54.191.183]) by bay0-omc2-s8.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 27 Nov 2007 20:40:49 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP10.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 27 Nov 2007 20:40:48 -0800
Received: from apache by linux1.attic.local with local (Exim 4.43)
	id 1IxEj4-00058i-MK; Tue, 27 Nov 2007 23:40:42 -0500
Received: from 10.10.10.27
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Tue, 27 Nov 2007 23:40:42 -0500 (EST)
In-Reply-To: <9e4733910711272037r2ce3ed01y31ec8531f5803efe@mail.gmail.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 28 Nov 2007 04:40:48.0798 (UTC) FILETIME=[D915CBE0:01C83178]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.5, required=5.0, autolearn=disabled, MSGID_FROM_MTA_HEADER=1.495,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: F7D458CA7534E73C2657918E005B5EB34133B76C
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -54 maxlevel 200 minaction 2 bait 0 mail/h: 48 total 723815 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66304>

On Tue, November 27, 2007 11:37 pm, Jon Smirl said:

> Patch management is an important part of the work flow. I would hope
> that git implements patch management as a core feature in future
> versions. stgit/guilt/quilt are valuable since they blazed the trail
> and figured out what commands are useful. As time passes these
> features can become more highly integrated into core git.

Think this is a separate topic from where we started though.

> Of course you've never screwed up a repository using git commands,
> right? I've messed up plenty. A good way to mess up a repo is to get
> the data in .git/* out of sync with what is in the repo. I'm getting
> good enough with git that I can fix most mess up with a few edits, but
> it took me two years to get to that point. Rolling back to a check
> point is way easier. User error and a command failing are both equally
> valid ways to mess up a repo.

What are you looking for that reflogs don't already handle?

Cheers,
Sean

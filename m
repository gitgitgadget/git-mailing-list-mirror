X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 05 Dec 2006 12:31:43 +1100
Message-ID: <4574CBFF.8040708@vilain.net>
References: <20061130170625.GH18810@admingilde.org>	 <200612012355.03493.Josef.Weidendorfer@gmx.de>	 <Pine.LNX.4.64.0612011510290.3695@woody.osdl.org>	 <200612020114.42858.Josef.Weidendorfer@gmx.de>	 <Pine.LNX.4.64.0612011621380.3695@woody.osdl.org> <f2b55d220612041056w68db5891t105054c0d35efe45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 01:40:07 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <f2b55d220612041056w68db5891t105054c0d35efe45@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33284>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrPHu-0008G4-BE for gcvg-git@gmane.org; Tue, 05 Dec
 2006 02:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967999AbWLEBjv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 20:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968003AbWLEBjv
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 20:39:51 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:47333 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S968002AbWLEBju (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 20:39:50 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id 47BD4139B0D;
 Tue,  5 Dec 2006 14:39:48 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id
 E8CAC1380C2; Tue,  5 Dec 2006 14:39:42 +1300 (NZDT)
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org

Michael K. Edwards wrote:
> who don't want to run kernel.org-scale mirrors.  To make this work,
> you need sparse repositories (conserving resources when fetching, by
> omitting the bulk of currently un-needed submodules that can reliably
> be obtained later from elsewhere) and shallow cloning (conserving
> resources when publishing, by referring cloners to a third-party
> repository for universally available content).

Did you see GitTorrent?  http://gittorrent.utsl.gen.nz/  A lot of
similar ideas to what you mention.  Sorry, still no prototype :)

I'd see the submodules thing as a good way to glue together a whole
bunch of repositories, so that the core mirror servers only have to
mirror a small-ish number of repositories.

Sam.

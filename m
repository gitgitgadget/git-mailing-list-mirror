From: "Kent R. Spillner" <kspillner@acm.org>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 18 Dec 2013 14:47:41 -0600 (CST)
Message-ID: <1387399661.014711355@apps.rackspace.com>
References: <52B02DFF.5010408@gmail.com> <20131217140746.GB15010@thyrsus.com> 
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com> 
 <20131217210255.GA18217@thyrsus.com> 
 <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com> 
 <20131218002122.GA20152@thyrsus.com> 
 <CANQwDwdgZUWcgyZCWoDni+e9jgQ+8j0Yn_HMxiMn5OHzsRzjwQ@mail.gmail.com> 
 <20131218162710.GA3573@thyrsus.com> 
 <CACPiFC+W-RiO-YL=Wgs7YzV=z-p97ehfA+64j5F2KbayPAQm8w@mail.gmail.com> 
 <20131218195450.GK3163@serenity.lan> <20131218202009.GA4935@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "John Keeping" <john@keeping.me.uk>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"=?utf-8?Q?Jakub_Nar=C4=99bski?=" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Dec 18 21:56:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtOAb-0002G7-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 21:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab3LRU4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 15:56:37 -0500
Received: from smtp172.dfw.emailsrvr.com ([67.192.241.172]:45917 "EHLO
	smtp172.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab3LRU4g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Dec 2013 15:56:36 -0500
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2013 15:56:36 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 7145B188D8E
	for <git@vger.kernel.org>; Wed, 18 Dec 2013 15:47:52 -0500 (EST)
X-Virus-Scanned: OK
Received: from smtp66.iad3a.emailsrvr.com (smtp66.iad3a.emailsrvr.com [173.203.187.66])
	by smtp17.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 57343188D91
	for <git@vger.kernel.org>; Wed, 18 Dec 2013 15:47:52 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp25.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id B0E47E00C1;
	Wed, 18 Dec 2013 15:47:41 -0500 (EST)
X-Virus-Scanned: OK
Received: from app13.wa-webapps.iad3a (relay.iad3a.rsapps.net [172.27.255.110])
	by smtp25.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 2CD45E009D;
	Wed, 18 Dec 2013 15:47:41 -0500 (EST)
Received: from zerosphere.org (localhost.localdomain [127.0.0.1])
	by app13.wa-webapps.iad3a (Postfix) with ESMTP id 0400C380045;
	Wed, 18 Dec 2013 15:47:41 -0500 (EST)
Received: by apps.rackspace.com
    (Authenticated sender: sl4mmy@zerosphere.org, from: kspillner@acm.org) 
    with HTTP; Wed, 18 Dec 2013 14:47:41 -0600 (CST)
Importance: Normal
X-Priority: 3 (Normal)
X-Type: plain
In-Reply-To: <20131218202009.GA4935@thyrsus.com>
X-Mailer: webmail7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239484>

> Which will trash your history - the bugs in that are worse than the bugs
> in 3.0, which are bad enough that I *terminated* it.

Which *might* trash your history.

cvsps v2 and git cvsimport work as advertised with simple, linear CVS
repositories.  I maintain a git mirror of an active CVS repo and run git
cvsimport every few days to sync with the latest upstream changes.  The
only problem I encountered so far was when you released cvsps v3 and broke
git cvsimport. :)  I had to manually downgrade to cvsps v2.2b1 and configure
my package manager to ignore cvsps updates, but I haven't had any problems
since.

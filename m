From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCH 1/2] Add feature release instructions to MaintNotes addendum
Date: Thu, 26 Mar 2009 09:51:45 -0400
Message-ID: <49CB8871.2020605@fastmail.fm>
References: <1238032575-10987-1-git-send-email-rocketraman@fastmail.fm> <20090326121017.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 14:54:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmq1Q-0003dR-Ne
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 14:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166AbZCZNv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 09:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbZCZNvz
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 09:51:55 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:28332 "HELO
	smtp101.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752816AbZCZNvz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 09:51:55 -0400
Received: (qmail 3921 invoked from network); 26 Mar 2009 13:51:52 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp101.rog.mail.re2.yahoo.com with SMTP; 26 Mar 2009 13:51:52 -0000
X-YMail-OSG: eOmUSAAVM1kiJfC7XrLx2qMoYt3TtBc8zM8rA5p4djlhR.S09DlrKM2NIj2IGYN0rw--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id AD92D21C051B;
	Thu, 26 Mar 2009 09:51:51 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HqjOLy7Y8thB; Thu, 26 Mar 2009 09:51:45 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id CFEFF21C051A;
	Thu, 26 Mar 2009 09:51:45 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090326121017.6117@nanako3.lavabit.com>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114778>

Nanako Shiraishi wrote:
> Quoting rocketraman@fastmail.fm:
> 
>> + - The 'maint' branch is updated to the new release.
>> +
>> +     $ git checkout maint
>> +     $ git merge master
>> +
>> +   This is equivalent to deleting maint and recreating it from
>> +   master, but it preserves the maint reflog.
> 
> After giving a recipe that is better than an alternative, what's
> the point of describing an inferior alternative as "equivalent",
> when it is obviously not "equivalent"?

Is this better:

The resulting maint tree is equivalent to deleting maint and
recreating it from the tip of master, but merging from master
preserves the maint reflog.

Cheers,
Raman

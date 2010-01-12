From: "Edward Z. Yang" <ezyang@MIT.EDU>
Subject: Re: Interest in locking mechanism?
Date: Tue, 12 Jan 2010 14:43:19 -0500
Message-ID: <1263325308-sup-5516@ezyang>
References: <1263319565-sup-1767@ezyang> <32541b131001121101i76ad8062p3a7f3571ad86b0ce@mail.gmail.com> <1263323292-sup-4182@ezyang> <32541b131001121124u541de280na9184183d8704dc8@mail.gmail.com> <46a038f91001121133r62b3d748n38ca27234f18e960@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Avery Pennarun <apenwarr@gmail.com>, git <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 20:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUmeK-0003sA-7y
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 20:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab0ALTn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 14:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703Ab0ALTn0
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 14:43:26 -0500
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:47934 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754729Ab0ALTn0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 14:43:26 -0500
X-AuditID: 12074424-b7ce5ae000007d76-d2-4b4cd0dd659b
Received: from central-city-carrier-station.mit.edu (CENTRAL-CITY-CARRIER-STATION.MIT.EDU [18.7.7.72])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id F1.86.32118.DD0DC4B4; Tue, 12 Jan 2010 14:43:25 -0500 (EST)
Received: from outgoing-legacy.mit.edu (OUTGOING-LEGACY.MIT.EDU [18.7.22.104])
	by central-city-carrier-station.mit.edu (8.13.6/8.9.2) with ESMTP id o0CJiH3G004943;
	Tue, 12 Jan 2010 14:44:17 -0500 (EST)
Received: from localhost (EZYANG.MIT.EDU [18.243.1.50])
	)
	by outgoing-legacy.mit.edu (8.13.6/8.12.4) with ESMTP id o0CJhaa3004773;
	Tue, 12 Jan 2010 14:43:36 -0500 (EST)
In-reply-to: <46a038f91001121133r62b3d748n38ca27234f18e960@mail.gmail.com>
User-Agent: Sup/git
X-Scanned-By: MIMEDefang 2.42
X-Brightmail-Tracker: AAAAAQCq+Kk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136755>

Excerpts from Martin Langhoff's message of Tue Jan 12 14:33:18 -0500 2010:
> So write your own "git-lock" command that does "chmod g-w $@";
> git-unlock reenables the group-writable bit. Done.

That was what I was thinking of doing (with modestly more cleverness for
recursive operation), and maybe some convenience flags for git-commit
for automatically unlocking or preserving the lock across a commit.

Cheers,
Edward

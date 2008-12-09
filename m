From: Kristian Amlie <kristian.amlie@trolltech.com>
Subject: Why doesn't "git log --cherry-pick" work with ranges?
Date: Tue, 9 Dec 2008 08:52:30 +0100
Message-ID: <493E23BE.6030809@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII";
	format="flowed"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 08:53:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9xPn-0002pe-DF
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 08:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbYLIHwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 02:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYLIHwi
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 02:52:38 -0500
Received: from hoat.troll.no ([62.70.27.150]:35338 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017AbYLIHwh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 02:52:37 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id DA5C320E88
	for <git@vger.kernel.org>; Tue,  9 Dec 2008 08:52:31 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id C8DC120E80
	for <git@vger.kernel.org>; Tue,  9 Dec 2008 08:52:31 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id mB97qVOe011937
	for <git@vger.kernel.org>; Tue, 9 Dec 2008 08:52:31 +0100
Received: from [172.24.90.99] ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Tue, 09 Dec 2008 08:52:31 +0100 (CET)
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080519)
X-Enigmail-Version: 0.95.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102604>

Is it because A..B internally translates to B ^A?

Is this something that would be easy to add?

--
Kristian Amlie

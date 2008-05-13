From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v2 05/24] Added WorkTree class which can be constructed over Repository.
Date: Tue, 13 May 2008 23:13:33 +0200
Message-ID: <200805132313.33217.robin.rosenberg.lists@dewire.com>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-6-git-send-email-florianskarten@web.de> <20080513000405.GZ29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Florian Koeberle <florianskarten@web.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 13 23:15:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw1qN-0008J5-TW
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 23:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759340AbYEMVOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 17:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759293AbYEMVOl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 17:14:41 -0400
Received: from [83.140.172.130] ([83.140.172.130]:6547 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757552AbYEMVOl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 17:14:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 97DD41434CCD;
	Tue, 13 May 2008 23:14:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N5bXiksl-y-j; Tue, 13 May 2008 23:14:39 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 35A5280265F;
	Tue, 13 May 2008 23:14:39 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080513000405.GZ29038@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82045>

tisdagen den 13 maj 2008 02.04.05 skrev Shawn O. Pearce:
> This is actually making me reconsider how the WindowCache is handled.
> Maybe we should have a single WindowCache instance down inside
> of jgit, but allow the higher level UI (like Eclipse) to tune it
> on the fly.  Then we don't have to worry about passing it down to
> utility routines like this anytime we open a Repository.

A singleton WindowCache makes more sense yes.

-- robin

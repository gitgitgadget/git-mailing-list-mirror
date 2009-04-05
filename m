From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 5/5] Cache resolved ids in quickdiff document for faster update
Date: Sun, 5 Apr 2009 23:40:01 +0200
Message-ID: <200904052340.01864.robin.rosenberg.lists@dewire.com>
References: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com> <1238697991-12990-6-git-send-email-robin.rosenberg@dewire.com> <20090405203604.GP23521@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:42:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqa6a-0006al-Pc
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbZDEVkM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 17:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755517AbZDEVkL
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:40:11 -0400
Received: from mail.dewire.com ([83.140.172.130]:25428 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754610AbZDEVkK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 17:40:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5EF571483A0B;
	Sun,  5 Apr 2009 23:40:03 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pr-0Sfrcn8I7; Sun,  5 Apr 2009 23:40:02 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id AE9041497A4B;
	Sun,  5 Apr 2009 23:40:02 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090405203604.GP23521@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115719>

s=F6ndag 05 april 2009 22:36:04 skrev "Shawn O. Pearce" <spearce@spearc=
e.org>:
> Arrrgh.  We're still using Commit/Tree/TreeEntry to read file paths?
>
> I'm applying this as-is, but we really need to start to transition
> away from them.  I wanted to start deleting the mapCommit and its
> friends from the Repository class.

Yeah, but the new API is more awkward and error-prone to use. The old
API is quite straightforward. I will try harder next time.

-- robin

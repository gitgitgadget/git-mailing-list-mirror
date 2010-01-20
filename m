From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: git equivalent to clearcase wink-in
Date: Wed, 20 Jan 2010 22:24:47 +0100
Message-ID: <201001202224.47747.robin.rosenberg@dewire.com>
References: <810256.84037.qm@web45111.mail.sp1.yahoo.com> <7938b46a1001201305j499e05bg2654d634d7b26d76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Richard Assal <richard_assal@yahoo.com>, git@vger.kernel.org
To: Jamie Wellnitz <jwellnitz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:24:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXi2s-0001do-5B
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab0ATVYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 16:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754129Ab0ATVYx
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 16:24:53 -0500
Received: from mail.dewire.com ([83.140.172.130]:8477 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972Ab0ATVYx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 16:24:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 94CB780285E;
	Wed, 20 Jan 2010 22:24:49 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bpa2vWMqnJQk; Wed, 20 Jan 2010 22:24:49 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 2064A80025E;
	Wed, 20 Jan 2010 22:24:49 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <7938b46a1001201305j499e05bg2654d634d7b26d76@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137584>

onsdagen den 20 januari 2010 22.05.46 skrev  Jamie Wellnitz:
> Would something like ccache (compiler cache) help you out?  It's not
> the same as wink-in (which, as I understand it, copies an already
> built object file from someone else who has built it).  Instead each
> user has their own cache, so everyone has to pay the expensive build
> price at least once.
> 
> It also only works for C/C++, I think.

Judging from the documentation you can share the cache with others.

-- robin

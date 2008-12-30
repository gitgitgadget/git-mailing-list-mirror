From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: why still no empty directory support in git
Date: Tue, 30 Dec 2008 07:58:41 +0100
Message-ID: <200812300758.41988.robin.rosenberg.lists@dewire.com>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com> <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net> <3ab397d0812292128j65e2e1e1xf403a998f4653aac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Asheesh Laroia" <asheesh@asheesh.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 08:27:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHZ0w-0002zb-Ju
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 08:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbYL3H0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 02:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbYL3H0V
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 02:26:21 -0500
Received: from mail.dewire.com ([83.140.172.130]:27098 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbYL3H0U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 02:26:20 -0500
X-Greylist: delayed 1655 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Dec 2008 02:26:20 EST
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 765828028B8;
	Tue, 30 Dec 2008 07:58:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vClhrbd-p6EA; Tue, 30 Dec 2008 07:58:43 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id DDACC80280E;
	Tue, 30 Dec 2008 07:58:42 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <3ab397d0812292128j65e2e1e1xf403a998f4653aac@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104165>

tisdag 30 december 2008 06:28:58 skrev Jeff Whiteside:
> funny, i thought it was 1, by design.
Sure, but designs can be changed.

> 
> but i forget why a tree object couldn't point to an empty blob.

It can, but that's not the same.

You can have an empty tree, but the index doesn't store them, 
so they would be lost on checkout/commit. Linus sketched a solution, 
but nobody took the bait. Seems doable if anyone really wants it, but
I'm certain it adds a lot of special cases.

Look for a discussion [RFC PATCH] Re: Empty directories... posted on 2007-07-19.
It's in the middle of a long thread.

-- robin

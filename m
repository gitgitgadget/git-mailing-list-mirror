From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Retrieving logs matching pattern for all time.
Date: Sun, 4 Sep 2011 18:13:23 +0200
Message-ID: <201109041813.24418.trast@student.ethz.ch>
References: <CA+eQo_0gZpbz399GN1b+0mq8OY3Xoo+kij=UGSjwbJcNreYBvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jeremy Nickurak <vger-lists@trk.nickurak.ca>
X-From: git-owner@vger.kernel.org Sun Sep 04 18:13:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0FKO-0006Sx-BN
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 18:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303Ab1IDQNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 12:13:38 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:59059 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252Ab1IDQNh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 12:13:37 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Sun, 4 Sep
 2011 18:13:32 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.289.1; Sun, 4 Sep
 2011 18:13:34 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.3-41-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CA+eQo_0gZpbz399GN1b+0mq8OY3Xoo+kij=UGSjwbJcNreYBvw@mail.gmail.com>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180687>

Jeremy Nickurak wrote:
> > user@host:~/something$ git log -- 'hel*'
> > user@host:~/something$
> 
> IE, git doesn't seem to interpret globs itself in patterns.

It does for me:

thomas@thomas:~/g(next u+59)$ g log --oneline --name-status -- "REA*"
f73b3af README: git lives at http://git-scm.com these days
M       README

etc.

Which git version are you using?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

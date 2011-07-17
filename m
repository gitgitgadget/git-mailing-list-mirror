From: "Long, Martin" <martin@longhome.co.uk>
Subject: Re: Git commit generation numbers
Date: Sun, 17 Jul 2011 20:00:17 +0100
Message-ID: <CANfMb_8ctvPqAJ-mpAZKvcXLwV8QexFU-u48GC0CmNqxFeJ5YQ@mail.gmail.com>
References: <20110717182743.14423.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, torvalds@linux-foundation.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 21:00:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiWZl-0003CC-6D
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 21:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153Ab1GQTAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 15:00:19 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38490 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab1GQTAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 15:00:18 -0400
Received: by vws1 with SMTP id 1so1768314vws.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 12:00:17 -0700 (PDT)
Received: by 10.220.180.66 with SMTP id bt2mr1410160vcb.144.1310929217458;
 Sun, 17 Jul 2011 12:00:17 -0700 (PDT)
Received: by 10.220.185.204 with HTTP; Sun, 17 Jul 2011 12:00:17 -0700 (PDT)
X-Originating-IP: [212.159.12.193]
In-Reply-To: <20110717182743.14423.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177312>

> Why freeze this in the object format?

Because if you put it in the object format, then it gets pushed and
pulled around, thereby putting generation numbers in every clone.

I'm starting to think put them in the object store, for exactly that
reason, and to start moving repositories in a direction where the look
more like they would if this had been done correctly from the start.

Then, because some operations are still going to create a lot of
traversals, a cache is always an option to improve the performance in
that area.

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Tue, 23 Apr 2013 01:24:16 +0530
Message-ID: <CALkWK0kVDbyQBTSTbEDoVFs8E6JKWw3Z6L77NCXSb=FU8GNDkw@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
 <CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com>
 <CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com> <87zjwqpebl.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:55:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMpJ-0006VR-JD
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214Ab3DVTy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:54:57 -0400
Received: from mail-ia0-f175.google.com ([209.85.210.175]:49207 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab3DVTy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 15:54:56 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so1567671iae.34
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 12:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QG6kjf7uK9xT7Hav2w2sH+2KCf2i+ZOWnOn6/O8VxWo=;
        b=L0GWOeo68CS5kpA9jdhgufgsUswoEtYiJzgQhISGxr2lYmE/riaqsE7XfwFJ8HEUKl
         uQoifA1zxM6M+aRJcduI1RcYGNVMX3KkIU8jwe1/O/E+rWtnFSVUdS3RRW0IGgSlZ9CC
         y3OOg3+OalVnZB2XaouYlN67GB6SDaOqOzq61zwksXIozD+hBJdrk9d72IBeJfjpe5rF
         az2u5RDhQt8yBRdphDg6xNhTYqC6H7W5GFut+WcG3D/sRmwKD1hKDVnH73bdioOVp8fI
         gr4Nr6yhebcgOzCFYdUGpeCAojId5tWGLsNvdqD77djuZTRWBxi6LQAvcwmv9sgGZTfh
         vqnQ==
X-Received: by 10.50.119.102 with SMTP id kt6mr16366222igb.12.1366660496051;
 Mon, 22 Apr 2013 12:54:56 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 12:54:16 -0700 (PDT)
In-Reply-To: <87zjwqpebl.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222069>

Thomas Rast wrote:
> There is a market for a rename detection that works at the tree level.

Exactly.  And making it auto-follow with a low threshold would be a
great default.  We'll have to deal with D/F conflicts that Junio was
talking about in (2), every once in a while.  We'll have a lot more
incentive to build the D/F conflict resolution process a nice UI.

git-core will actually start working with trees the way it works with blobs.

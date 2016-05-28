From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] blame.c: don't drop origin blobs as eagerly
Date: Sat, 28 May 2016 14:34:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605281430440.4449@virtualbox>
References: <1464356141-3797-1-git-send-email-dak@gnu.org> <alpine.DEB.2.20.1605271633230.4449@virtualbox> <87d1o7pkyy.fsf@fencepost.gnu.org> <alpine.DEB.2.20.1605280815040.4449@virtualbox> <87shx2oaaw.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat May 28 14:35:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6dSR-0004H5-4b
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 14:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbcE1Meu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 08:34:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:56863 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbcE1Met (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 08:34:49 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M1W5x-1bLhUR1tCD-00tVSD; Sat, 28 May 2016 14:34:34
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <87shx2oaaw.fsf@fencepost.gnu.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:QW8r+LSov0h+gh03qPKAO9zq6D5Dzghd2oZs4qN3qxuiWIJRmwd
 oPFhgshmn/mToB/vjpE5DqBOx6hG327SK2G0PNLJf/Z06bT8YjvO2PErjq3CgLvzdwoUJlA
 ym4rkE4ESU3NtIdU0qdLGVD+rV1wcco0kn2+hBkzoDyAF6F2vYo99AbtRk4NC3/uPFgsAEL
 IuOhTN7VT8Kh0/xN7H4oQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w4mrNpZ4i3E=:qHRslklDuyoIDOmsOXEIs6
 2A47KrzlGsPFm0X/BEcJMXfsfbhgLMV6yiSgGsuL9wIAGC56v25FkKBOO9cA31d1u7zaXWYZ2
 0FZjc/QS608I86gPDiUhA/nGIAAnk87jnUU+YcHAuoY/V/yrYNLkKBaasUITK3jMwKYkXzumu
 DAbp6RodLP7p/2PWh6Zu1nCvNPOlAGrovVmSjSvm9vmAdKM9DU9UlvYWyTiRMEOccdOr7F18q
 LC1DmENvJbQdyzi/j3xh6HzT1kP15WpcKl1nFVzKnQth9/5AW2m7God1lZsJTfIHRvcBzkpL6
 j0s1QY9Q0a78kRvSv6OGq66LPX50VyMVhHffbDBIv8eCD6VBr85NJdgvAs6KLZhqSa+9+9p6M
 y0S4bsZtrwrd2npsxIf42Yo8otFSuDiFnEUuWvq1u28VUvvhCw6IlDSE8PEwzXRohWjcH9pSc
 FJtFPFAxSKej+6fY+zIwn108Iah/VFeyTj5TTk4RUJO9nBqWyaZOd7bJO0Ye5+P+ThHghZr1Y
 yYgj5XzMsET/W2zvY+n3kJRMUK1SccyxxxWCwArgrQGOVn7HBXkTmWPglkL+hsqnYyVUuGp9C
 s43FnQYRpyjiz00453PDOJyvckkiZ0WXQV8E17+YTGLBoJTHu0Azu+KCtskDL/xut3KdbiRtH
 hm2F0wny2/7pZV8imWMRvhWfhS2CrODF3Jus1oKHgYzbA8KhMmpRqHqD5ychtXBZWeSaIHo/T
 ZIMdr+ocwyM3Atf+4zhvSpUUyEceSK0t+P5ofLovhFvURtoUN5ZeWlXINkhebIkkZcOd/+3e 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295811>

Hi David,

On Sat, 28 May 2016, David Kastrup wrote:

> > The short version of your answer is that you will leave this patch in
> > its current form and address none of my concerns because you moved on,
> > correct? If so, that's totally okay, it just needs to be spelled out.
> 
> Yes, that's it.  You'll notice that the code change itself is both
> minuscule as well purely functional, so it contains nothing
> copyrightable.

That is unfortunately an interpretation of the law that would need to come
from a professional lawyer. As it is, the patch was clearly authored by
you, and anybody else who would claim authorship would most likely be
breaking the law.

So I won't touch it.

Sorry,
Johannes

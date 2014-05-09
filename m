From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 00/25] contrib: cleanup
Date: Fri, 09 May 2014 10:57:54 -0500
Message-ID: <536cfb02d0f1a_ce316372ecce@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <CACPiFCJnsu3qw59oK94sP1u0+KBDvne0ZpKS0LMGc_9ge+rJjA@mail.gmail.com>
 <536c36fc8e04c_741a161d31095@nysa.notmuch>
 <20140509152236.GC18197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 17:58:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WinBW-0007Op-FE
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358AbaEIP6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:58:00 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:33407 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbaEIP6A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 11:58:00 -0400
Received: by mail-yh0-f47.google.com with SMTP id z6so3489234yhz.6
        for <git@vger.kernel.org>; Fri, 09 May 2014 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=+DIvXe3VNiUbuC7upoAUoHmVE3x8q7lITEH/LYME+/E=;
        b=tMrdj6pxsAe6wJsleMT8mIDD/DFOw620VKkJemFJt6WbxTot+NMEfDE8KEnZxtt8VT
         XtNid+NcAmunebNa6hVmOHpAi9yrR+0NZphgJf8Ixv86nkyWaePoi6EsXg7zZ0fJA3fi
         MYu/BYKFW6/fYui+FGYatTZcewyLgaCJ5SZspW16C+eYnijXHUraQj/sDZa7ObIJV1ED
         p3JSMLttnRxsqzR9ZqxpPGhT3tMo3ejp1028xciz20dxoHg4Uhj4hBtsj9nxReRsM+T8
         Oc5Fdo061kcKge/tVU4RMpgsADufvh7jnOP9WSYhIZLMbwOhVYV6L9mt+sbiKvUks9Ay
         lK7w==
X-Received: by 10.236.90.12 with SMTP id d12mr16355612yhf.120.1399651079666;
        Fri, 09 May 2014 08:57:59 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id q66sm6689821yhj.44.2014.05.09.08.57.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 08:57:58 -0700 (PDT)
In-Reply-To: <20140509152236.GC18197@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248577>

Jeff King wrote:
> On Thu, May 08, 2014 at 09:01:32PM -0500, Felipe Contreras wrote:
> 
> > > Are you planning on CC'ing the (inactive) authors/maintainers
> > > so they know that if they care they should host those elsewhere?
> > 
> > They are already Cc'ed.
> 
> I don't think you were very thorough on this. Of the three remaining
> contrib projects I authored (and for which I am the top shortlog entry),
> you cc'd me on one. For contrib/persistent-https, you did not cc Colby,
> who is the sole author. I didn't look beyond that.

I already explained:
> That's right, and they are Cc'ed so they can respond.  Some tools have
> only one commit or two, and in those I didn't even bother Cc'ing
> anyone.

contrib/persistent-https consist of a *single* commit, I didn't bother
with those.

> If we are going to remove projects so they can be maintained out of
> tree, it seems like the prudent thing to do is make sure the original
> author is aware so that they can actually start maintaining it out of
> tree.

And how do you determine the author? We don't have a MAINTAINERS like
Linux. Is it the first commit?

-- 
Felipe Contreras

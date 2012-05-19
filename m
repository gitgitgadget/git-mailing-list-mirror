From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t3404: begin "exchange commits with -p" test with
 correct preconditions
Date: Sat, 19 May 2012 17:15:43 -0500
Message-ID: <20120519221543.GE4567@burratino>
References: <4FB79CA8.7080103@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun May 20 00:16:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVrwx-0003qy-2Z
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 00:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab2ESWPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 18:15:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41637 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2ESWPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2012 18:15:52 -0400
Received: by obbtb18 with SMTP id tb18so5886710obb.19
        for <git@vger.kernel.org>; Sat, 19 May 2012 15:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6SEdGK3Gxg5pm0QdSR8nXGNAXYlWY/EY3m7wC8cdmsA=;
        b=MZ7vlo6DIk0Gf49DdC3OUTlHOoeTaIE66LlFOF4EhDTCzE1giygsT6wx1GI1viQjc7
         +Vpjv3RItL+luCiVPBcXJc8sAPvQZ17h1sacoTmAilwbA0yIAI6IvP6XTdcyMgb07eMH
         UlFskf3EBrmiKify8C+INVE0Ji5hK53zHUYLb6Cgchak279/M0fsV2KJ0I3BrFZ4Vx4p
         dX4ggECnfYtcKnmItrcUm2AHc6GHhbSi0YBALxH5Zu6HZ4l22SnanX5t1gm/fIqkM/id
         ZOLKxd6UZJ7rVP7QXKhKvVWQhWoUeLfTB2ZdI5OurnmFuLgdH4jEmKvYGPiZtiRPbaVp
         qicw==
Received: by 10.50.100.226 with SMTP id fb2mr3747518igb.31.1337465751225;
        Sat, 19 May 2012 15:15:51 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id fk6sm6361483igc.5.2012.05.19.15.15.50
        (version=SSLv3 cipher=OTHER);
        Sat, 19 May 2012 15:15:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FB79CA8.7080103@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198040>

Johannes Sixt wrote:

> The test case shows a bug in 'rebase -p', but even if the bug were fixed
> the test would fail because it did not ensure that the preconditions match
> the postconditions that were checked. Insert the suitable 'git checkout'.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Could it be that this bug existed since the test case was introduced
>  in cddb42d2?

Yeah, looks like it was always broken.  I remember sanity checking
by removing the "-p", too, but that was probably before moving the
test to join the other -p tests.  Thanks for fixing it.

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

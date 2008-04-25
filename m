From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/5] Introduce fast forward option only
Date: Fri, 25 Apr 2008 03:46:41 -0700 (PDT)
Message-ID: <m3lk32p5z9.fsf@localhost.localdomain>
References: <402c10cd0804232253g3ff8665dk89e2ddcc38353752@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 12:47:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpLSn-0005Eq-JK
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 12:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758484AbYDYKqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 06:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758761AbYDYKqs
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 06:46:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:23360 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758669AbYDYKqq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 06:46:46 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1415606nfb.21
        for <git@vger.kernel.org>; Fri, 25 Apr 2008 03:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=vZCrPx6SfngDerRzqr7gJLnEaLEekT88sU2MsyFch0Q=;
        b=SYQlHk7rL8z/Ejbx3oKsF9ZsQ83Z0GhYY8vS+pGhvZgQ2tHDvt4FPoi6kPqG0Rln9sZ7SV6f55SOzQuP4X1xcLlYSEsLzc3LE0YDf7K4yPOCHsLAOVStSSaW1AbjysRjFN8HClxGE7TkzMbhlb9IAYUxreXggY8xc6RrGDLz08s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=x2jXEZJDjHL10UntdqNy61AsiYqarst7Vas0yLs/zM9RUXddQHyqReICfFSY3agB5kI/WZDah28312a2UfInO6Z6rmKRZxbyS3b8qKQ9DMSQdQV2jmV8VrsG32IoxZodx6Ga16qux+UklAqa/NCkb4oOwGZLjamXmpXKWyGwyLY=
Received: by 10.210.30.10 with SMTP id d10mr2178660ebd.72.1209120402992;
        Fri, 25 Apr 2008 03:46:42 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.255.239])
        by mx.google.com with ESMTPS id 1sm2543869nfv.3.2008.04.25.03.46.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Apr 2008 03:46:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3PAkbqC023230;
	Fri, 25 Apr 2008 12:46:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3PAkITv023225;
	Fri, 25 Apr 2008 12:46:18 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <402c10cd0804232253g3ff8665dk89e2ddcc38353752@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80336>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> This feature is needed for git integration with accurev.
> See the documentation for an explanation of this feature.

I'd rather have description of the change in the commit message
itself.  You can add "See the documentation for details", but the
basic description, like:

   This commit introcudes fast forward option 'only'.  With --ff=only
   merge succeeds only if it resolves to fast-forward merge.
 
It would be nice to have described either in commit message, or in the
documentation, _why_ it is needed for integration with AccuRev,
i.e. what features of AccuRev or of integration requires this.

-- 
Jakub Narebski
Poland
ShadeHawk on #git

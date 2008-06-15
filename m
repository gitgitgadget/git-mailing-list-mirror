From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] path-list documentation: document all functions and data structures
Date: Sun, 15 Jun 2008 02:01:19 -0700 (PDT)
Message-ID: <m3k5groyw8.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0806141705050.6439@racer>
	<1213485725-6755-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 11:02:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7o8J-0004Da-Uu
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 11:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbYFOJBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 05:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756551AbYFOJBX
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 05:01:23 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:21680 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475AbYFOJBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 05:01:22 -0400
Received: by ik-out-1112.google.com with SMTP id c28so3678812ika.5
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=VA9TBYvXYHf/woMhDiHAiECOJPBm4FtZrTDzrxuyNhc=;
        b=R63Q7hhxnK+LbymWQA4BFV0HjeQoyKn3mY1bNNZ7pxqaiowNdYZ5jkQNtnsqZHA9TF
         B1ggMY98uLLR7ZS8E2Bt/7WP215/YhWozYB2bi4XtXxJFScBWbksNycydtvQLxTVEOVB
         R1l5itTCaRMUSQQyyg+1AoEkoJcN2KseP/lsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=h8ViI/wp8o5KNDbh6MPqnVJhrbXK8f7QEZfcJPZfHhUdOli7ppDuAwmOjCSrs6chMs
         aUDAXqCWjhwPSk3amItopIPE3cLZik2WkaKiLlVJP74hvB89Ru6huL96m8bTV1yX+mX6
         HgweD9DRcEvve3MhIbGtLSSUITo0OLaUcaBow=
Received: by 10.210.54.15 with SMTP id c15mr4829294eba.128.1213520480220;
        Sun, 15 Jun 2008 02:01:20 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.239.84])
        by mx.google.com with ESMTPS id c25sm6751643ika.11.2008.06.15.02.01.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 02:01:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5F91Fqg031023;
	Sun, 15 Jun 2008 11:01:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5F91BqD031020;
	Sun, 15 Jun 2008 11:01:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213485725-6755-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85073>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +NOTE: It is more efficient to build an unsorted list and sort it
> +afterwards, instead of building a sorted list `(O(n log n)` instead of
> +`O(n^2))`.

I think there is typo here (misplaced backticks '`' on the wrong side
of enclosing parentheses), and this fragment should read:

+afterwards, instead of building a sorted list (`O(n log n)` instead of
+`O(n^2)`).

-- 
Jakub Narebski
Poland
ShadeHawk on #git

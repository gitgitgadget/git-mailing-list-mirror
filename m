From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Update Documentation/git-config to reflect --local
 option.
Date: Thu, 3 May 2012 22:26:35 -0500
Message-ID: <20120504032400.GB2589@burratino>
References: <1754870.q6d2rgDqBT@flobuntu>
 <7vr4v0deyg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	davidbarr@google.com, Jeff King <peff@peff.net>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 05:26:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ9AL-00089J-3E
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 05:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878Ab2EDD0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 23:26:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39192 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab2EDD0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 23:26:39 -0400
Received: by obbtb18 with SMTP id tb18so3367597obb.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 20:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+SzWOluEhJIGLoiCo6bZhiqbPzGnwTu6+fdsFFY1XPA=;
        b=VxPLWOoFeYGsuOGZu/bZr4Ya0aFlonjiTHVd+j6hDsTvV5o0WQTA4KhLYzPMNuLF5z
         2SuNjkw/Va06a5XnZU2/zbMfhKEQcUkg4QU/q6LuCn/En7PgfOetPftlG3I/JGEYWBuW
         S+oTGPgnTiyir9+jQ60O3rlROIF+vQZeGPXigt0KxuXdGayXhOAYZ1AfAmj0h6YGDdV9
         5VKlUKLYMSHNe7V8c2ytrKRk8LsUps7Ww7LAKxmdu7aHKCBNACMIttyPGd9+FQQjMjwu
         dBjxUWkyCjngo0B1eXqoMEYoXxns+CC6M5cqhBQ3/S+6BK8BrQYYA4bIECLqtstmXQhB
         IUPA==
Received: by 10.50.135.36 with SMTP id pp4mr2088275igb.19.1336101998641;
        Thu, 03 May 2012 20:26:38 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id xf6sm3645857igb.13.2012.05.03.20.26.37
        (version=SSLv3 cipher=OTHER);
        Thu, 03 May 2012 20:26:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr4v0deyg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196984>

(adding Jeff to cc)
Hi Florian and Junio,

Junio C Hamano wrote:

> The paragraph should first be restructured to describe read and write
> cases separately, and then '--local' should be described, perhaps like
> this?

Thanks --- that makes a lot of sense to me.

Florian, would you be interested in another go?  The usual convention
in cases like this is to start the subject line with something like
"[PATCH v2]" so it is clear which version of the patch is supposed to
be better than the other.

Hope that helps,
Jonathan

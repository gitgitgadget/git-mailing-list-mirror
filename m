From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 20:41:59 +0530
Message-ID: <CALkWK0m6r4yRfCLb3dejdY+1KJgdOHPfrvPXbftNucApXFx+0A@mail.gmail.com>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
 <1371196058-23948-2-git-send-email-artagnon@gmail.com> <7vhah0raps.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 17:12:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnVgE-0000gt-DF
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab3FNPMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 11:12:41 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:57653 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab3FNPMl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:12:41 -0400
Received: by mail-bk0-f44.google.com with SMTP id r7so330433bkg.31
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LcZ+n5oPXxWQao28ctCis/x5uH8IvC2M9XtA+EcTnPA=;
        b=dzmB67rI89oaHyqJXYDfOdHHi+UBIsnGTP7bkv+TRyNElM6KjOg04RKktPknG/oube
         UW0drlWjzAyJbW1JMO54HJ/UQaovhRyaWRbr8XjPbhlhPf918hFBO7kXV/zKcfQHKEzv
         IAIAYgMi+PLcramUKDfkwYfDwxgh9+yjOsPxSjoma/d6RFZJaeFCJbcZdeyZaxfSOOvy
         EOrH9+1rJblBSjvtEjVjzRqzXOoz6WrAJ3NJbl01pWez0xccMCA0E9sdVmzcMPJwRS1s
         sBOaDHhIsX7QYv4TJDCdJZnKHmRB/71irTueewVX9WyXYBK/74wVqjwTA0XacjUwLNdY
         Y6Tg==
X-Received: by 10.204.240.79 with SMTP id kz15mr410362bkb.112.1371222759804;
 Fri, 14 Jun 2013 08:12:39 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Fri, 14 Jun 2013 08:11:59 -0700 (PDT)
In-Reply-To: <7vhah0raps.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227883>

Junio C Hamano wrote:
> $dotest, or \$dotest?

Works fine for me like this.  Why do we escape the dollar in the other strings?

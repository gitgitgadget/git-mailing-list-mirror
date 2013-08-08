From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 8 Aug 2013 10:00:30 +0530
Message-ID: <CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
 <52027B17.7040602@googlemail.com> <7vtxj1crv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 06:31:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Hsa-00051r-6J
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 06:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab3HHEbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 00:31:12 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:57655 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab3HHEbL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 00:31:11 -0400
Received: by mail-ie0-f179.google.com with SMTP id c11so1073715ieb.38
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 21:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TU8hK7zxVXVWBihqqrVLJAfXqBcIjOYwFK35UU19nzw=;
        b=Ja6opPEsu9PIp+LgpNN1JDcZ2/hBQob7/97Pl6lmn0w3NyG4iHjQk11wxgHiYKsAu3
         3WWYRjinMDNKkGjYP4IcFilkcw8AvoAuwm1uepBQvrp6agRo19H+kq7tUX3iCmJXR8t3
         AtdZ0fb6HX2NIWg/PI5Q3TW2QlxfQ/qIK8wwK80kVgmqo+5KSxQ7bAyzPW8TtU5Ct3rV
         kUqdW4DQe6mp55zNwWkvy+xvbLDn/TOzr21kqw/zDiMw7KjBL2E9Hucxr/L8hXmb7PaZ
         08B/lrDyqOrHg3crBx2LRVVOeyj/No0+QVWD5a7sBFn9DnDcdGvKH+e97o2r8idQoYxi
         t2kw==
X-Received: by 10.50.73.74 with SMTP id j10mr1229156igv.50.1375936270758; Wed,
 07 Aug 2013 21:31:10 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Wed, 7 Aug 2013 21:30:30 -0700 (PDT)
In-Reply-To: <7vtxj1crv6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231860>

Junio C Hamano wrote:
> The only thing it does is to scratch an irrelevant itch by people
> who peek the codebase and find an old command whose existence does
> not even hurt them.  They may have too much time on their hand, but
> that is not an excuse to waste other people's time by adding extra
> makework on our plate, or changing the behaviour for people who use
> the command without explanation.

It's a maintenance burden that confuses users. I'd encourage you to
read git-whatchanged(1), and tell me why nobody has updated it.

We're not maintaining a museum.

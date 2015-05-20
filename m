From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Wed, 20 May 2015 10:13:36 +0200
Message-ID: <1432109616.18433.2.camel@kaarsemaker.net>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	 <5661061272076a1883cfde1087be4a42@www.dscho.org>
	 <xmqq617pda0r.fsf@gitster.dls.corp.google.com>
	 <6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
	 <CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
	 <1432070690.14498.4.camel@kaarsemaker.net>
	 <xmqqfv6s6ygb.fsf@gitster.dls.corp.google.com>
	 <xmqqzj4zomu6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 10:14:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuz8j-0007VI-MG
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 10:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbbETIOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 04:14:01 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35475 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbbETINj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 04:13:39 -0400
Received: by wicmx19 with SMTP id mx19so145374796wic.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 01:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=Jp/qyzseZ8fmW75einpG35acxX/YoTojtweJnACHKWU=;
        b=Jm1uXaQFUPQfZPa7pl/hvR2KQKYAbfCUGC7SGLOXxg9Em3t4+MuGGUwapmcyObknFz
         J/lN21W8aB+0a3/7c5w7+Jt3Fsr6LgQv2gJViMXwZiw/fdRj6aPRYVrJgUsSEH1nZfFm
         B1XJiGca9TWe7jTOR4Pt0U0hSS/aLk0H6nkBX0esgzWYKhXFRMmWtolbRj+x2n4Ie6oh
         rgnviU1uu0G7xTOlK8R5joH5MJz611hLBXz242/EHh3tmvVSQ0lN72hlD8osCqKk/7GW
         gHUS9wxFEAp5AOQmbafRwcGqKUHo/RZK1muUCez1Vris+wFeDR78tQgNbiMYk2fkCnq2
         I1jw==
X-Gm-Message-State: ALoCoQlPjsSGXFMcGqiJI0g/InavsGe8sl911YefD8jaQZj1MXcxdUZ9/jxjLjyQYfKUuqUzhEQ1
X-Received: by 10.180.219.42 with SMTP id pl10mr39585220wic.70.1432109618614;
        Wed, 20 May 2015 01:13:38 -0700 (PDT)
Received: from spirit.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id ha4sm2152877wib.0.2015.05.20.01.13.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 01:13:37 -0700 (PDT)
In-Reply-To: <xmqqzj4zomu6.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269450>

On di, 2015-05-19 at 22:10 -0700, Junio C Hamano wrote:
> Even if that were found to be useful, this discussion is only for
> step 1/N; let's refrain from rewriting everything for the sake of
> rewriting.  I do not think it would be a good use of developer time
> or reviewer time.

Agreed, and in combination with the very marginal (if any) time saving,
I'll just drop the whole thing.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net

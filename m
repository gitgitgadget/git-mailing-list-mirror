From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 09 May 2014 12:52:53 -0500
Message-ID: <536d15f512afd_a7adc530c31@nysa.notmuch>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <20140509055024.GB30674@dcvr.yhbt.net>
 <xmqqlhuazw2c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Martin Langhoff <martin@laptop.org>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 09 19:53:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wioyn-0000FM-UR
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756796AbaEIRxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:53:00 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:51285 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360AbaEIRw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:52:59 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so4030698yha.24
        for <git@vger.kernel.org>; Fri, 09 May 2014 10:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=D4bkDrGgOs84q4yb0kNu28PIa0wtUWbmTtJYkCLEeN4=;
        b=SxSoT6AnKgLp+5eRycxrPzvSeHnzjFyn2MzIZctJlHz8MINZTaWr3syElNjJSnRCUz
         0vePVYPfp5mdBeAtGOtl6Reu7Bgs1pslnSKbpqyKobImkDPppGftKwiNLpnqHy4xoAD5
         1lmS+OBUWMUWkubuplqYxkK/uVjE8lkj4UscPnlOWYS42yuPXoD6bCReb+Nqqq0QuDPO
         qPd8trKacQL24b7TI1jC+k61MeLPJF43xhwYxuH7xegnCLV5LRB5UxJHzDusY+bMaXhN
         de2aABpY3asSYHM/lCFWDoHv5JJu8T0OdeAk6nE2r7yOtVzMALiUbTKGOn3KAn5okrBB
         nHFQ==
X-Received: by 10.236.55.40 with SMTP id j28mr16758906yhc.85.1399657978856;
        Fri, 09 May 2014 10:52:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id a104sm7131914yhq.5.2014.05.09.10.52.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 10:52:56 -0700 (PDT)
In-Reply-To: <xmqqlhuazw2c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248599>

Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >> No updates since 2010, and no tests.
> >
> > Who benefits from this removal?  Is this causing a maintenance
> > burden for Junio?
> 
> No.  See http://thread.gmane.org/gmane.comp.version-control.git/248587

This has nothing to do with that thread.

This is a *CORE* tool, not part of contrib.

Core tools should have tests, shouldn't they?

In a previous thread you were worried that git-remote-hg might break
things because the Mercurial interface could change and break tests
(which WON'T HAPPEN). And here we have a tool which doesn't even have
tests.

So let's merge git-remote-hg without tests, that way the build cannot
break.

If an actively maintained, production-ready, well tested, and actively
used tool cannot get into the core, why is an unmaintained, no tested at
all, not actively used tool in the core?

And BTW, the argument John Keeping used for git-remote-hg doesn't apply
to git-remote-bzr where the API doesn't change at all.

Such incredible double standards.

-- 
Felipe Contreras

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] sha1_name: introduce getn_sha1() to take length
Date: Wed, 4 Apr 2012 15:53:21 -0500
Message-ID: <20120404205321.GA17985@burratino>
References: <1333029495-10034-1-git-send-email-artagnon@gmail.com>
 <1333029495-10034-2-git-send-email-artagnon@gmail.com>
 <20120403220817.GE19858@burratino>
 <CALkWK0nsO_xeuKpuPp0wvvbdhHnmKnX_JCPr6yapztC-Gq3Ljw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 22:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFXD0-0005w1-7l
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 22:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671Ab2DDUxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 16:53:34 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36356 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab2DDUxd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 16:53:33 -0400
Received: by ghrr11 with SMTP id r11so448116ghr.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YREPDHj1T2Opmkb8X6sfpzHgRkZMLbdyKbdXxJOCHNA=;
        b=LgnpelAOWNZlsd3QAUUtPHkAMm32c1PJUSNOA8yFxPkmtFfBuLObisSCqmksuLmgTP
         ldNXiCDe7oELSr8TxKMnpkgoIu5RYv97datLT8tK/Fg7AUmm8Y8motzkaTnp0Qodt5qm
         LJKQXoEa0oGh7t0JlVovjKlrgfa++E0fT66AKUTp/ZK+N1BrLyvliWam+CB97Xtr/2VY
         yaoyyCBSdQw7omo2sAlvQOfL0RJSqW1ZhFKG9YZkPxmp3tj8R4UmTW2kXl4pVCfNMB/O
         EzaWo9QewwOj/rHIoiuwNnlsnTqfa184Ln45MGTGB/HK412N7MH3rRA9ZWpFpSD3lmLq
         4t/g==
Received: by 10.60.169.174 with SMTP id af14mr26382993oec.13.1333572812750;
        Wed, 04 Apr 2012 13:53:32 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c6sm1500107oec.13.2012.04.04.13.53.30
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 13:53:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nsO_xeuKpuPp0wvvbdhHnmKnX_JCPr6yapztC-Gq3Ljw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194739>

Ramkumar Ramachandra wrote:

> Makes a lot of sense.

Ok, but please keep in mind Matthieu's advice about keeping
convenience wrappers convenient as well.  I trust him more in these
questions.

Thanks.
Jonathan

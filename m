From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] reflog: remove i18n legos in pruning message
Date: Thu, 31 May 2012 09:10:20 -0500
Message-ID: <20120531141020.GD10523@burratino>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com>
 <1338469482-30936-3-git-send-email-pclouds@gmail.com>
 <20120531134538.GA10523@burratino>
 <CACsJy8Bgzkc51N+t=0NyOasJRd2y3U+pyZCGa-qGoDuTQuyOgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 16:10:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa65E-0001Ma-Ps
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172Ab2EaOKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 10:10:33 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50643 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758091Ab2EaOKc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 10:10:32 -0400
Received: by yhmm54 with SMTP id m54so692313yhm.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=56IwHD+f3HKrVX18rMz19j7d/GgsFiUXs/gL4XeCCxc=;
        b=LnENTiUh10tALGvBQqhEEsH1+RRZseC6Be33w57uq11yPe4IK75G3a9jYBMSTIhtvP
         swyK70pEOYN16qBIomyVYof+al8tXQy5LrJPDJcN3ny+truxOswqxw9RgePJy2F2dBOK
         JutezJr/xnyAiJ0OlHRhtrRJPuzIi7Sns6MsHhiV+DJB4In+hs7JIeVzcEDmGlnlXsDw
         NZQz8m1lLXQRKI/hiVKM/960z5wISov3waecaLyzpPIErR1D4/23ubHFaFH2yKgcmNO9
         y4OKq+HWKmjrFnN/sBKGfnF6BK2QJs90NBdhTKMZ2+ZwZl7dR8gYnjdBjIUFT9+7ADvT
         I1OA==
Received: by 10.50.197.200 with SMTP id iw8mr14172700igc.18.1338473430134;
        Thu, 31 May 2012 07:10:30 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id v17sm2582138igv.7.2012.05.31.07.10.28
        (version=SSLv3 cipher=OTHER);
        Thu, 31 May 2012 07:10:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8Bgzkc51N+t=0NyOasJRd2y3U+pyZCGa-qGoDuTQuyOgg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198904>

Nguyen Thai Ngoc Duy wrote:

>                                                        Maybe adding
> --plumbing for scripts?

That wouldn't take care of existing scripts, and new scripts should
use LC_ALL=C to defend themselves when they don't want to be impacted
by i18n.

Do you have some other reason in mind that a script should choose to
pass --plumbing here?  Is it an output format flag specific to 'git
reflog expire', in the spirit of status --porcelain, or a more generic
"I care about output stability" flag that spans multiple commands?

Jonathan

From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: [PATCH/RFC] Encapsulating isatty(2) calls into new
 progress_is_desired()
Date: Thu, 30 Jun 2011 22:41:21 +0200
Message-ID: <20110630204121.GB63317@sherwood.local>
References: <3d6b6818cfc542a3acf7a7a43ac6842fd74ddcee.1309342095.git.sdaoden@gmail.com>
 <7vboxgrzwt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 22:41:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcO3N-0004O1-9h
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 22:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab1F3Ulb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 16:41:31 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:59017 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab1F3Ula (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 16:41:30 -0400
Received: by fxd18 with SMTP id 18so2606092fxd.11
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KfpQq2dWvvBzPZgsZSLYbaURiGjVt4NBVWnw1RlUr2A=;
        b=qUUW4RWqVfW07dJYMnHcAdXTmfXSiCHs7aY57pDGpJDbvLyf95FWGWpW7gmmvuRSBJ
         Of+pS7eat6WDcYmK9+xVkoTTK9kekmcPWS7F8AxGY2UgvN0Ezj6P+CuItP3Khs8QrTcs
         OfftsC6B3PiW/8qMSInm/opMaAIYCz8JK796E=
Received: by 10.223.23.143 with SMTP id r15mr3592046fab.29.1309466489217;
        Thu, 30 Jun 2011 13:41:29 -0700 (PDT)
Received: from sherwood.local ([82.113.99.168])
        by mx.google.com with ESMTPS id 7sm1868110fat.18.2011.06.30.13.41.26
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 13:41:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vboxgrzwt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176508>

@ Junio C Hamano <gitster@pobox.com> wrote (2011-06-30 01:17+0200):
> Two comments, and perhaps a half.

Git looks pretty transparent through your eyes, so thanks for your
mail.  I really have appreciated to read it.
(The very idea itself is a shallow no-go that way.)

--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments

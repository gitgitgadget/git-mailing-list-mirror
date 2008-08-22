From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v4] gitweb: ref markers link to named shortlogs
Date: Fri, 22 Aug 2008 15:20:31 +0200
Message-ID: <cb7bb73a0808220620m10245693pabe49993e91cff3d@mail.gmail.com>
References: <200808221256.21805.jnareb@gmail.com>
	 <1219408777-13513-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200808221501.54908.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 15:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWWa9-0006Qd-VC
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 15:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbYHVNUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 09:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbYHVNUd
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 09:20:33 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:43936 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbYHVNUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 09:20:32 -0400
Received: by gxk9 with SMTP id 9so1102037gxk.13
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1ifhvwgQYCDVtEvXXD0KScQ8ECsntOf8Utgvr6Y/nTw=;
        b=AbSIvHfmK+lGgpP8NiZaGPGqVIIeN8ec6h69W6RHOaXjStWjyUiGvkRhjPZQ248ucf
         CNH0AQLTICOQtxVhDkw/aUGndV2nSeEEHfCXoRQRFzlZUGP8dKg6Na23c97iM831+kNa
         aXYwG9c6mUCIwdGbePbCfvIgmGZkj5BE6B6Og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bHcXasU1Go2YH/g3YHtSmD0+D/fSdzzUjuuZHzNz6LlfZfHW3O903n/uNmxqkF7+ZO
         pecMFiCvLiBnqJ986/onANzjQIRCGzwDIEFZpy3YcJT/ko5qLHHIrqoZqOPyM13A0VjP
         mJnPuzZij+2zM/Bd20P5S3x3DbB2ceYl7UfpI=
Received: by 10.151.98.16 with SMTP id a16mr1795480ybm.202.1219411231740;
        Fri, 22 Aug 2008 06:20:31 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Fri, 22 Aug 2008 06:20:31 -0700 (PDT)
In-Reply-To: <200808221501.54908.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93292>

On Fri, Aug 22, 2008 at 3:01 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> Seems overly complicated.  How about something like this, instead?
> It simply moves stripping ^{} from refs to format_ref_marker(),
> and uses "tags/v1.5.0^{}" instead of [ "tags/v1.5.0", 1 ].

My thought was that if the refs stuff was being used for something
else than format_ref_marker, it would fail more spectacularly due to
the different kind of values, rather than introducing potentially
subtle bugs due to the additiona ^{} popping in unexpectedly, but it
wouldn't be a problem to do it the simple way. Let me clean the patch
up and resubmit it.

-- 
Giuseppe "Oblomov" Bilotta

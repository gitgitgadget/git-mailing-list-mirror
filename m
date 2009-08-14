From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 0/2] add a --delete option to git push
Date: Fri, 14 Aug 2009 10:50:54 +0200
Message-ID: <200908141050.56900.jnareb@gmail.com>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 10:53:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbsVi-0000La-7g
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 10:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbZHNIvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 04:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbZHNIvF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 04:51:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:41024 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbZHNIvD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 04:51:03 -0400
Received: by fg-out-1718.google.com with SMTP id e21so307653fga.17
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vJwodEzOJ1qAhFscjfzhIoiO9HdEzfJfL2whYU9PEKE=;
        b=D/BIcuWSsonJwvSrYd7KXqKC9BNaMkeLWSK+Z0vglSEyh0vVf+LDRHuzqmRC9Xmk7A
         84OTVLGhGC7dNhHkNfbtuwWSDQqwXa6bGtQpk9nPe/QAaTokbmKgPwSrbFwZ6WHOOepT
         gaNrMLbnbqq+HQRBQD4N7iSO3QzzWUTqO3GOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vwm39Z6Bj8tlf3FwmwLx2IVCmMXPS+0/ADow36hJgYrQOHSrh1nk11F+TYNrw22zB/
         JPC1g3tlZ/QNVeL/rOtOcxhRxU6Nm0LuCxJgNvzWhngGppDT7uVerW/8qjPsL4PnjkPn
         R0HsW5ySEyEeTrgWUxG7ywZIdeVHBwzsN59bk=
Received: by 10.86.60.9 with SMTP id i9mr1198088fga.10.1250239863376;
        Fri, 14 Aug 2009 01:51:03 -0700 (PDT)
Received: from ?192.168.1.13? (abwe173.neoplus.adsl.tpnet.pl [83.8.228.173])
        by mx.google.com with ESMTPS id 4sm936386fge.21.2009.08.14.01.51.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Aug 2009 01:51:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125919>

On Fri, 14 August 2009, Sverre Rabbelier wrote:

> This is in reply to a brief conversation I had with jnareb on #git
> about the blogpost "5 things git could learn from hg", or something
> like that (can't find it right now).

Thanks.

It was "Five Features from Mercurial That Would Make Git Suck Less"
http://nubyonrails.com/articles/five-features-from-mercurial-that-would-make-git-suck-less

Those five features were:
1. "<scm> init <directory>" (done)
2. "hg commit --close-branch" vs slightly cryptic 
   "git push origin :refs/heads/feature-tweak", which can be written
   simply as "git push origin :feature-tweak" I think.
   (that is what this patch series is about)
3. Numeric local references, e.g. 18:a432bc and "hg checkout 18"...
   but more realistic example would be "hg checkout 6324" :-P
4. sensible defaults: meaning of revert, staging area (i.e. commit -a)
5. "hg serve" (gitweb and a kind of git-daemon equivalent)

See the alleged blog for details (I call it 'alleged blog' because real 
blog has comments which work, and are shown soon after posting them).

-- 
Jakub Narebski
Poland

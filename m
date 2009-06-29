From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 0/9] gitweb: avatar support
Date: Mon, 29 Jun 2009 23:37:17 +0200
Message-ID: <200906292337.18636.jnareb@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 23:37:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLOXd-00056D-6Z
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 23:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716AbZF2VhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 17:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbZF2VhW
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 17:37:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:57941 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbZF2VhW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 17:37:22 -0400
Received: by fg-out-1718.google.com with SMTP id e21so995368fga.17
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HfShUsD5xfWrufLWNnZrxKMNgk+wNfQAhHUMN+vR1NI=;
        b=Cgrkf6fyklnCsXIIHF5n7UaLc8d5w2B/7+xjgz8CO3+yZCLVVzK8fQInBEORIV5+fz
         Gyvlp51pH4xrgLNUAQEes/io5uHqI5hzhkN5j30CGQotWf4ioKLLfrS+YO4iW2QoMiiy
         mIUdGuUJmEaCMV19r7OKQxk8L1fqgKYcChRIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GmpGI3duKnoP3K6np9pLcRQoRGtBjbIcgpwky9gI9dNCH90XDIvlFtaLshfmpH/b1S
         LmOfSYCIoph2OstGodKbtTcoDHFYhNzZj1E9/AjKsViMfJ8cyRgv3o+SLjCYkRt+q+0B
         GFM2kkqJnZEaHMYGqcP3LmbVL4gbX53oFTxLA=
Received: by 10.86.83.17 with SMTP id g17mr2415771fgb.25.1246311444330;
        Mon, 29 Jun 2009 14:37:24 -0700 (PDT)
Received: from ?192.168.1.13? (abvw77.neoplus.adsl.tpnet.pl [83.8.220.77])
        by mx.google.com with ESMTPS id 4sm7029778fge.23.2009.06.29.14.37.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 14:37:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122464>

On Sat, 27 Jun 2009, Giuseppe Bilotta wrote:
> One more attempt at adding avatar support to gitweb.
> 
> The most significant change since the previous iteration is the addition
> of a picon provider, and its use as default from gravatar.
> 
> Most other patches were changed to follow Jakub's suggestions. In
> particular, the two-line author/committer information was refactored
> to reduce code duplication, with the benefit that it could also be used
> in 'tag' view.
> 
> Giuseppe Bilotta (9):
>   gitweb: refactor author name insertion
>   gitweb: uniform author info for commit and commitdiff
>   gitweb: use git_print_authorship_rows in 'tag' view too
>   gitweb: right-align date cell in shortlog
>   gitweb: (gr)avatar support
>   gitweb: gravatar url cache
>   gitweb: picon avatar provider
>   gitweb: use picon for gravatar fallback
>   gitweb: add alt text to avatar img

I think this patch series shapes very nicely.  A bit of refactoring 
upfront, so that the following patches are not very large, and don't
need to repeat the same code in many places.  Separate issues such 
as right-align date cell, or making 'commitdiff' view use authorship
info layout from 'commit' view are put in separate patches in such
way that they can be accepted or rejected individually.

Very good work!

-- 
Jakub Narebski
Poland

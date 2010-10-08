From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri, 8 Oct 2010 12:09:39 -0500
Message-ID: <20101008170939.GG9212@burratino>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
 <20101008081509.GA2845@kytes>
 <4CAED762.7040708@gmail.com>
 <74AF320B-5D82-4622-A7BF-61C847D4059A@cordelta.com>
 <AANLkTi=zS+oj1iHMh-gKVD=2dG5tLwA+bia9E6U3o=zW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <david.barr@cordelta.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 19:13:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4GVE-000274-EG
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 19:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490Ab0JHRMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 13:12:55 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50854 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345Ab0JHRMy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 13:12:54 -0400
Received: by qwf7 with SMTP id 7so772285qwf.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YphYjosaXNQJtRy+Pf8vioNve34l+2oMAeK0fgKFydU=;
        b=j2u/rcP5Qiuop1VVJikHI5B9PDcWa2P1EOKJObIDP0KScN4BF8Z5IJlsNDhrBv+aes
         w0DojnrCl1HYlpt/jG0PkBOaGzLm9SeMNizShTYX+RRDhz+2YVTC3+SlqU5l7ruezq8Q
         eIsJatkJAu/2c4AQ5XQLqinP5zwpKNhSH2w8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KM6hQjqVSx+ShI5z736mBJs0ABj8iIe1IKd8Z70j1RlZpvE981diKlcYgGsiYj1Aoa
         CYVKibBoDLN4UGGf32WSEPwQa5zQzkWGGZFopkYD17WUtMsticSey7L8VvjdL6n/jg9l
         jxyEJgidlF2PeeR/TBKl4V75w1IQ9ds2xOY4g=
Received: by 10.229.37.83 with SMTP id w19mr2241403qcd.185.1286557970438;
        Fri, 08 Oct 2010 10:12:50 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id l14sm470135qck.29.2010.10.08.10.12.47
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 10:12:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=zS+oj1iHMh-gKVD=2dG5tLwA+bia9E6U3o=zW@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158507>

Sverre Rabbelier wrote:

> So, are other trees allowed too? Can I set the contents of directory
> "foo/bar/baz/" to an existing tree?

Yep, ever since v1.7.3-rc0~75^2 (Teach fast-import to import
subtrees named by tree id, 2010-06-30).

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Tue, 12 Oct 2010 21:40:34 -0500
Message-ID: <20101013024034.GA26483@burratino>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org>
 <AANLkTimkBsTN-gJ5Wwe_Y=UxSpSpYhn8HcZyUDGngLPn@mail.gmail.com>
 <F06C63D1-26AE-4278-96CE-2F6B2D6DD300@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 04:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5rK2-0000ta-Hy
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 04:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab0JMCn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 22:43:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38362 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab0JMCn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 22:43:57 -0400
Received: by gwj17 with SMTP id 17so1676133gwj.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 19:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eZcoNRAqvb9yoyrFva7j4Z5SSDu3LF6RJsrvMzYq9s8=;
        b=iv4QFuHajwxwUDwzPkPZbHzEZEC9HKJ7hEi52Po3D1/z56LIgpe2OCk/l/37jWBefg
         TNZ41Izh3R7jslmjK+KyzmeyzTH3D5uaKX1f8Y58UtHoXtXZXROjsEQJEwQlbxbRbsSz
         WoGQSz5M3WWjw1nto1lLIX7mbTb7rRnmMyvqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Xk0iRqCH3x2+itasG5z6hFYlt9j1d7i8GOPFWjJB/Sg3E7DA8AhkmXwZp4SomDGhD3
         g3ZHEN/t4L7M2ie09hXJNnx2SmdSu+MEkEuC/F2N2zm6Z1c1zHnlyRaZGE2XB9kSyK2N
         vXtd2mHTIzsprDK7DiSel/geTxFPmpIUg1GSI=
Received: by 10.151.11.6 with SMTP id o6mr137035ybi.145.1286937836519;
        Tue, 12 Oct 2010 19:43:56 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q34sm7520278yba.22.2010.10.12.19.43.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 19:43:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <F06C63D1-26AE-4278-96CE-2F6B2D6DD300@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158907>

Kevin Ballard wrote:
> On Oct 12, 2010, at 7:24 PM, Nguyen Thai Ngoc Duy wrote:

>> Special case "**/" (also "path/to/**/") is probably good enough. You
>> might need to handle all combinations of "**/" and other optimizations
>> in excluded_from_list() though. Can you make a patch (or a few
>> patches) for it?
[...]
>                                                                  At
> this point I'm actually in favor of simply assuming all paths that
> don't start with / can be matched at any level

As a long-term change with early warnings and proper deprecation
procedure that may (or may not) be an ok idea, but in the short
term it is certainly a no-go.

If linux-2.6 is any indication of what to expect, some projects are
not using / in front of any paths with / at all.

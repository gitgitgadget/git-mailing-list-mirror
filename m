From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Stgit - gitmergeonefile.py: handle removal vs. changes
Date: Mon, 21 Nov 2005 21:32:40 +0000
Message-ID: <b0943d9e0511211332h41e3850dt@mail.gmail.com>
References: <20051113194225.20447.57910.stgit@zion.home.lan>
	 <b0943d9e0511150154y2d2af24ck@mail.gmail.com>
	 <200511161544.13825.blaisorblade@yahoo.it>
	 <b0943d9e0511171410y357fb0bfv@mail.gmail.com>
	 <437D0949.3060505@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Blaisorblade <blaisorblade@yahoo.it>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 22:34:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJHJ-0006Yq-2M
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVKUVcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbVKUVcm
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:32:42 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:313 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750855AbVKUVcl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 16:32:41 -0500
Received: by xproxy.gmail.com with SMTP id i30so734066wxd
        for <git@vger.kernel.org>; Mon, 21 Nov 2005 13:32:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FpHSpEyr76YosbpS6JjjEp/iIXlGXtfZD1MOxPlz2Y9H6R8vqknynK+g79S39FV8fe/y+xDQfsq2g8qt9CtjUEh8z/+znjznq4j0dOmfiNl2Al/RcS9t2mL3ewv0qNyAgAHyVEUtSQ05hTopLSEUz0ulT05Us+/DOOFnRc/FfB0=
Received: by 10.70.63.14 with SMTP id l14mr2673663wxa;
        Mon, 21 Nov 2005 13:32:40 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Mon, 21 Nov 2005 13:32:40 -0800 (PST)
To: cel@citi.umich.edu
In-Reply-To: <437D0949.3060505@citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12485>

On 17/11/05, Chuck Lever <cel@citi.umich.edu> wrote:
> i use "original" "patch" and "older" (set up in .stgitrc) because i
> found the default labels to be confusing.
>
> but "original" "patch" and "upstream" make sense to me.

These names would need to have a meaning for the result of the 'fold
--threeway' and 'pick' commands. 'patch' and 'original' are ok but
'upstream' might not make sense since for these commands it can
represent the top of an existing patch.

--
Catalin

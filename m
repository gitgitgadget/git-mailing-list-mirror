From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git commands that only work correctly at top directory
Date: Fri, 22 Sep 2006 19:57:33 +0700
Message-ID: <fcaeb9bf0609220557m7802a446nd47a9560c6977b31@mail.gmail.com>
References: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
	 <20060922112615.GB10124@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 22 14:58:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQkbL-0001Sg-7C
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 14:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWIVM5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 08:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWIVM5e
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 08:57:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:7015 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932390AbWIVM5e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 08:57:34 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1017609wxc
        for <git@vger.kernel.org>; Fri, 22 Sep 2006 05:57:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pMkTvYh+IwS53N+wfKvRgaCMuusHZ0tBz73CqiiBtPeXtxFSLBqvCoc2mJZ3U+jSTtNoUIbHYgxpaIv0C0fybmUhmI4zCFrcPfawBogVymrmjtjKj5QJ5Y47WkiHlD1UC9EmJHC0NP1G/oo3Zw1In0p+FSXHBfY5EZRV82S1t+g=
Received: by 10.70.125.2 with SMTP id x2mr983765wxc;
        Fri, 22 Sep 2006 05:57:33 -0700 (PDT)
Received: by 10.70.45.19 with HTTP; Fri, 22 Sep 2006 05:57:33 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20060922112615.GB10124@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27528>

On 9/22/06, Matthias Lederhofer <matled@gmx.net> wrote:
> count-objects and describe work in the current master.
Yes. Somehow my master is not updated to origin :(

> repack/bisect/reset and some other commands make only sense from the
> toplevel directory but anyway I would allow them to be run in a
> subdirectory and change up to the topdirectory (like git checkout for
> branch switching).  Is there any good reason not to do this?  I found
> it often annoying to go down to the toplevel directory/get a new shell
> just to reset to HEAD~1.
In case there is good reason not to do it, I'd like those commands to
tell users run them in top directory. (Although I prefer to run it
everywhere, I hate to cd around just for one command)
-- 
Duy

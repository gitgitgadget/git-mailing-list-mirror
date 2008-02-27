From: =?ISO-8859-1?Q?Gabriel_Salda=F1a?= <gsaldana@gmail.com>
Subject: Re: msgmft segfaulting on tiger
Date: Wed, 27 Feb 2008 12:18:28 -0600
Message-ID: <47C5A974.7080207@gmail.com>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>	 <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>	 <20080222065836.GE8410@spearce.org> <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 19:16:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUQpW-0001D5-EA
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbYB0SQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818AbYB0SP7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:15:59 -0500
Received: from el-out-1112.google.com ([209.85.162.179]:19389 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbYB0SP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:15:59 -0500
Received: by el-out-1112.google.com with SMTP id v27so2561654ele.23
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=3inLsVNWDYlYoxZLrw3GWQ6juc9v5+DtP/BgPOHuNT8=;
        b=OOYfMDZeqG64vnAdlHH/nPhWcRPejo8reO+nHzryFKFqCHAN8gGSFQk5VRS2r1uRlhaqxr+a5yeyT1ByJJ08jABfonB4RCeCoxocup9kbvbVzoPbDNHkk666HPOCDnCANtzlaNN6XF8ltK7TiDYKlcAVOly2LrU2qXw5BFnnc3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=LhM8SWdnqwVGr8xFPUJIlm0HJ49XU/JclCKK2ZYp5wk1SVU+F3juIhN/Js7goV16dEBxSOoL1/mir9DoTYs/KzaK0g2kSG/D6Ll8CPyYFCOqP249VKL2ZrVdOfOFRwXZ0xyBW5WKToVAb9khD9iWfKKvAEtdPkXoDVXzLp2vy6U=
Received: by 10.115.58.1 with SMTP id l1mr7811235wak.110.1204136156628;
        Wed, 27 Feb 2008 10:15:56 -0800 (PST)
Received: from ?192.168.0.121? ( [189.152.130.115])
        by mx.google.com with ESMTPS id y11sm13667939pod.9.2008.02.27.10.15.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Feb 2008 10:15:55 -0800 (PST)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75242>

We tried to build with make V=1 and this was the output:

msgfmt --statistics --tcl -l de -d po/ po/de.po 
msgfmt: unrecognized option `--tcl'
Try `msgfmt --help' for more information.
make[1]: *** [po/de.msg] Error 1
make: *** [all] Error 2

Still the error is in the po/de.po file

Hope this info helps

Gabriel Saldana

Martin Langhoff wrote:
> On Fri, Feb 22, 2008 at 7:58 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>>  Did you try building with `make V=1` to look at the full output and
>>  not the prettied up simplified output the Makefile uses by default?
>>  It won't fix your issue but it may be interesting to see if msgfmt
>>  is failing with a particular message or not.
> 
> I'll track down Basilio (it's his laptop) today and try, I think he's
> still at the conference. I also suspect that OSX's own build tools may
> include a different msgfmt, but the fink one is earlier in the path.
> 
> cheers,
> 
> 
> 
> m
> 

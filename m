From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 09:23:53 +0200
Message-ID: <CAHGBnuNFW7HCC2U418TC11CKqbB66EtXV_SOs7w0p5RcqAPuLw@mail.gmail.com>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
	<535572b73183b_414c80b30863@nysa.notmuch>
	<CAHGBnuM3TVMbow7Zbb9QnEeJOR9aZY1dwj2CWqs-Ti_HDppE1w@mail.gmail.com>
	<20140421204506.GD5105@thunk.org>
	<535583c0caa69_5c94d452ec6c@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:24:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcV3g-0000h4-2V
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 09:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbaDVHXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 03:23:55 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:52453 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbaDVHXx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 03:23:53 -0400
Received: by mail-yh0-f41.google.com with SMTP id i57so4526771yha.28
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DC2EsPGOtR9rf9yI3rwkq8yXnXyW68iQGisO0iNqq0U=;
        b=N19kf9xBu7WSXOFUuOwPcW0Qp/5tQ4XvKBGUpfJ5YFSjkSiuC9GAgXSnjMbGUDkQLl
         VzYfiPpF+hipwThsxtIYK5bIfvlBHvX4LOhAmcX311mRd5AMsD4RiwFFGiBjbVV0YD/N
         KUofq/UkSPT7+JB9M6UAazJB4ZznTznsHQ0kK+8eUiBstKDOs/rO+5FayOzcst2sF3la
         cfnj0yvWNrJuMzTvEf17fZKm0gjVjrRX/VUQmKAFj3IAPyTEcLpQIDtcrW174tOn0NXx
         YlwleJO0LFDB2AgNuUPxynl2m6XPnVP+YQdci3qtPFlichZlqr+AbYpGI2mRadcpAbuJ
         pu8Q==
X-Received: by 10.236.41.165 with SMTP id h25mr646772yhb.126.1398151433079;
 Tue, 22 Apr 2014 00:23:53 -0700 (PDT)
Received: by 10.170.151.10 with HTTP; Tue, 22 Apr 2014 00:23:53 -0700 (PDT)
In-Reply-To: <535583c0caa69_5c94d452ec6c@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246709>

On Mon, Apr 21, 2014 at 10:46 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

>> The problem is that between "git rm" and "git mv", if we default "git
>> cp" to mean "cherry-pick" there could easily be user confusion.
>>
>> I'm not sure that cherry-pick is used that often it really needs a two
>> character shortcut.  Maybe just "git pick"?
>
> I'm in favor of having both 'git pick', and 'git pi'.

Please let's stick to one clear default alias for some central
commands, and not introduce ambiguity between aliases. That said, I'd
prefer pick over pi, but still cp would be my personal favorite.

-- 
Sebastian Schuberth

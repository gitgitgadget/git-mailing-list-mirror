From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: build deps
Date: Mon, 15 Oct 2012 14:51:13 -0300
Message-ID: <CACnwZYdpuju4VtvRxNDRSTwnCCFYK4j_f=h9eCoLPBWHKF7LsA@mail.gmail.com>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com>
	<5072FAD1.1000807@gmail.com>
	<CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com>
	<50735939.10604@gmail.com>
	<CACnwZYf56XkqW085HoWhAN2EnjCJd=VYHGAD8fZCCe6_FNhO2A@mail.gmail.com>
	<50776D0D.9090306@gmail.com>
	<CACnwZYfmz1BTo6okzFh8jXbw+0MAV0sEanYXNzAnV7L4p7nY_g@mail.gmail.com>
	<507C2F6E.9060100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Wong <andrew.kw.w.lists@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 19:51:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNop3-0004tN-PC
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 19:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab2JORvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 13:51:15 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:58014 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab2JORvO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 13:51:14 -0400
Received: by mail-wg0-f42.google.com with SMTP id fm10so55815wgb.1
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UoMuHDXznhvN344wehMl2Sx2EHKiJh0Y7otjG7Uk2CY=;
        b=d0m0v6QzZT8FnVRomV4/F1B9UiWXCHk21cBy1iVuCmjjDXWbTXtUKi2xm5i2n768nd
         gSnoZSp/bikJxbrpREGAUwJiFGduUyPfFzBtE6K3lT0GVR0cqmeNzhqwwTjOA4QQwkq3
         mU6GT7uJD4+4/J1V41vKh3v9O4vvEcbIcLieHg4vHlLwC2qKw1PwXZa1R8YrB/QhM6qO
         52I5Ls93R5hw0Ek4wfhfrKUDhv5XmKbnha7RyCW0/+F/VTGjqjj4wWBNpxcJY0wKWyF5
         nykILzk31N7y4uz0Rrx26d5QHOoRM5cjFmraIdJNenphFImy+jEUpkvtMnV3j27UQdMJ
         5XWA==
Received: by 10.180.80.104 with SMTP id q8mr25492100wix.6.1350323473407; Mon,
 15 Oct 2012 10:51:13 -0700 (PDT)
Received: by 10.194.19.166 with HTTP; Mon, 15 Oct 2012 10:51:13 -0700 (PDT)
In-Reply-To: <507C2F6E.9060100@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207768>

On Mon, Oct 15, 2012 at 12:44 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>> clang reported this:
>> combine-diff.c:1006:19: warning: adding 'int' to a string does not
>> append to the string [-Wstring-plus-int]
>>                 prefix = COLONS + offset;
>>                          ~~~~~~~^~~~~~~~
>> combine-diff.c:1006:19: note: use array indexing to silence this
>> warning
>>                 prefix = COLONS + offset;
>>                                 ^
>>                          &      [       ]
>> 1 warning generated.
>
> Does
>
> &COLONS[offset]
>
> silence that?
>
Yes.

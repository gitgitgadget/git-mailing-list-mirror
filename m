From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 08:32:20 -0700 (PDT)
Message-ID: <m363sdqrk0.fsf@localhost.localdomain>
References: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com>
	<6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com>
	<20080613142118.GA20027@bit.office.eurotux.com>
	<6dbd4d000806130739r633cb34cx9edbe48724d6a325@mail.gmail.com>
	<20080613151307.GA21917@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Denis Bueno <dbueno@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 17:33:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7BHE-0000AT-FZ
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 17:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926AbYFMPc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 11:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756354AbYFMPc0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 11:32:26 -0400
Received: from hu-out-0506.google.com ([72.14.214.231]:62825 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694AbYFMPcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 11:32:25 -0400
Received: by hu-out-0506.google.com with SMTP id 28so5379204hub.21
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 08:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=CmpSDejItSqgZdqlshVWzRFTg3e2WEflH3Khs6RvSdg=;
        b=Lb307mar2rpyPrKVeHFUWRCUUBVYVV9XhOTzTxqbul3NBVEQxMTwVhpxqZ/pRcoeUs
         sx3SHdsWKXd9TB270rp1y0LkPOPWerx+lv1aum7EXUX8XCmYcAx6DdlUa2E/rI7vHD+q
         iPJHFFjkuDAVhqGjfFLywOPmpUSYP6Q4GyQSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=QBvzYfw8HWVXd25grM6ATAtzBUJXqd3oVeKc3gUeZqiiA+stTR9F5FwX6evBxjpuCw
         f9jcbP2W4vUUPFSV8Z2oveGiRqHGlgDI9lHL2I7PukK5JIDn+iB7a/CX9hEDra9Iw9Ev
         e45Fuu8ZBZA02QZweSjTE5uvATwCL/WLqVXIw=
Received: by 10.66.245.2 with SMTP id s2mr1186311ugh.23.1213371141289;
        Fri, 13 Jun 2008 08:32:21 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.221.64])
        by mx.google.com with ESMTPS id i39sm1641259ugd.28.2008.06.13.08.32.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 08:32:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5DFWGTw009849;
	Fri, 13 Jun 2008 17:32:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5DFWFAp009846;
	Fri, 13 Jun 2008 17:32:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080613151307.GA21917@bit.office.eurotux.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84891>

Luciano Rocha <luciano@eurotux.com> writes:
> On Fri, Jun 13, 2008 at 10:39:11AM -0400, Denis Bueno wrote:
>> On Fri, Jun 13, 2008 at 10:21, Luciano Rocha <luciano@eurotux.com> wrote:
>>>
>>> Try changing the following line instead:
>>>        "$PERL" -p -e "$script" "$1.tmp" > "$1"
>>> to
>>>        $PERL -p -e "$script" "$1.tmp" > "$1"
>>>
>>> about line 6121 of the git-instaweb script.
>> 
>> This is line 6033 for me; however, this change makes it work!  (I
>> verified my changing this line; trying it; then changing it back to
>> the double-quotes version, and verifying it breaks.)
>> 
>> Why?
> 
> "$PERL" means the content of the variable is used as the command to
> execute.
> 
> $PERL, on the other hand, goes through a round of word splitting, that
> in your case results in the command "/usr/bin/env", with the arguments
> "perl", "-p", ...
> 
> Thus, if it is possible to use /usr/bin/env, the current "$PERL"
> incantation is incorrect.

The problem is with trying to ensure that both

   /path/with spaces/perl

and

   /usr/bin/env perl

work, as they require different rules wrt. splitting on whitespace...

-- 
Jakub Narebski
Poland
ShadeHawk on #git

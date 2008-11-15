From: "Pau Garcia i Quiles" <pgquiles@elpauer.org>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 12:33:10 +0100
Message-ID: <3af572ac0811150333p28546975m9cf3ad73e62eb97@mail.gmail.com>
References: <491DE6CC.6060201@op5.se>
	 <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org>
	 <491EA1CC.9020605@op5.se>
	 <3af572ac0811150228k291b8850idc34cb474f455aa7@mail.gmail.com>
	 <491EACFA.9040604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 15 12:34:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1JQ4-0006Cs-ME
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 12:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbYKOLdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 06:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754258AbYKOLdM
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 06:33:12 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:33871 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbYKOLdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 06:33:12 -0500
Received: by gxk4 with SMTP id 4so999508gxk.13
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 03:33:10 -0800 (PST)
Received: by 10.65.59.16 with SMTP id m16mr1950137qbk.1.1226748790382;
        Sat, 15 Nov 2008 03:33:10 -0800 (PST)
Received: by 10.64.203.1 with HTTP; Sat, 15 Nov 2008 03:33:10 -0800 (PST)
In-Reply-To: <491EACFA.9040604@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101059>

On Sat, Nov 15, 2008 at 12:05 PM, Andreas Ericsson <ae@op5.se> wrote:

>> Do you mean if I write a patch to libgit2, send it upstream and make
>> it public on my website but it is not accepted upstream, I cannot link
>> my modified libgit2 version (i. e. libgit2 + my patch) to my non-GPL
>> software?
>
> I think that's the case, yes.
>
>> It looks insane to me: I wrote the patch and made it public
>> but you guys did not accept it!
>>
>
> Well, if you wrote a patch that uses a closed-source database library
> to store git objects in, how would that benefit the community even if
> you published the patch?

The case I had in mind is not that but this: say I write a patch which
is totally open-source and uses only open-source software to add some
feature to libgit2 but I want to link that libgit2 + mypatch to a
closed source application (say, for instance, software for military
use, which I'm not allowed to open source). To state it clearly:
- My contribution is 100% open source
- My contribution is 100% towards libgit2
- In fact, I could add that very feature to my application instead of
libgit2 but as I'm open-source-friendly, I decide to contribute that
patch to libgit2.

For some reason, that patch:
- Is not accepted for some time (for instance, I'm thinking in that
tcl/tk limitation which is preventing Junio from merging a patch, it's
been in the "what's cooking" for some weeks now)
- Or is not accepted at all

According to what you said, I only have two options:
- Either I fork libgit2, or
- I keep my feature in my application and do not contribute my feature
to libgit2

It looks even more insane now!

What about rephrasing the libgcc exception to something like: "if you
have a patch, and sent us that patch, but we put the patch in stand-by
or declided the patch, you are still allowed to combine libgit2 with
your closed-source application". After all, the fault is not in the
closed-source part (I contributed the patch, it is 100% open-source
and only uses 100% open-source) but in the libgit2 part (patch is on
hold or not accepted at all).

--
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)

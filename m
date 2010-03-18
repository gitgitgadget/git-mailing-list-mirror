From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 17:55:08 -0400
Message-ID: <46a038f91003181455u7136e011u5352c996384f086d@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 
	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com> 
	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com> 
	<b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com> 
	<46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com> 
	<b4087cc51003181446r6bd89371q9f2e7a14bfa4d557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: tytso@mit.edu, Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 23:18:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsO39-0000X8-6V
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 23:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450Ab0CRWSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 18:18:34 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39875 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab0CRWSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 18:18:33 -0400
Received: by gyg8 with SMTP id 8so1245649gyg.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 15:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=R7vpZbKJw2hB2HtAfDpyx/ZzpUCSYaIIic/sre4CPg4=;
        b=xXWvZvMWB0NP/9pqGGqUYypdivIZeGm8kKVnWalAOJQDgcuqTbp7BBcJuzYYb7MKqh
         5RS1NWVBVaUCkYEi4tdMgS6TucAlMdb7ikxTYgR7O4rU8Uwu+GFL+rP6GuieOdOpiDPU
         v03nBqlkri/dA+2vjs5M6tNwNP1MIra/Md4H4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lPkuMjN4rLKwYFHZJ129hmFNK+IK7kbTd8R+jcByioZLCzhe1vjsh9Q1Y1UgpqGp7Y
         2s6mMXfSiY/YVvw8VzGG29lcVgYXLMz44ZpZEP74j+AXet87BYEw1QJGelDWCVUbU8Lg
         V89XOxWZWbR2k3/eXSMObjQwNccaz7uh+a7NQ=
Received: by 10.101.8.37 with SMTP id l37mr5184953ani.233.1268949328082; Thu, 
	18 Mar 2010 14:55:28 -0700 (PDT)
In-Reply-To: <b4087cc51003181446r6bd89371q9f2e7a14bfa4d557@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142531>

On Thu, Mar 18, 2010 at 5:46 PM, Michael Witten <mfwitten@gmail.com> wrote:
>> What should we do in that case? Use mailmap to map the stray uuid to
>> the "real" one?... Have we done a lot of work to get back to square 0?
>
> Again:
>
>>> At worst, things will be just like they have always been.

Of course we all read that line. You are proposing a change that will
mean a flag day -- that is, old versions of git won't be able to read
"new" repositories (and "new" git will have to be backwards compat for
X releases...). This is major breakage.

Inflict a painful change on our userbase for... what exactly? Ah, "At
worst, things will be just like they have always been."

I don't think you understand what you've been proposing.

Is it clearer now why you get a clear "no" from all quarters? Huge
cost, no upside?



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff

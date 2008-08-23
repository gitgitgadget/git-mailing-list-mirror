From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 22:39:21 +0030
Message-ID: <4d8e3fd30808231509x6be6f83dyf5d53ebda8ab9424@mail.gmail.com>
References: <20080822174655.GP23334@one.firstfloor.org>
	 <m37ia8sv49.fsf@localhost.localdomain>
	 <20080823071552.GU23334@one.firstfloor.org>
	 <200808231121.41694.jnareb@gmail.com>
	 <20080823165350.GY23334@one.firstfloor.org>
	 <4d8e3fd30808231404y7293eb56g4fbed5565ab2aa9a@mail.gmail.com>
	 <alpine.LFD.1.10.0808231440530.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andi Kleen" <andi@firstfloor.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 00:11:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX1JS-0005VP-WE
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 00:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbYHWWJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 18:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYHWWJX
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 18:09:23 -0400
Received: from qb-out-0506.google.com ([72.14.204.224]:9074 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYHWWJW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 18:09:22 -0400
Received: by qb-out-0506.google.com with SMTP id a16so1442224qbd.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 15:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iSzSrglAOYAXioWyVFXvCZ5RCgQF3keeLnx65itu10c=;
        b=SnZt6wShy4QjvVv0ufoX43DNHnu7zaZ9DTgMsKQV3ZvxZ9II4NQxavtJE8gDkv3S77
         GFXTor6Gf3/w25I98Ns3SHGVZfHezXl85vBSEHPtOZCSqQ6xqsHRRpeaO839zYkIPihD
         LIJqysjPv88bL/2HnLilbhccu5apUIEt+PTZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=P4KVp92xP1jBwJyGQLOkwRrSP6Pjl6lK+mSHunwc2x98n91BkFvGUTx0hDIcTj8ol7
         Tt9it3mcZ3vAUrFVwZav0jwtCh1uxxpmInqhEl9w1DxeBtI3qsOd9xUQ5etCgUq/y5kg
         2xnUl5Maei7kykF9JJHgWn7Ha+TLpmj7ITGLw=
Received: by 10.142.132.2 with SMTP id f2mr947321wfd.287.1219529361378;
        Sat, 23 Aug 2008 15:09:21 -0700 (PDT)
Received: by 10.142.194.8 with HTTP; Sat, 23 Aug 2008 15:09:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0808231440530.3363@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93495>

On 8/23/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Sat, 23 Aug 2008, Paolo Ciarrocchi wrote:
>>
>> you got nice and detailed answers,  for example you can track a
>> rebased tree in your working directory using git pull --rebase.
>> What's wrong with that?
>
> No, you really really cannot do that.
>
> If the _tree_ you are tracking is itself rebasing (not just your own
> tree), then you cannot and absolutely SHOULD NOT use rebase (not directly,
> and not with "git pull --rebase".
>
> Why?
>
> Let's look at what happens. Let's say that your history looks like
>
> 	... -> A -> B -> C -> a -> b -> c
>
> where the upper-case letters are from the tree you track, and the
> lower-case letters are the commits you added yourself.
>
[skipping a nice explanation, thanks]

you are right. But i thougth Andi was looking for simply having a
working tree in sync with a remote tree that is often rebased. That's
what his script is doing.
if the user is not adding any commit, isn't git pull --rebase the same
of git fetch (or git remote update) +git checkout ?

ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-pull and tag objects
Date: Mon, 12 Feb 2007 01:40:27 +0100
Message-ID: <200702120140.28782.jnareb@gmail.com>
References: <1170933407.15431.38.camel@okra.transitives.com> <Pine.LNX.4.64.0702101347350.8424@woody.linux-foundation.org> <7vfy9ccqaa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 01:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGPDd-0007ht-QI
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 01:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbXBLAis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 19:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbXBLAis
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 19:38:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:5036 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbXBLAir (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 19:38:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2048242nfa
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 16:38:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ncPkBHlXMTFzCk/tE/lMmIOJKJKhTdF/VUIlP8RqFvfVd1TlQdNSG4X9QqWR5953X6Ll3de24JKmaUHY/ubNr0vXSLChBpZDGTTzh1soHCAlAe9WoB0DjKOSnh6/6zfkhIEa+A49REjY8PH9rmzrtKNBjFx9Jnj2EIR+szjJxcY=
Received: by 10.82.167.5 with SMTP id p5mr8986123bue.1171240726069;
        Sun, 11 Feb 2007 16:38:46 -0800 (PST)
Received: from host-81-190-18-64.torun.mm.pl ( [81.190.18.64])
        by mx.google.com with ESMTP id q1sm9295590uge.2007.02.11.16.38.45;
        Sun, 11 Feb 2007 16:38:45 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vfy9ccqaa.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39345>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> On Sat, 10 Feb 2007, Jakub Narebski wrote:
>>> 
>>> One of the solutions, used in git.git repository, is to put public key
>>> as a out-of-tree blob using git-hash-object, then tag it using singed tag
>>> with instruction about how to extract key in the tag message (tag comment).
>>
>> No. That's horrible. Yes, it's what Junio did, but if you don't trust the 
>> archive, the _last_ thing you should do is to depend on a blob in the 
>> archive itself to contain the thing to make you trust it more.
> 
> True.  I should have made it clear it was purely a convenient
> way for people to get the public key and verifying that key
> needs to be done on a separate channel.  Otherwise it would have
> confused people (exactly like Jakub was confused).

Gaah, perhaps I wasn't clear: I mentioned this as a method to _transfer_
the actual data for public key (I thought the question was about that).
Not that one should place any trust because tags are signed by in-repo
key...

-- 
Jakub Narebski
Poland

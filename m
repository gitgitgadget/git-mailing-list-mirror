From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb != HTTP back-end {Was: Re: The future of gitweb - part 2: JavaScript}
Date: Wed, 20 Apr 2011 20:47:28 +0200
Message-ID: <201104202047.29401.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <201104171211.14118.jnareb@gmail.com> <1303323892.20895.22.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Peter Vereshagin <peter@vereshagin.org>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Apr 20 20:47:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCcRE-0005Gx-5h
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 20:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100Ab1DTSrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 14:47:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37357 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab1DTSri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 14:47:38 -0400
Received: by fxm17 with SMTP id 17so570405fxm.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=VSlcZqYyNTEu1EHl/C64yov1xzaUrc+viGn0hYkVlng=;
        b=saR0e2ntb3/+sTZtsqbXsAPQNApFeucQVCo2KFT8l0PZVmCtqj0+untaqEGWzrMfj6
         LKfA2eAp3kbPjZjfBZXmssisiF5As7S6gX7FblEhjmfJYlB5hW0jo5DQQRL1uthHFhpe
         pB+p8gF0glubBXmaGZo13EfGmE/z8fYCp1iz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qnhXkvgMzVY+TL2ByooclUarEADkUHju8Bi0qmT0bi6AOwGum1IaqwzDDik3UfF731
         7pxIFyt0zKDpDskZQm6kH1X/4Swpli39+McgHZmDmeK0CRTbZuiH3JkdjnhPf9TI5C2j
         4KdiD08+dMilpy+wWrgn2cgs9gfaT1u+34bCk=
Received: by 10.223.76.129 with SMTP id c1mr2443555fak.107.1303325257527;
        Wed, 20 Apr 2011 11:47:37 -0700 (PDT)
Received: from [192.168.1.13] (aeho232.neoplus.adsl.tpnet.pl [79.186.196.232])
        by mx.google.com with ESMTPS id 23sm370431fay.4.2011.04.20.11.47.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 11:47:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1303323892.20895.22.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171873>

On Wed, 20 Apr 2011, Drew Northup wrote:
> On Sun, 2011-04-17 at 12:11 +0200, Jakub Narebski wrote:
>> On Sun, 17 Apr 2011, Peter Vereshagin wrote:
>>> 2011/04/17 00:19:07 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
 
>>> JN> Fetching and pushing via HTTP is not web interface, is HTTP _transport_.
>>> 
>>> But HTTP is an application protocol, not a transport protocol.
> 
> Forgive me, but this is seriously off-base. 
> HTTP := Hyper-Text Transport Protocol. 
>
> It is a generic, stateless, way of moving text (Base-64 encoded for
> binary data) over the wire. Sure, the ISO/OSI model may classify it as
> an "application," but that term does not mean the same thing in all
> contexts. As far as Git is concerned it is a transport; as far as the
> ISO/OSI model of networking is concerned it is an application. We aren't
> talking here about the latter.
 
Note that it is the same relation as Git has with SSH: for Git it is
(statefull and binary-safe, and authenthicated and encrypted) way
of transporting data.

>> 
>> Fetching via "smart" HTTP protocol is actually git-over-http, with
>> some extra work due to the fact that HTTP is stateless.
> 
> ...and Base-64 encoded, and chunked, and so on...

But with git-http-backend being a CGI script, this is what web server
does; git doesn't need to worry about it, but it has to worry about
HTTP being stateless.

-- 
Jakub Narebski
Poland

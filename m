From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 02:40:39 -0800 (PST)
Message-ID: <m34p17f3bh.fsf@localhost.localdomain>
References: <200812090956.48613.thomas@koch.ro>
	<bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com>
	<87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org>
	<alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Dec 14 11:42:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBoQD-0003i5-5S
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 11:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbYLNKkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 05:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYLNKkn
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 05:40:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:48778 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbYLNKkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 05:40:42 -0500
Received: by nf-out-0910.google.com with SMTP id d3so380529nfc.21
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 02:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=5+DjdUU1vpG720Fsfm3y6vSf5sP9LRehwqT5poMzT8E=;
        b=oTN4TqQnCN/mJH+jZ+YoOEmhs+y0ZZtI2azQ4CufXBnYjldiYVHQBue+8OQhLQA8DG
         PDIgs7pQz6azh6QfrpoPE2ZQrFrXQ5MroshltQk4mIBj/Tk3ogqVVGYl33iCTeW9q4Ne
         umRlrHbTxUAjecGP5eZvX/5aLqRAdhXIRyYNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=rcPoO+M+3MxdRWMEcT4CqC5WdPSlm5F96XIaxIIZQB3K/XRQrnFBdzY/OJ60YhCjrE
         UfQCVHVvFi85rX9iHLIfHY8k4yzZNJhiGVVHHbHL6JNSAwAUvgWQgCmGsltcPdhAlFTZ
         EqLnlJQTyDp3av6kG1FgiRlhcxnpzxmfXUo7g=
Received: by 10.210.49.7 with SMTP id w7mr6453703ebw.6.1229251240884;
        Sun, 14 Dec 2008 02:40:40 -0800 (PST)
Received: from localhost.localdomain (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id k9sm10978015nfh.17.2008.12.14.02.40.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 02:40:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBEAe43n015628;
	Sun, 14 Dec 2008 11:40:09 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBEAdlOf015621;
	Sun, 14 Dec 2008 11:39:47 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103059>

david@lang.hm writes:

> this is really a reply to an earlier message that I deleted.
> 
> the question was asked 'what would the security people like instead of
> SSH'
> 
> as a security person who doesn't like how ssh is used for everything,
> let me list a couple of concerns.
> 
> ssh is default allow (it lets you run any commands), you can lock it
> down with effort.

How is VPN better than that?
 
> ssh defaults to establishing a tunnel between machines that other
> network traffic can use to bypass your system. yes I know that with
> enough effort and control of both systems you can tunnel over
> anything, the point is that ssh is eager to do this for you (overly
> eager IMHO)

How is VPN better than that?

> ssh depends primarily on certificates that reside on untrusted
> machines. it can be made to work with tokens or such, but it takes a
> fair bit of effort.

There probably VPN differs...

> sshd runs as root on just about every system

And VPN doesn't?

[...]

The idea with using SSH was, I think, that it is easier and better to
use existing solution for authentication and authorization than roll
your own (see the case of CVS pserver, and Subversion svnserve).
-- 
Jakub Narebski
Poland
ShadeHawk on #git

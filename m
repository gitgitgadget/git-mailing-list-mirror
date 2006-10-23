From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 19:53:17 +0200
Message-ID: <200610231953.19605.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <a7e835d40610230801m4ac92409gbddcf66dcd1bb429@mail.gmail.com> <453CF966.7000308@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 19:53:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc3z7-00020i-Mk
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 19:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWJWRxI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 13:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWJWRxI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 13:53:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:48314 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964974AbWJWRxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 13:53:05 -0400
Received: by ug-out-1314.google.com with SMTP id q2so1456326uge
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 10:53:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a5iNAzaXDXDWSMQ8tM5lhVuqzWTXjYx7apMj7Ov4OUeRqlz/P/LJYm9ntYM5E82j1XoFtH4U+L6XPtAml38WJmlIXWWJqUzNmmB7kCRxKKO4k8KAmKSq+gV/SSATlXShJCMgBmbUqoOiQd3moDaDIyX2m+oQsBimpoBMCZFnOIk=
Received: by 10.67.30.6 with SMTP id h6mr6300071ugj;
        Mon, 23 Oct 2006 10:53:03 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id e33sm285391ugd.2006.10.23.10.53.02;
        Mon, 23 Oct 2006 10:53:03 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <453CF966.7000308@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29850>

Aaron Bentley wrote:
> James Henstridge wrote:

>> Why do you continue to repeat this argument?  No one is claiming that
>> a revision number by itself, as Bazaar uses them, is a global
>> identifier.  In fact, we keep on saying that they only have meaning in
>> the context of a branch.
> 
> And, unlike git, Bazaar branches are all independent entities[1], and
> they each have a URL.
> 
> So:
> 
> http://code.aaronbentley.com/bzrrepo/bzr.ab 1695
> 
> is a name for
> 
> abentley@panoramicfeedback.com-20060927202832-9795d0528e311e31
> 
> And it does not depend on any other branch, especially not bzr.dev
> 
> Since:
> 1. anyone with write access to the urls can create them
> 2. anyone with read access to the urls can read them
> 3. the maintainers of the mainline have no control over them
>    (except as provided by 1)
> 
> these identifiers are not centralized.

If you don't use centralized numbers (i.e. always refering to bzr.dev,
either by using always (bzr.dev URL, revno), or by using "merge" for
bzr.dev and "pull" for rest), the numbers are volatile. If URL vanishes,
then (URL, revno) to revid mapping is no longer valid. Yeah, I know,
cool URI don't change...

Besides, you need [constant] network access for this mapping.
-- 
Jakub Narebski
Poland

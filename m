From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 20:20:08 +0200
Message-ID: <200610212020.08539.jnareb@gmail.com>
References: <200610180246.18758.jnareb@gmail.com> <20061020141222.GA17497@coredump.intra.peff.net> <453A5F6D.7020306@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 20:20:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbLSB-00034g-JS
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 20:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766641AbWJUSUM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 14:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766642AbWJUSUM
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 14:20:12 -0400
Received: from hu-out-0506.google.com ([72.14.214.227]:58919 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1766641AbWJUSUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 14:20:10 -0400
Received: by hu-out-0506.google.com with SMTP id 28so600752hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 11:20:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qX8blUKn8oYfNA6ejhZ5vnLWhbZh1hCDJDZ/Us4/mHiiiIyd69/G8e/IRfpy9J1KlMQVhaVqKXdw5G3IAOwcnEQ3ylJ50wCsl7AhwStofJ441uWAgfMWn80Pu8vZMrh4VkqOfteZYXwndTkQ+st0meB+aRfeWJOdVIfsDSTZ2Yg=
Received: by 10.67.119.13 with SMTP id w13mr4209188ugm;
        Sat, 21 Oct 2006 11:20:08 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id k30sm1548058ugc.2006.10.21.11.20.07;
        Sat, 21 Oct 2006 11:20:07 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <453A5F6D.7020306@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29651>

Aaron Bentley wrote:
> Jeff King wrote:
>> On Thu, Oct 19, 2006 at 09:06:40PM -0400, Aaron Bentley wrote:
>>
>>> What's nice is being able see the revno 753 and knowing that "diff -r
>>> 752..753" will show the changes it introduced.  Checking the revo on a
>>> branch mirror and knowing how out-of-date it is.
>>
>> I was accustomed to doing such things in CVS, but I find the git way
>> much more pleasant, since I don't have to do any arithmetic:
>>   diff d8a60^..d8a60
> 
>> Does bzr have a similar shorthand for mentioning relative commits?
> 
> Yes, you could e.g. do:
> 
> bzr diff -r before:753..753

What about grandparent of commit (d8a60^^ or d8a60~2 in git),
or choosing one of the parents in merge commit (d8a60^2 is second
parent of a commit)? before:before:753 ?

-- 
Jakub Narebski
Poland

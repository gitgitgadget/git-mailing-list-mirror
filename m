From: Pedro Melo <melo@simplicidade.org>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 25 Sep 2008 15:45:25 +0100
Message-ID: <BC7F2CB5-A31A-40C8-A22F-F0AAECB091C6@simplicidade.org>
References: <200809251230.11342.jnareb@gmail.com> <CCF9B7B7-4D85-4704-9363-2CE41B048828@simplicidade.org> <200809251423.56983.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 16:47:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kis7e-0003tO-6G
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 16:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbYIYOpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 10:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbYIYOp3
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 10:45:29 -0400
Received: from mail.sl.pt ([212.55.140.13]:37615 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752516AbYIYOp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 10:45:29 -0400
Received: (qmail 13688 invoked from network); 25 Sep 2008 14:45:25 -0000
Received: from unknown (HELO [10.0.0.104]) (melo@[195.23.56.16])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <jnareb@gmail.com>; 25 Sep 2008 14:45:25 -0000
In-Reply-To: <200809251423.56983.jnareb@gmail.com>
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96771>

Hi,

On Sep 25, 2008, at 1:23 PM, Jakub Narebski wrote:

> Pedro Melo wrote:
>> On Sep 25, 2008, at 11:30 AM, Jakub Narebski wrote:
>>
>>> * Support for FastCGI (via CGI::Fast or FCGI).
>>>
>>> Unfortunately I don't use FastCGI.  This has to be done in a very
>>> un-intruisive way, and without performance penalties for "ordinary"
>>> CGI and mod_perl.
>>>
>>> Suggested: input reading and validation refactoring.
>>
>> Is it ok to require CPAN modules? If yes, then using HTTP::Engine  
>> as a
>> base could be helpful here.
>
> No, it is not.  Some gitweb installations (kernel.org, IIRC) are on
> tightly managed machines, where installation is severely restricted.
> If it is distributed together with Perl package it is best, if it can
> be found in distribution packages it is good, if it can be found in
> distribution extras it is quite good, if it can be found in trusted
> package repository, it is manageable.  Installing untested packages
> from CPAN is usually out of the question.

> That said...
>
>> It supports standalone deployments as well as FastCGI, CGI, mod_perl,
>> POE and others.
>>
>> And it acts as a very simple HTTP-layer, without any "framework"
>> logic.
>
> ...if we could make it conditional on HTTP::Engine being installed,
> and fallback on current code easily, it could be done, I think,  
> without
> problems.
>
> Thanks for the pointer.

While researching HTTP::Engine (I use Catalyst and they where talking  
about moving to it), I also came across a new HTTP layer, called  
Mango. Also on CPAN, so same conditional code applies.

Right now, I'm not sure what the Cat team is thinking, HTTP::Engine or  
Mango, or other, but I suggest the use of the stack then end up  
choosing. The Cat team has a very good test-driven way-of-doing  
things, and the modules they use tend to stabilize very quickly.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!

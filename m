From: Pedro Melo <melo@simplicidade.org>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 25 Sep 2008 12:08:39 +0100
Message-ID: <CCF9B7B7-4D85-4704-9363-2CE41B048828@simplicidade.org>
References: <200809251230.11342.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 13:09:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiojI-0007gO-T2
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 13:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbYIYLIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 07:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbYIYLIo
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 07:08:44 -0400
Received: from mail.sl.pt ([212.55.140.13]:38482 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753194AbYIYLIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 07:08:44 -0400
Received: (qmail 5925 invoked from network); 25 Sep 2008 11:08:40 -0000
Received: from unknown (HELO [10.0.0.104]) (melo@[195.23.56.16])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <jnareb@gmail.com>; 25 Sep 2008 11:08:40 -0000
In-Reply-To: <200809251230.11342.jnareb@gmail.com>
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96747>

Hi,

On Sep 25, 2008, at 11:30 AM, Jakub Narebski wrote:

> * Support for FastCGI (via CGI::Fast or FCGI).
>
>  Unfortunately I don't use FastCGI.  This has to be done in a very
>  un-intruisive way, and without performance penalties for "ordinary"
>  CGI and mod_perl.
>
>  Suggested: input reading and validation refactoring.

Is it ok to require CPAN modules? If yes, then using HTTP::Engine as a  
base could be helpful here.

It supports standalone deployments as well as FastCGI, CGI, mod_perl,  
POE and others.

And it acks as a very simpe HTTP-layer, without any "framework" logic.


> * Committags support
>
>  Support expansion of "tags" in commit messages, like gitweb now  
> does for
>  (shortened) SHA-1, converting them to 'object' view link.  It  
> should be
>  done in a way to make it easy configurable, preferebly having to
>  configure only variable part, and not having to write whole  
> replacement
>  rule.
>
>  Possible committags include: _BUG(n)_, bug _#n_, _FEATURE(n),
>  Message-Id, plain text URL e.g. _http://repo.or.cz_, spam  
> protecting of
>  email addresses, "rich text formatting" like *bold* and _underline_,
>  syntax highlighting of signoff lines.

If this part is modular, we can even use a full blown text markup  
tool, like Markdown or Textile, to generate the HTML version of the  
commits.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!

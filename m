From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: safely output binary files for 'blob_plain' action
Date: Sat, 17 Jun 2006 17:35:40 +0200
Message-ID: <20060617153540.GI2609@pasky.or.cz>
References: <200606171332.15591.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 17 17:34:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frcp1-0003Sr-7B
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 17:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWFQPek (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 11:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWFQPek
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 11:34:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10449 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751633AbWFQPej (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 11:34:39 -0400
Received: (qmail 9339 invoked by uid 2001); 17 Jun 2006 17:35:40 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200606171332.15591.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22020>

Dear diary, on Sat, Jun 17, 2006 at 01:32:15PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Introduced new configuration variables: $default_blob_plain_mimetype 
> and $default_text_plain_charset (only 'utf-8' is guaranteed to work
> for the latter).

Nah, defaulting to 'utf-8' is horrible - usually, you just don't have a
clue and should refrain from sending any charset information at all, so
I think undef is a much saner default.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.

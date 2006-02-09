From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: git + ssh + key authentication feature-request
Date: Thu, 9 Feb 2006 00:55:46 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrndul4oi.2i8.mdw@metalzone.distorted.org.uk>
References: <43EA73C3.2040309@iaglans.de> <7vhd79o6m5.fsf@assigned-by-dhcp.cox.net> <43EA7D57.7040409@iaglans.de> <7v4q39o3xs.fsf@assigned-by-dhcp.cox.net> <slrndul2bq.2i8.mdw@metalzone.distorted.org.uk> <7vacd1mkk9.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 09 01:56:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F706D-0002e1-IN
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 01:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422725AbWBIAzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 19:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422727AbWBIAzt
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 19:55:49 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:20830 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1422725AbWBIAzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 19:55:48 -0500
Received: (qmail 10413 invoked by uid 110); 9 Feb 2006 00:55:46 -0000
To: git@vger.kernel.org
Received: (qmail 10398 invoked by uid 9); 9 Feb 2006 00:55:46 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1139446546 9862 172.29.199.2 (9 Feb 2006 00:55:46 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Thu, 9 Feb 2006 00:55:46 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15776>

Junio C Hamano <junkio@cox.net> wrote:

> Correct modulo s/git-daemon/git-shell/.

D'oh!  Finger trouble!

> Now, you brought up an interesting way to do this without using
> unix uid.  Some sshd installations do not honour environment=
> settings, but that problem aside, you could define a token, say
> GIT_USER, with different value on each line in the shared
> authorized_keys file so that you can distinguish incoming
> developers that share the same "home directory", and change the
> example hook Carl gave us to use that token instead of the unix
> user identity.  I'd imagine that would work quite well.

Quite possibly.

Don't give me the credit here, by the way.  I completely stole this
whole idea from the Subversion documentation: see `SSH configuration
tricks' in 

  http://svnbook.red-bean.com/nightly/en/svn.serverconfig.svnserve.html

at the bottom.

Oh, any my mistake: the `environment...' options go at the beginning of
an authorized_keys line, not at the end.

It's so time I went to sleep.

-- [mdw]

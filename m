From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Announcing nntpgit
Date: Mon, 27 Feb 2012 22:02:31 +0100
Message-ID: <4F4BEF67.1070609@alum.mit.edu>
References: <20120224133942.49a7a420@dt> <7v62evykrq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 22:02:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S27iW-0004wD-LI
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 22:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab2B0VCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 16:02:40 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35869 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615Ab2B0VCj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 16:02:39 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1RL2VeL004695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 27 Feb 2012 22:02:32 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Lightning/1.0b2 Thunderbird/3.1.19
In-Reply-To: <7v62evykrq.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191670>

On 02/24/2012 10:38 PM, Junio C Hamano wrote:
> This is something I wanted to write (or see somebody write so that I can
> use it ;-)) even before I became the maintainer of this project, as I
> practically live inside GNUS, but never got around to go beyond the design
> phase.
> 
> How do you handle message threading (References: and In-Reply-To:)?
> 
> Would a commit on the "mainline" (a rough approximation of it would be
> "log --first-parent" starting from the tip) form the discussion starter
> article, and any side branch that fork from them would be a discussion
> thread starting at the commit?

>From contrib/hooks/post-receive-email I've locally derived a Python
version that sends one email message per commit.  It generates a thread
of messages for each reference that was pushed, starting with a summary
of how the reference was changed, and one followup email for each new
commit added to that reference.  In a threaded mail reader, this groups
all of the changes to a reference due to a particular push in a thread
that can easily be expanded, collapsed, or deleted as a group.  I find
this a convenient workflow.

I believe that NNTP threading works much the same way as email
threading, so probably the same style could be used there.  My script is
still not published, though.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

From: Wolfgang Denk <wd@denx.de>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Sun, 30 Oct 2005 21:40:34 +0100
Message-ID: <20051030204034.849C5353E3E@atlas.denx.de>
References: <43652934.8000308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 30 21:42:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWJz6-0007Vi-34
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 21:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVJ3Ukx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 15:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVJ3Ukx
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 15:40:53 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:29094 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751054AbVJ3Ukx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 15:40:53 -0500
Received: from fwd28.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1EWJyy-0006jS-01; Sun, 30 Oct 2005 21:40:48 +0100
Received: from denx.de (JbFtNoZXoetJQuLMRPSJ+e4dnZAXNJ7tdiiB0acFFitOMdhlKuNi4H@[84.150.71.90]) by fwd28.sul.t-online.de
	with esmtp id 1EWJym-1L2lk00; Sun, 30 Oct 2005 21:40:36 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id D220542970; Sun, 30 Oct 2005 21:40:34 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 849C5353E3E;
	Sun, 30 Oct 2005 21:40:34 +0100 (MET)
To: "H. Peter Anvin" <hpa@zytor.com>
In-reply-to: Your message of "Sun, 30 Oct 2005 12:12:36 PST."
             <43652934.8000308@zytor.com> 
X-ID: JbFtNoZXoetJQuLMRPSJ+e4dnZAXNJ7tdiiB0acFFitOMdhlKuNi4H@t-dialin.net
X-TOI-MSGID: 1ea2f75b-c823-41a1-87c9-b706776f06f5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10830>

In message <43652934.8000308@zytor.com> you wrote:
> The Subversion importer Perl script breaks RPM generation.  First of 

Confirmed. Well, actually the RPM *build* works fine.

> ... which RPM thinks means that you need a Perl module called v5.8.0 
> which doesn't, of course, exist.  This is arguably an rpmbuild bug, but 
> it nevertheless breaks at the moment.

It's when trying to install the RPM that we get:

error: Failed dependencies:
        perl(v5.8.0) is needed by git-core-0.99.9-1.i386


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"There are things that are so serious that you can  only  joke  about
them"                                                    - Heisenberg

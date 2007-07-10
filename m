From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: git-svn and renames
Date: Tue, 10 Jul 2007 15:42:34 +0200
Message-ID: <87odik74tx.fsf@mid.deneb.enyo.de>
References: <46938594.2010607@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 15:42:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8FzF-0001MT-Th
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 15:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbXGJNmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 09:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbXGJNmh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 09:42:37 -0400
Received: from mail.enyo.de ([212.9.189.167]:3457 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009AbXGJNmh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 09:42:37 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1I8Fz9-0006ZV-MM
	for git@vger.kernel.org; Tue, 10 Jul 2007 15:42:35 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1I8Fz8-0005Pt-88
	for git@vger.kernel.org; Tue, 10 Jul 2007 15:42:34 +0200
In-Reply-To: <46938594.2010607@dawes.za.net> (Rogan Dawes's message of "Tue,
	10 Jul 2007 15:11:48 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52069>

* Rogan Dawes:

> $ git svn dcommit
> RA layer request failed: PROPFIND request failed on '/svn/trunk/
> webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java':
> PROPFIND of '/svn/trunk/
> webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java':
> 400 Bad Request (https://webgoat.googlecode.com) at
> /home/rdawes/bin/git-svn line 400

Does the "lessons" directory exist before that commit?

From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 0/6] Detect non email patches in git-mailinfo
Date: Tue, 23 May 2006 13:42:45 -0600
Message-ID: <m18xosjznu.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 21:43:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ficn6-0002OV-Pz
	for gcvg-git@gmane.org; Tue, 23 May 2006 21:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWEWTne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 15:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWEWTne
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 15:43:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45443 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751144AbWEWTne (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 15:43:34 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4NJgkqa020661;
	Tue, 23 May 2006 13:42:46 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4NJgjAX020660;
	Tue, 23 May 2006 13:42:45 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20623>


After looking at a number of additional quit patches I noticed
a small problem with using the current git-mailinfo.  On patches
with out any leading headers git-mailinfo can get confused and
loose a bit of information.

So far I have only seen this in the quilt from Andi Kleen but
it is fairly straight forward to fix.

What follows is a small patch series that one small step at
a time refactors (and I think simplifies) git-mailinfo 
so that it can detect and cope with a file without any
email headers.

Eric

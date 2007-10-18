From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Howto request: going home in the middle of something?
Date: Thu, 18 Oct 2007 11:44:22 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710181144.22655.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 11:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiS1b-0000yV-Qi
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 11:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762225AbXJRJue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 05:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762956AbXJRJue
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 05:50:34 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:3971 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762225AbXJRJud (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 05:50:33 -0400
Received: from gollem.science.uva.nl (gollem.science.uva.nl [146.50.26.20])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9I9oUTJ025803
	for <git@vger.kernel.org>; Thu, 18 Oct 2007 11:50:31 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61510>

Hi,

I've somewhere seen it in a mail, but I can't find it anymore. I have a
bare central (public) repository and clones on various machines I work
on. We all know it, you're right in the middle of something and it is
really time to go home. You want to pick up your work at home, but
without pushing to the shared repository.

I'm sure GIT can do this elegantly, but I'm not yet sure how.  I guess
Ideally I want "git stash" at work, transfer the stashed changes to my
other machine and apply them.  How do I do that?

Alternatively, I guess, one can commit at machine A, fetch the commit
from machine A and continue. I'm still too uncertain about the remote
access options to work this out properly, but it also feels less
clean.

How do you deal with this?

	Thanks --- Jan

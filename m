From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 09 Dec 2008 11:00:30 +0100
Message-ID: <493E41BE.4050809@viscovery.net>
References: <1228815240.18611.48.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 11:02:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9zQ3-0006J9-S2
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 11:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbYLIKA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 05:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbYLIKA1
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 05:00:27 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:22644 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbYLIKA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 05:00:26 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L9zO7-00050K-Dr; Tue, 09 Dec 2008 11:00:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 35AFBA865; Tue,  9 Dec 2008 11:00:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1228815240.18611.48.camel@starfruit.local>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  R. Tyler Ballance schrieb: > The most common use-case involves
	a user merging a project branch into a > stabilization branch (`git checkout
	stable && git pull . project`) in > such a way that no merge commit is generated.
	Of course, without > thinking they'll push these changes up to the centralized
	repository. > Not 15 minutes later they realize "ruh roh! I didn't want to
	do that" > and become very frustrated that they have to resort to asking
	for help > or hand-reverting N number of commits. [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102618>

R. Tyler Ballance schrieb:
> The most common use-case involves a user merging a project branch into a
> stabilization branch (`git checkout stable && git pull . project`) in
> such a way that no merge commit is generated. Of course, without
> thinking they'll push these changes up to the centralized repository.
> Not 15 minutes later they realize "ruh roh! I didn't want to do that"
> and become very frustrated that they have to resort to asking for help
> or hand-reverting N number of commits. 

Is the problem

 * that there is no merge commit, or

 * that you have to undo N commits instead of just one?

The latter is probably helped by

   $ git reset --hard ORIG_HEAD && git push -f origin

-- Hannes

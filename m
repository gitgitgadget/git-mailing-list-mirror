From: Sebastian Pipping <webmaster@hartwork.org>
Subject: "git add -u" broken in git 1.7.4?
Date: Sun, 06 Feb 2011 01:39:32 +0100
Message-ID: <4D4DEDC4.4080708@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 06 01:39:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlsfG-0001UX-Fk
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 01:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab1BFAjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 19:39:37 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:47826 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab1BFAjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 19:39:36 -0500
Received: from [78.52.100.187] (helo=[192.168.0.2])
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1Plsf6-0002jK-JK
	for git@vger.kernel.org; Sun, 06 Feb 2011 01:39:32 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20110103 Lightning/1.0b3pre Thunderbird/3.1.7
X-Df-Sender: hartwork@binera.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166135>

Hello!


I just ran into case where

  git add -u

repetedly did not update the index.  In contrast, picking stuff using

  git add -p

works just fine.

Could it be "git add -u" is broken in git 1.7.4?

Best,



Sebastian

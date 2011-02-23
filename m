From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: non-interactive rebase opens vim
Date: Wed, 23 Feb 2011 14:21:08 +0100
Message-ID: <4D6509C4.4000501@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 14:27:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsEl2-0002ed-Fc
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 14:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485Ab1BWN1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 08:27:51 -0500
Received: from syntevo.com ([85.214.39.145]:42481 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab1BWN1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 08:27:51 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Feb 2011 08:27:50 EST
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 9C41D608004
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167693>

I've started a non-interactive rebase (of 3 commits) which results in a
conflict for the first commit. After resolving the conflict, I've invoked

git rebase --continue

which brings up vim. I would not expect that. The main problem with this
behavior is that, when invoked from our GUI client, this results in the
client hanging forever. What forces git to open vim and how can I avoid
that?

git version 1.7.3.1.msysgit.0

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com

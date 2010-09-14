From: schachtobi <schachtobi@web.de>
Subject: using git svn as subversion client
Date: Tue, 14 Sep 2010 21:35:46 +0200
Message-ID: <4C8FCE92.5070801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 21:35:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvbIL-0001Te-B1
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 21:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab0INTfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 15:35:48 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:47080 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983Ab0INTfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 15:35:47 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id F1C371708229A
	for <git@vger.kernel.org>; Tue, 14 Sep 2010 21:35:45 +0200 (CEST)
Received: from [92.75.151.92] (helo=[192.168.2.100])
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #24)
	id 1OvbI9-0001IC-00
	for git@vger.kernel.org; Tue, 14 Sep 2010 21:35:45 +0200
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
X-Enigmail-Version: 0.96.0
X-Sender: schachtobi@web.de
X-Provags-ID: V01U2FsdGVkX18i/iwCR1DgkEi4fcm9xLhsG/+vihNxFgCGFeIP
	zJHj5rzDYIi3FATo6v5NGI8z2Sm3lrLDg+fvkfbwrMELE9x5l/
	FxJGiRV+M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156205>

Hello all,

I just started learning git but I unfortunatelly have to use a
subversion repository to interact with (company).
Now I have a project (in svn) with some branches in it. I fetched those
using git-svn and even when I did a merge in the git working copy it
showed up in the right branch in subversion.

So far so good.

But now there is the fact that our team relies on the subversion
properties. Namely the svn:merginfo. Using this information we keep
track what features and bugfixes got merged into the release lines.

Unfortunatelly they got not set using git as an svn client and this way
it is actually not a standard conform svn client. Probably this was not
the development goal for git-svn.

Then I read about that git does not support properties at all (except
the executable attribute). But I also found out that David Fraser
started working on a support to set svn properties using git as a client.

My question is now how I could check if and when this got/will get
merged into the mainline git and if there is allready a feature request
for svn:mergeinfo support in git.

regards,
Tobias

From: Wilbert van Dolleweerd <wilbert@arentheym.com>
Subject: Is there a specific reason that git gui does not respect comment
 lines added by a git hook?
Date: Wed, 26 Jan 2011 11:14:28 +0100
Message-ID: <AANLkTingTLM8MCEBdS_4OAE5DU1L4xndRzQMq_gdvKaL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 26 11:14:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi2OZ-00006t-QS
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 11:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab1AZKOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 05:14:30 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64446 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab1AZKO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 05:14:29 -0500
Received: by yib18 with SMTP id 18so40060yib.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 02:14:29 -0800 (PST)
Received: by 10.100.124.15 with SMTP id w15mr4740047anc.95.1296036868897; Wed,
 26 Jan 2011 02:14:28 -0800 (PST)
Received: by 10.100.216.15 with HTTP; Wed, 26 Jan 2011 02:14:28 -0800 (PST)
X-Originating-IP: [188.205.87.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165514>

Hello,

I've written a prepare-commit-msg hook that maps Team Foundation
Server workitem ID's to a Git commit message. (When committing, a
picklist appears. Users can select one or more workitems and the
workitems are added to the commit message using a specific format.
Later on, we use git log --grep to search for specific commits
belonging to a workitem).

I'm using comments in the commit message to give additional
information to the user. For example, when the Team Foundation Server
is not available, I add the following comment to the top of the commit
message.

# Warning: could not access Team Foundation Server at <servername>.
Check your configuration or manually enter your workitem.

Because the line starts with a # sign, it is not added to the actual
commit message...when using git commit. If I use git gui, the above
comment appears in the git gui interface but *is* actually added to
the git commit message when committing.

Is there a specific reason that git gui is actually adding lines
starting with a # sign? I was expecting it to ignore those lines.

-- 
Kind regards,

Wilbert van Dolleweerd
Blog: http://walkingthestack.wordpress.com/
Twitter: http://www.twitter.com/wvandolleweerd

From: Justin Johnson <justin.johnson3@gmail.com>
Subject: configure git to not push all remote tracking branches
Date: Fri, 9 Dec 2011 10:00:13 -0500
Message-ID: <CAPD5EOjsu-9=CCUJut_bGqv=asp8FeGqL2GhKewgw3SQsArk_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 16:00:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ1wI-0007wm-6s
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab1LIPAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:00:36 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40086 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab1LIPAf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:00:35 -0500
Received: by qadc12 with SMTP id c12so518158qad.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=DjKQRqNn17T1fc7cgaxYvSNyNG5dqZRN8P+edwo9ndI=;
        b=EDAjEMZY1Vdoqaeoje1/UqySlMArI1tNXSrgdQG0WV/47+peV2KWs+N77nCplo5zS9
         0WY7mt6UifeDTzbEUYmjWyFnQ5srDk4Zg6JBD4A3NcF18ozz25VXZZnE8ySw0/4UPGG2
         91u2VRzVeuIwauXqrlqvh0RRpb9yhdadHNxoY=
Received: by 10.182.16.4 with SMTP id b4mr517116obd.77.1323442834306; Fri, 09
 Dec 2011 07:00:34 -0800 (PST)
Received: by 10.182.114.4 with HTTP; Fri, 9 Dec 2011 07:00:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186635>

Hi, I'm looking for some help with pushing to remote repositories.
I accidentally left out the refspec from my git push command and git
pushed all branches that are set up to track the remote repo that I
specified. I would like to disable this, and enforce specifying a
refspec. Is there a way to do this?
e.g.
git push alternateorigin
should not do anything, but
git push alternateorigin mybranch
should push just mybranch.
--
Justin Johnson

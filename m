From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [GSoC Update] The 7th week
Date: Sun, 11 Jul 2010 14:57:02 +0800
Message-ID: <AANLkTimyVewBItArmb7Q2ELy0Dk20LvxIdhoucap8nO6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 11 08:57:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXqTQ-00032L-Ac
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab0GKG5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:57:08 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58143 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab0GKG5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:57:04 -0400
Received: by qyk35 with SMTP id 35so1043111qyk.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=h2ZtMYWapkhpLL/PVvuNcpX6NVMIsPLuybawm4fxjGI=;
        b=Yh5SMZrYiaHkEkqG/SOnEgVNNJ8AKnnmppXDwwElwC9SKDZ9kBdkDGwhG48w8qWJQs
         tYhXLnXT38eCqtB6vb3HYvrE+NexAO9NDHERZKlk6sGrp+hw57zVnTCNUIXo5NY07r5M
         dgEDO9Cczn/8r6OtZa6nvXLwNjspAL6SI/HEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=Y1l1gCH/re7CDkAdVPmxioT2nGYdUVb5mlRl6YdJkXrL9c0kRGteb73BGkYjvgmrpP
         6BqkbDts9NtIrQkq4cwv16xykKFH9Q//0J2DesQvs43lAALPW1Ybme161OGku49gyyEr
         5ZFFFIAQipIQoMv+V+F5BzoQxbaSQYe3P6UA8=
Received: by 10.229.190.14 with SMTP id dg14mr7330476qcb.49.1278831422435; 
	Sat, 10 Jul 2010 23:57:02 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Sat, 10 Jul 2010 23:57:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150763>

Hi all,

    This is my status update of the 7th official week of GSoC.
    In the past week, I worked hard parallelly on two branches, one is
the parent rewrite feature and the other is the basic 'git-log -L'
problem fix. Generally:

    1. parent rewrite: I have finally figure out a version 1 of it and
submit it the list. It contain the basic support for '--graph' option
and I also add a few new test cases for it, also there is a little
document update;
    2. the 'git-log -L' basic feature: I have fixed 2 potential bugs
of it and also try to free the commit_list along with the
cmd_line_log_walk to try to reduce some memory leak.

    And there is an extra commit, which is a little bug fix of
previous 'diff-graph' series. :-)

    What's coming on:


Thanks!
-- 
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/

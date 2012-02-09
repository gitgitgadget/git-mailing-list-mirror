From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: [PATCH 1/2] git-svn.perl: perform deletions before anything else
Date: Thu,  9 Feb 2012 15:52:21 -0500
Message-ID: <1328820742-4795-1-git-send-email-stevenrwalter@gmail.com>
References: <7vzkcrvkfa.fsf@alter.siamese.dyndns.org>
To: gitster@pobox.com, normalperson@yhbt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 21:52:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvayw-0007bw-Bf
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 21:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113Ab2BIUwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 15:52:36 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58139 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757989Ab2BIUwf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 15:52:35 -0500
Received: by ghrr11 with SMTP id r11so1150153ghr.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 12:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gOi9jdLjU58LueEssExFUXpc6C8uewC8WmMXA69mkKA=;
        b=YUNJ/YgEJrMPwDzUFyC7kpg4lfRW43v+xEcYUW5ko2ZXq/uTrkoiIsLC9IqlpvmDX0
         V9s9scWnAl3y1N1/t5f8VkFkqxsl15ZyzngIsNxGxP21CYxxm+AxZ8u1xhhoUQw43QIs
         HyCv7I93JTnM4dbtxHflY1iROcKMCN5HXHNvg=
Received: by 10.236.182.232 with SMTP id o68mr4974258yhm.58.1328820754469;
        Thu, 09 Feb 2012 12:52:34 -0800 (PST)
Received: from brock (adsl-184-43-8-254.bgk.bellsouth.net. [184.43.8.254])
        by mx.google.com with ESMTPS id m18sm8579172ann.0.2012.02.09.12.52.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 12:52:33 -0800 (PST)
Received: from srwalter by brock with local (Exim 4.76)
	(envelope-from <srwalter@brock>)
	id 1Rvaym-0001Fy-Ts; Thu, 09 Feb 2012 15:52:32 -0500
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <7vzkcrvkfa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190320>

> I suspect that writing it this way [...] would make it much easier to
> follow.

Agreed.  New patch to follow, this time with sign-off.

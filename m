From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit: lost all my patches again
Date: Tue, 27 Nov 2007 17:17:12 -0500
Message-ID: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 23:17:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix8kJ-0004SQ-R3
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 23:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXK0WRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 17:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbXK0WRQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 17:17:16 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:6099 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbXK0WRP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 17:17:15 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1022525wra
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 14:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=p8qFfItGaTn3ZzK18hq97OldLI72Fm5lqq1hDplnTVs=;
        b=AjeCdVs0cheqkA3rwXNoE0MShMkmaQdM9/o+G46Uwr2jGJKTDIK9nrMzAWDzgDL4irZ0F+6HtfYvn6zNH66UG+5ii32KBdGKvMciXSLsgy6+e/qIksPpj338OPsvtiailmsTftkvHQx5QITZSoMtLEqiXzmbGHc/pyOP/+dCHtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AXqS8eAGUkM2dZb8+2MA0l53Mttv+H8w/5f2uWQUZ80apBR2jOZWYcybWP0NrTG9+OMnMxgBdflkwIL37lkOUPYc8OUX23qNmsyzVHrDR6EdQgkllvdgdl5cCsmt739HyhDfvQJkBoCz6BSiKFbLUszPCxKTUvDxof6XOfi7lkQ=
Received: by 10.114.123.1 with SMTP id v1mr586035wac.1196201832266;
        Tue, 27 Nov 2007 14:17:12 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Tue, 27 Nov 2007 14:17:12 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66267>

My fingers are too trained in doing "git rebase linus/master" instead
of "stg rebase linus/master". This has resulting in me losing my patch
stack again. I updated stg to the current version and tried "stg
repair"  put all my patches are still empty.

What's the easiest way to recover?

Can we add a check in "git rebase" so that it will refuse to run if
stg is active?

-- 
Jon Smirl
jonsmirl@gmail.com

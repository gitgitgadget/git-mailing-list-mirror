From: Kristian Amlie <kristian.amlie@trolltech.com>
Subject: Bug: git cherry-pick and autocrlf
Date: Wed, 14 May 2008 11:20:30 +0200
Message-ID: <482AAEDE.5050603@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII";
	format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 11:32:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwDLe-0003Aw-1c
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 11:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbYENJbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 05:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754777AbYENJbn
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 05:31:43 -0400
Received: from hoat.troll.no ([62.70.27.150]:37841 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543AbYENJbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 05:31:43 -0400
X-Greylist: delayed 669 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 May 2008 05:31:43 EDT
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 5EF6B20C36
	for <git@vger.kernel.org>; Wed, 14 May 2008 11:20:33 +0200 (CEST)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 4BAC220C35
	for <git@vger.kernel.org>; Wed, 14 May 2008 11:20:33 +0200 (CEST)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id m4E9KX73001725
	for <git@vger.kernel.org>; Wed, 14 May 2008 11:20:33 +0200
Received: from [10.3.5.25] (axis.troll.no [10.3.5.25])
    by sx01.troll.no (Scalix SMTP Relay 11.3.0.11339)
    via ESMTP; Wed, 14 May 2008 11:20:33 +0200 (CEST)
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.9 (X11/20080218)
X-Enigmail-Version: 0.95.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82089>

Hi!

Files modified by git cherry-pick seem to have their line endings 
replaced with Unix line endings, even when using core.autocrlf = true.

I am using msysGit 1.5.5.1015.g9d258.

Regards
Kristian Amlie

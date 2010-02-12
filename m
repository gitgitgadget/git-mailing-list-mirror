From: Christos Trochalakis <yatiohi@ideopolis.gr>
Subject: Maintaining a fork workflows
Date: Fri, 12 Feb 2010 11:23:44 +0200
Message-ID: <f7b87f7c1002120123t376f3f14ma3f3bcb21ae2836@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 10:49:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfs9m-00070U-Gs
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 10:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585Ab0BLJtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 04:49:46 -0500
Received: from poseidon.ceid.upatras.gr ([150.140.141.169]:54947 "EHLO
	poseidon.ceid.upatras.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab0BLJtp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 04:49:45 -0500
X-Greylist: delayed 1557 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Feb 2010 04:49:45 EST
Received: from mail.ceid.upatras.gr (unknown [10.1.0.143])
	by poseidon.ceid.upatras.gr (Postfix) with ESMTP id 0123DEB4862
	for <git@vger.kernel.org>; Fri, 12 Feb 2010 11:23:46 +0200 (EET)
Received: from localhost (europa.ceid.upatras.gr [127.0.0.1])
	by mail.ceid.upatras.gr (Postfix) with ESMTP id D92A6160CE2
	for <git@vger.kernel.org>; Fri, 12 Feb 2010 11:23:46 +0200 (EET)
X-Virus-Scanned: amavisd-new at ceid.upatras.gr
Received: from mail.ceid.upatras.gr ([127.0.0.1])
	by localhost (europa.ceid.upatras.gr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5O856fs2UjfW for <git@vger.kernel.org>;
	Fri, 12 Feb 2010 11:23:46 +0200 (EET)
Received: from mail-fx0-f215.google.com (mail-fx0-f215.google.com [209.85.220.215])
	by mail.ceid.upatras.gr (Postfix) with ESMTP id 4D4D6160CDD
	for <git@vger.kernel.org>; Fri, 12 Feb 2010 11:23:46 +0200 (EET)
Received: by fxm7 with SMTP id 7so2364614fxm.28
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 01:23:45 -0800 (PST)
Received: by 10.103.35.5 with SMTP id n5mr665814muj.132.1265966624998; Fri, 12 
	Feb 2010 01:23:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139674>

Hello, I have created a light fork of an upstream project and I am not
quite sure which "syncing with upstream" workflow fits better.

I can think of 3 solutions
1. the obvious one, merge the upstream changes on the forked branch
and make the necessary modifications on the merge commit
2. Rebase upstream commits on top of the fork & make a commit with the
necessary modifications
3. Cherrypick & modify upstream commits

Which practice is considered better?

thanks,
chris

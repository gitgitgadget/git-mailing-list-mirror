From: Dave Jones <davej@redhat.com>
Subject: Fwd: Re: git checkout -f branch doesn't remove extra files
Date: Sat, 13 Aug 2005 00:17:37 -0400
Message-ID: <20050813041737.GB25236@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
X-From: git-owner@vger.kernel.org Sat Aug 13 06:18:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3nSu-0007M0-0I
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 06:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVHMERo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 00:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVHMERo
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 00:17:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16361 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751270AbVHMERo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 00:17:44 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j7D4HhCZ013331
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 00:17:43 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j7D4HcV20892
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 00:17:38 -0400
Received: from nwo.kernelslacker.org (vpn50-5.rdu.redhat.com [172.16.50.5])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j7D4Hb3c025865
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 00:17:38 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.4/8.13.4) with ESMTP id j7D4Hbj6010649
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 00:17:37 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.4/8.13.4/Submit) id j7D4HbRS010648
	for git@vger.kernel.org; Sat, 13 Aug 2005 00:17:37 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Gar, got caught by the 'reply-to' going to Tony only...

		Dave


--VS++wcV0S1rZb1Fb
Content-Type: message/rfc822
Content-Disposition: inline

Date: Sat, 13 Aug 2005 00:16:13 -0400
From: Dave Jones <davej@redhat.com>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: git checkout -f branch doesn't remove extra files
Message-ID: <20050813041613.GA25236@redhat.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F04214AC7@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F04214AC7@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.1i

On Fri, Aug 12, 2005 at 10:31:17AM -0700, Luck, Tony wrote:
 > I've just got around to noticing some of the new (to
 > me) features in git, and started experimenting with
 > branches.

Seems a good day to learn new features, I was completely
unaware of git-ls-files somehow.

My git snapshot creator that builds the hourly tarballs at
http://www.codemonkey.org.uk/projects/git-snapshots/
currently does an rsync, and then a checkout, and finally
it cleans up by removing all the checked out files.
It currently does this by hand, but on learning about
this 'new' command, I thought, cool, now I can do..

git-ls-files | xargs rm -rf

however, this then leaves a bunch of empty subdirs, as
git-ls-files doesn't list the subdirs by themselves in
the output.  Am I missing some other option ?

		Dave


--VS++wcV0S1rZb1Fb--

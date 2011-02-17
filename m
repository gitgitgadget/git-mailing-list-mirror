From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: git clone NonExistentLocation
Date: Thu, 17 Feb 2011 10:01:27 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4D5CE3E7.5030101@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 17 10:10:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpzsT-0001SH-7Q
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 10:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab1BQJKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 04:10:14 -0500
Received: from mail96.atlas.de ([194.156.172.86]:12875 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312Ab1BQJKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 04:10:12 -0500
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Feb 2011 04:10:12 EST
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 9A26610069
	for <git@vger.kernel.org>; Thu, 17 Feb 2011 10:01:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id MPnoTHGDHOP5 for <git@vger.kernel.org>;
	Thu, 17 Feb 2011 10:01:27 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Thu, 17 Feb 2011 10:01:27 +0100 (CET)
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 1701A27177
	for <git@vger.kernel.org>; Thu, 17 Feb 2011 10:01:27 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167058>

Hi.

If I do:

 $ uname -a
Linux as100897 2.6.26-2-686 #1 SMP Thu Nov 25 01:53:57 UTC 2010 i686 GNU/Linux
 $ git version
git version 1.7.4.1
 $ ls -l NonExistentLocation
ls: cannot access NonExistentLocation: No such file or directory
 $ git clone NonExistentLocation
Cloning into NonExistentLocation...
warning: You appear to have cloned an empty repository.
 $

I get a new (empty) git repository in 'NonExistentLocation':

 $ tree -a NonExistentLocation
NonExistentLocation
`-- .git
    |-- HEAD
    |-- branches
    |-- config
    |-- description
    |-- hooks
    |   |-- applypatch-msg.sample
    |   |-- commit-msg.sample
    |   |-- post-commit.sample
    |   |-- post-receive.sample
    |   |-- post-update.sample
    |   |-- pre-applypatch.sample
    |   |-- pre-commit.sample
    |   |-- pre-rebase.sample
    |   |-- prepare-commit-msg.sample
    |   `-- update.sample
    |-- info
    |   `-- exclude
    |-- objects
    |   |-- info
    |   `-- pack
    `-- refs
        |-- heads
        `-- tags

10 directories, 14 files

Is this the intended behaviour ?

Thanks,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: An ounce of application is worth a ton of abstraction.

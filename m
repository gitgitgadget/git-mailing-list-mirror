From: Johannes Schneider <mailings@cedarsoft.com>
Subject: [OT?] Executing Git from bash script invoked by cron
Date: Mon, 28 Jun 2010 23:00:56 +0200
Message-ID: <4C290D88.80306@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 23:01:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTLRw-0000Y9-Ng
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 23:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab0F1VA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 17:00:58 -0400
Received: from hosting.cedarsoft.com ([188.40.238.168]:45648 "EHLO
	cedarsoft.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478Ab0F1VA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 17:00:58 -0400
Received: from [192.168.0.36] (HSI-KBW-109-193-057-134.hsi7.kabel-badenwuerttemberg.de [109.193.57.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by cedarsoft.eu (Postfix) with ESMTP id 206A012E6003
	for <git@vger.kernel.org>; Mon, 28 Jun 2010 23:03:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Lightning/1.0b2pre Thunderbird/3.0.4
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149860>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I try to mirror my local git repository.
Therefore I created a bash script. This script, executed form the
command line, works fine.

But the same script executed by cron, does not work. Git push does
simply nothing. No output, no push, nothing.
But git log and git --version works...

I tried to google the problem, but couldn't not find anything useful.
Any hints are welcome.


Ubuntu 64Bit
git version 1.7.0.4
cron 3.0pl1-106ubuntu5


Thanks,

Johannes
- -- 
Johannes Schneider - blog.cedarsoft.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMKQ2GAAoJEAytD9R7Qv6dRmIH/3YqxEMRDLeHcLfsH0JYBdOT
NG2e7mMjiYg2akQOsXSN4iN1iMrRfj/gp9udd7QM4p8W06xlv0wftOC87IKZKDtp
DujAYB6hHMtHYkVrWV9KuP+ptuaZDvhgti+8DvfAKGuXbRa0xs4CcRCclLLNrj6x
tqJJZatdVZgvEDBePWVcTJfglJf+2lozxBXvTkat8mjEGCYDuUfvG37yimSETZHT
wJITWGi3BdMG5m6xHOHDYp4IHuGw2sfWYAN3EE7dS6m2P7/l/VRM18PsAWFM3j1Q
Axv57mkJu1ea9tj54W7I7kJCHDC5TZDf9FXSPPOMY1t1qzgtGfB7tfQMDamHIYY=
=LRSS
-----END PGP SIGNATURE-----

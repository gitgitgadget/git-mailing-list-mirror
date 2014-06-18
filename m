From: <warren.l.dodge@tektronix.com>
Subject: Error 128 Clone succeeded, but checkout failed
Date: Wed, 18 Jun 2014 16:03:40 -0700
Message-ID: <05c29ee7-8629-424e-b2db-de49db976e55@US-BV-EXH02-P.global.tektronix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <git@vger.kernel.org>, <warren.l.dodge@tektronix.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 01:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxOtR-0002Ld-2s
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 01:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962AbaFRXDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 19:03:45 -0400
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:59897
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752390AbaFRXDo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 19:03:44 -0400
Received: from mail84-ch1-R.bigfish.com (10.43.68.240) by
 CH1EHSOBE008.bigfish.com (10.43.70.58) with Microsoft SMTP Server id
 14.1.225.22; Wed, 18 Jun 2014 23:03:43 +0000
Received: from mail84-ch1 (localhost [127.0.0.1])	by mail84-ch1-R.bigfish.com
 (Postfix) with ESMTP id 2856C1A0331	for <git@vger.kernel.org>; Wed, 18 Jun
 2014 23:03:43 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:192.65.42.18;KIP:(null);UIP:(null);IPV:NLI;H:mx.danahertm.com;RD:mx.danahertm.com;EFVD:NLI
X-SpamScore: 0
X-BigFish: VPS0(zz444eMzz1f42h1ee6h1de0h1fdah2073h2146h1202h1e76h2189h1d1ah1d2ah21bch21a7h1fc6h208chzz1de097hb412mz31h2a8h839h8e3h947hc60hc61hd24hf0ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh162dh1631h1758h18e1h1946h19b5h1b0ah224fh1d0ch1d2eh1d3fh1dc1h1dfeh1dffh1e1dh1fe8h1ff5h2216h22d0h2336h2438h2461h2487h24d7h2516h2545h255eh25f6h2605h268bh26d3h27e2h282bh293fh)
Received-SPF: softfail (mail84-ch1: transitioning domain of tektronix.com does not designate 192.65.42.18 as permitted sender) client-ip=192.65.42.18; envelope-from=warren.l.dodge@tektronix.com; helo=mx.danahertm.com ;anahertm.com ;
Received: from mail84-ch1 (localhost.localdomain [127.0.0.1]) by mail84-ch1
 (MessageSwitch) id 1403132621560243_14155; Wed, 18 Jun 2014 23:03:41 +0000
 (UTC)
Received: from CH1EHSMHS037.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.246])	by mail84-ch1.bigfish.com (Postfix) with ESMTP id 85843E004A
	for <git@vger.kernel.org>; Wed, 18 Jun 2014 23:03:41 +0000 (UTC)
Received: from mx.danahertm.com (192.65.42.18) by CH1EHSMHS037.bigfish.com
 (10.43.69.246) with Microsoft SMTP Server (TLS) id 14.16.227.3; Wed, 18 Jun
 2014 23:03:41 +0000
Received: from US-BV-EXH02-P.global.tektronix.net (128.181.11.23) by
 US-BV-EXE01-P.global.tektronix.net (128.181.15.45) with Microsoft SMTP Server
 (TLS) id 14.3.146.0; Wed, 18 Jun 2014 16:03:32 -0700
Received: from PC-BEAV-1F55 (128.181.7.176) by mail.danahertm.com
 (128.181.11.23) with Microsoft SMTP Server id 14.3.169.1; Wed, 18 Jun 2014
 16:03:39 -0700
X-OriginatorOrg: tektronix.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252080>

I have looked for an answer to the Error 128 Clone succeeded, but checkout failed message we are getting on a clone command.
And there does not seem to be any that relates to our situation. 

The repository is on a local file server system that is mounted to the pc as L:

If we clone the repository on to the L: directory structure we get the following

git.exe clone      --progress -v  L:\GIT_REPOSITORY L:\warrend\fail

Cloning into L:\warrend\fail
Done.
Fatal: unable to read "Long hash key"
Warning: clone succeeded, but checkout failed.
You can inspect what was checked out with git status
And retry the checkout with git checkout -f HEAD

Git did not exit cleanly (exit code 128) ( time and date etc)

At this point there is only a .git directory at the destination

We have another drive mounted as X: which utilizes a different file server. If we do this

git.exe clone      --progress -v  L:\GIT_REPOSITORY X:\warrend\works

It will clone and do the checkout properly.

These does not seem to be any permission or disk space problems on the L: drive. We are unable to figure out why this is happening.

I copied the two .git directories to a linux file system and did a diff -r of them and found this

Bad one doesn't have the putty line for some reason 
diff -r fail/.git/config  works/.git/config
12d11
<       puttykeyfile = 

There was no index file in the bad tree. The config file which is in both trees was made after the index file.
Only in .git: index

I was hoping there was a debug method that would allow us to see what the actual check was that is failing.
Any help on this would be greatly appreciated.

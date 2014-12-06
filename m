From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: How to repair a shallow clone (?)
Date: Sat, 06 Dec 2014 13:23:59 +0100
Message-ID: <5482F55F.1060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 06 13:24:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxEPA-00050b-8r
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 13:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbaLFMYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 07:24:04 -0500
Received: from mout.web.de ([212.227.15.4]:50423 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbaLFMYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 07:24:02 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0M57T4-1XmZ7G0ANa-00zIoV for <git@vger.kernel.org>; Sat,
 06 Dec 2014 13:24:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:4rDKmn8pNbSWkbEA6Fy2nvmgG2c6qlzUSzSnwSb1lOiMOoE6PcK
 sGQZ+Y/vasikh70YDA7QjbFhBGoCTKF7e3Ck3qfaq+xi9SeMcCxQ434F93iLQY4Z2GaNbEm
 YAmlO/P77EnnBtU9jjNbk28w0gy3wW5uIgBiy5vpomsH8Y6H+KYF4xyYfHN8BJA1f6vbPOb
 EOzeK6OEKh2r1OoNaYqcg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260948>

I share a bare repo with Sparkleshare which does an auto-synch.
Now the synch had stopped, and trying to push to the central repo
by hand gives this:



git push  origin master
fatal: protocol error: expected old/new/ref, got 'shallow 72fb4080921221293e28a97a0e8c78d6100c5186'
fatal: The remote end hung up unexpectedly
Counting objects: 4, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (4/4), done.
error: pack-objects died of signal 13
error: failed to push some refs to xxxxx

Both machines have Git >2.0.0

Is this a known issue/problem ?

I think I started to clone the repo in a shallow way
(SparkleShare asked if I want to clone the complete history,
and I probably answered "no" )

Is there a way to repair this situation ?
(Except doing a complete re-clone ?)

Thanks for help

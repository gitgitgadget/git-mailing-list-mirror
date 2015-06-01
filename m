From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: git gc gives "error: Could not read..."
Date: Mon, 1 Jun 2015 09:37:17 +0200
Message-ID: <556C0BAD.80106@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 01 09:37:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzKHv-0003k3-FP
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 09:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbbFAHha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 03:37:30 -0400
Received: from mail96.atlas.de ([194.156.172.86]:30896 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485AbbFAHha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 03:37:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id A5DF910159
	for <git@vger.kernel.org>; Mon,  1 Jun 2015 09:37:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EW9k0RkBQQx8 for <git@vger.kernel.org>;
	Mon,  1 Jun 2015 09:37:18 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Mon,  1 Jun 2015 09:37:18 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 0E5D527169
	for <git@vger.kernel.org>; Mon,  1 Jun 2015 09:37:17 +0200 (CEST)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server id 8.3.327.1; Mon, 1 Jun 2015
 09:37:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
OpenPGP: id=2DF5E01B09C37501BCA99666829B49C5922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270378>

Hi there.

One of my repos started giving an error on 'git gc' recently:

 $ git gc
 error: Could not read 7713c3b1e9ea2dd9126244697389e4000bb39d85
 Counting objects: 3052, done.
 Delta compression using up to 4 threads.
 Compressing objects: 100% (531/531), done.
 Writing objects: 100% (3052/3052), done.
 Total 3052 (delta 2504), reused 3052 (delta 2504)
 error: Could not read 7713c3b1e9ea2dd9126244697389e4000bb39d85

(Yes, the error comes twice).

I tried:

 $ git cat-file -t 7713c3b1e9ea2dd9126244
 fatal: Not a valid object name 7713c3b1e9ea2dd9126244


Otherwise, everything works fine.

I used that repo initially on Win7 with an older msysgit installation but
also tried the latest git-for-windows installer, and version 2.4.2 on linux.
All give the same error (no matter if I clone or copy the repo).

Unfortunately I cannot make the repo publically available.

Any chance to get rid of that error ?

Thanks,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: When it comes to humility, I'm the very BEST there is!
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')" 
GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF

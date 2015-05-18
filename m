From: Yuval Greenfield <ubershmekel@gmail.com>
Subject: Hanging "git mv" on Windows bug report
Date: Sun, 17 May 2015 23:50:47 -0700
Message-ID: <CANSw7Kw7A_kn6yue9TnvGSO9dFzvX8AUZkn0W98Euf384CbnFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 08:51:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuEtO-0003hU-HV
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 08:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbbERGvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 02:51:10 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35892 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbERGvI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 02:51:08 -0400
Received: by igbpi8 with SMTP id pi8so40251252igb.1
        for <git@vger.kernel.org>; Sun, 17 May 2015 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=PLNTniQyFTz80+bfAcHiRfBFplMSd7ZNWF6SVrLLB2s=;
        b=TXzZz6hPA8hXS94I+sT69/T8A4LNbtVc5GngGaT3nyrDEI+r7lj6qcwt1Q1Yi3DZYL
         CgcUeeXXtP9SigL/kg9yfsYfBte5EGA4rGn5Z7cJe0eUFbQAWh+pMEGR1SO/204kqlF4
         eAv2tSY2M0XeKxk6Rrrw+lkT8aY/LtCiV7Vfw+e3/EbZIC0UkWfJ63gO4V4CCKE1iGoK
         yUWIXM5ug1t9OghK+kvaFxPjUq1SNDdVlbCm62xOdvkwQiy9IKatZ04YK+XX+9Gn9mea
         75u2G0N3i1Fi+SA993xjQNRVjb+cvHVSCWkqutUSr1lyhULS/0pXYP4IeHWWBs91PFJb
         vyew==
X-Received: by 10.42.35.139 with SMTP id q11mr14340500icd.88.1431931868223;
 Sun, 17 May 2015 23:51:08 -0700 (PDT)
Received: by 10.36.110.11 with HTTP; Sun, 17 May 2015 23:50:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269224>

Hi git,

Here is the command sequence that causes git to stop responding:

mkdir mynewthing
cd mynewthing
git init
mkdir abc
touch abc/myfile
git add abc/myfile
git commit -a -m "whatever"
git mv abc tmp
git mv tmp Abc

I wanted to change the case of a committed folder. Since windows is
case insensitive that's a bit harder. Perhaps with this version it's
impossible?

Here's my git bash banner - "Welcome to Git (version
1.9.5-preview20141217)". I'm on Windows 8.1 Pro.

Cheers,

Yuval

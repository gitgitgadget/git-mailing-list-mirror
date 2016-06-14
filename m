From: Christian Couder <christian.couder@gmail.com>
Subject: [ANNOUNCE] Sharness v1.0.0
Date: Tue, 14 Jun 2016 21:34:17 +0200
Message-ID: <CAP8UFD0uvaB-2_CrXs2ZvoqLRHfCd8efA-S7-tE2Qa6Pn+rAAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mathias Lafeldt <mathias.lafeldt@gmail.com>,
	Alexander Sulfrian <alexander.sulfrian@fu-berlin.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Konstantin Koroviev <kkoroviev@gmail.com>,
	"Mark A. Grondona" <mark.grondona@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Maxim Bublis <b@codemonkey.ru>,
	Richard Hansen <rhansen@rhansen.org>,
	Roman Neuhauser <rneuhauser@suse.cz>,
	Simon Chiang <simon.a.chiang@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:46:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCu6S-0008Da-CM
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 21:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbcFNTeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 15:34:20 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35080 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbcFNTeT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 15:34:19 -0400
Received: by mail-wm0-f43.google.com with SMTP id v199so135124038wmv.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fU2ry8X4ZLqZNfB2J4naXY2diLPj7PA8rhNnwR2f2HU=;
        b=O205o4UqRKYUA66GhNNsInKrCS3PCtJapN3qX6gWbbiX4BSm42Z33PQ68oSjjQ/m27
         hj5IyTi5jbfFsVtF9eVjUWiJNWgOdqIY2aH5j/3bAGrDxOfAn+bCuDkWDazyEutkEte1
         9SaI2MQfMm71JMeVhZBEE/n1xzW+LtM8chTOjfpfgKv7M9VP7kQnV3GC1f024d+/pc7T
         poBqcbRALelKq08j/x3RCb9dheLrpUIxDL76bHV1zmwcuhmXrFVpaWqZbKkcaX7idtPM
         jXKbhd4OC5SJfvOInFpwLDusR33pW4irepr8qiPaLOm298VevQPa94tZ3yirMisX4MGs
         mM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fU2ry8X4ZLqZNfB2J4naXY2diLPj7PA8rhNnwR2f2HU=;
        b=MOliRyBoY1686rgmStDRCWLgBmGlNhUTFEsDgO3LU7SXhGMsTykyH7/MJj/enVSLc4
         iX/G5p0KVeZDAebpojnZQ615tmKSjFYUB1er9iBvg6PDDXLpXsmXqhaA5Dyth5iH0Mw3
         ugMrx4UprX4vZwFoZsLLYNmmEIT3yHBljJ8whov9JMNsTbylrqP5fGTSLJbfXgI1JHTP
         WWk1KPy3cF0ciRZ93ccCLc3Ut4OM1B6VZUrPpBNMmQN25HaB23hlw71XJ8pY0UfLoEFd
         InqqrkBscNEcZZqVnEaD2h+IDcfdoETW/3aWi8ePpB4+eIJYccNHvw2vL2kWCqUmraXg
         2H8A==
X-Gm-Message-State: ALyK8tK4CkfJcUpyUdNDr7MPG+iZ1ZWkKwiZMx3PFpkD3Gh8Tu3loD8A72F/xn6LnISPwI8UAesNGUGDdu62Ow==
X-Received: by 10.195.17.138 with SMTP id ge10mr8475325wjd.94.1465932858288;
 Tue, 14 Jun 2016 12:34:18 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Tue, 14 Jun 2016 12:34:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297324>

Hi,

Version 1.0.0 of Sharness [1] -- the test harness library derived from
Git's test lib -- is released.

This release contains many upstream fixes and improvements from Git
and a lot of specific user contributed features [2].

It's the first release since v0.3.0 in April 2013 [3].

Sharness was first announced on this list in July 2012 [4]. It was
created from Git's test lib in April 2011 by Mathias Lafeldt who
improved and maintained it until a few days ago.

Thanks a lot Mathias!

Thanks also to all the other contributors (by alphabetical order)
since the beginning:

Alexander Sulfrian
Dennis Kaarsemaker
Jeff King
John Keeping
Konstantin Koroviev
Mark A. Grondona
Matthieu Moy
Maxim Bublis
Richard Hansen
Roman Neuhauser
Simon Chiang

Thanks also to all the Git contributors who improved test-lib.sh as
many of the features and fixes come from upstream!

Enjoy,
Christian.

[1] https://github.com/chriscool/sharness
[2] https://github.com/chriscool/sharness/blob/master/CHANGELOG.md
[3] http://thread.gmane.org/gmane.comp.version-control.git/219944/
[4] http://thread.gmane.org/gmane.comp.version-control.git/201591/

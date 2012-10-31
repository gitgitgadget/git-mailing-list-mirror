From: aurelijus@astdev.lt
Subject: Segmentation fault in git diff
Date: Wed, 31 Oct 2012 18:41:22 +0100
Message-ID: <CAOomjNvLrC1N3T+KrVPzXFC-Efxr2meE1-jwT8V3ZQae7CPy6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 18:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTcIs-0002jU-TD
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 18:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759358Ab2JaRls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 13:41:48 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39644 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758613Ab2JaRlq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 13:41:46 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2449216iea.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 10:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :x-gm-message-state;
        bh=HOQbgWMbXRMxoJl0TJMEfVB1nzrYh/OxdjMY8g8h9xY=;
        b=aMUc8UjpSFEWXNjhrolrmvvY3mw42N5Z3OteCjqDT0zUNOg9DvU9nonaq4FCJ+w57Q
         aCD5mRpN27X2RkUbn/5G/ifkvSb7OT8FuW8sKHQgrEHFd2CxTTifvE++kGdTqYwCB/Pj
         C/r2TLS2GAOqV6ePiIkfU1ZfcB5jBGk6iaX+TQIR+P6zDnxzmWAjGJ2GS5rVpQWJvId6
         zDb/YV4lBWNFnBrRz5/uIFSvtyzeS7OwPreLj1cLpRYN8DB95ZHMj3cRdz6AEddgTh8f
         cbBY5SmsUA+gAWd0HjQwNCcq18tCvRSS+lQevwQf1udNnxRLqH+bYjd9dJc6S8VNkAFf
         RIrQ==
Received: by 10.50.237.103 with SMTP id vb7mr2447601igc.29.1351705306191; Wed,
 31 Oct 2012 10:41:46 -0700 (PDT)
Received: by 10.64.23.75 with HTTP; Wed, 31 Oct 2012 10:41:22 -0700 (PDT)
X-Gm-Message-State: ALoCoQl746WBkAUse/q2y/psYzmtSsQwa4D0jmTSDXNX1GYTKiXx+rUtmTwt17+xCwAzO+XUcVZU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208842>

Hey,
I'm getting "Segmentation fault (core dumped)" when running command:
git diff -n1 -M -C -B --find-copies-harder --raw -t --abbrev=40
'd8c10caae6db3914695c3bc91cc7852777727625'^1
'd8c10caae6db3914695c3bc91cc7852777727625'

Here is full output - https://gist.github.com/d8f32227ea35488d9abc

I tried & got the error on  1.7.11.1, 1.7.12.3 & 1.8.0.

Server is RHEL 6.3

Repo config:
[core]
repositoryformatversion = 0
filemode = true
bare = false
logallrefupdates = true

Any ideas?

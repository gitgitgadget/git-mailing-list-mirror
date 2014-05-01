From: Phil Hord <phil.hord@gmail.com>
Subject: Zsh submodule name completion borked
Date: Thu, 1 May 2014 18:23:31 -0400
Message-ID: <CABURp0oS0qnyVhfV1rsaNXT-88QJvgpNn+meApNKRTGdULDXpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 02 00:24:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfzOW-0001dm-P5
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 00:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbaEAWXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 18:23:53 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34339 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbaEAWXw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 18:23:52 -0400
Received: by mail-wi0-f173.google.com with SMTP id bs8so1467466wib.12
        for <git@vger.kernel.org>; Thu, 01 May 2014 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=z0X03b6tS57isFN72f5niFu4O/gtp+SNU+2XCjy3sR4=;
        b=QXusrknTspn2/jDHWuBpJEamtRk3NV2aQy+4SvESh4XCC3GJAhx7mcm/bArUQ6LGYG
         oM3jboBVMDde/qhZyEclE9X3bJx+fKGtSoxds9zHh01j/fhdzpnV47I6urn3co9NxzUS
         hoyqtBisKtmi2dZBQreA73YtaYAFV3y8Q/d2IEEXDyXzFB3kyeQp3Ca9QjrYKLbYO7zR
         ChIkr3ijUVnkUcYjxKBswfhgUG0efwfTAbsgqXEe4Qic6MLWosxv5x9IZHZ35aAL0A7v
         Go0M9YJzlAqvZgxyWVtYahnI0pLM/vypFYmgL5QeYh95P1u/E9axBujhFT0pYMNg3J4T
         95Tw==
X-Received: by 10.180.94.8 with SMTP id cy8mr1584wib.29.1398983031181; Thu, 01
 May 2014 15:23:51 -0700 (PDT)
Received: by 10.227.231.193 with HTTP; Thu, 1 May 2014 15:23:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247888>

When I use zsh tab-completion to complete the submodule name in 'git
submodule init', I get more than I expected.

>From the gerrit repository (which has plugins):
  $ git submodule init plugins/<TAB>
  plugins/commit-message-length-validator\ \(v1.0-rc1-9-g545000b\)
  plugins/reviewnotes\ \(v1.0-rc1-8-ge984300\)
  plugins/replication\ \(v1.1-rc0-13-g4c3f4c9\)

It works ok in bash.  I tried to bisect the trouble, but it still
fails in 1.8.3, so I'm beginning to think it's me.  Does this happen
to anyone else?  Is it something in my local configuration causing
this?

Thanks,
Phil

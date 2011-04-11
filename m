From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: textconv not invoked when viewing merge commit
Date: Mon, 11 Apr 2011 19:12:47 +0200
Message-ID: <201104111912.47547.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 19:13:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Kfx-0005M0-3I
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 19:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab1DKRNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 13:13:15 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:39748 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752215Ab1DKRNO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 13:13:14 -0400
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mx.arcor.de (Postfix) with ESMTP id 963AD26C8F
	for <git@vger.kernel.org>; Mon, 11 Apr 2011 19:13:13 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id 8AA1ED79A9
	for <git@vger.kernel.org>; Mon, 11 Apr 2011 19:13:13 +0200 (CEST)
Received: from soybean.localnet (178-190-160-96.adsl.highway.telekom.at [178.190.160.96])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-08.arcor-online.net (Postfix) with ESMTPSA id 82B6E205087
	for <git@vger.kernel.org>; Mon, 11 Apr 2011 19:13:13 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-08.arcor-online.net 82B6E205087
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1302541993; bh=8YHQ1ccEkByO/zY1koxdDz8j+LTTt9S+G9EGHeGtxjk=;
	h=From:To:Subject:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id;
	b=lTDeDx1Vh3voMGte7AIROZixx7bxZ1C81fTKllHryUCGKLsNgOUHrHiC1JhhkQUyb
	 M5i9EuJsZM/xMh6d+h1sNxMMsL4o72ULTwHHsKXM7dquPr84ylEoqBQu33n8Cvrc1C
	 ijnTFQIYV1Dol+QKsfaVsPybCfzwzoSQipmxzYnM=
User-Agent: KMail/1.13.5 (Linux/2.6.35-28-generic-pae; KDE/4.5.1; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171337>

Hi,

i currently use a textconv filter to show contents of a zip like archive in a user readable format(as a list of contained files).

This works fine, except for merge commits.
For merge commits i see the diff of the binary contents of the file.

Is this intentional?
git help gitattributes mentions no such limitation.
Anywhere else(gitk(on non merge commit), git gui blame) i see the the filtered textual representation of the file.

I tried 1.7.4 msysgit and current master

Greetings Peter

From: Antoniy Chonkov <antoniy@chonkov.net>
Subject: Git server for Android
Date: Wed, 12 Sep 2012 01:34:37 +0300
Message-ID: <CAAKXCFfgv-4WzUHOUZtngzFgnoK-=O5pxTqqLSJzSqBvA=UnAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 12 00:34:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBZ2f-0000T5-3S
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 00:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab2IKWek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 18:34:40 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60618 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751577Ab2IKWej (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 18:34:39 -0400
Received: by lagy9 with SMTP id y9so682655lag.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=byX9MMRtIiyU8pWhPvS9cYuag9W+cg6T5Y7L5ss8YjE=;
        b=0Of2QrtDlZBCwsWhMQdpCr89rf7CpCTDjsjwlS7GSh6wZt0uUVF41nPIZLMsEXpnpq
         HgWWZkbm6mVRGq3YR1w5HmqkjqvvgZ0SiLCYYWkjxTpyQcmMjJD8qn79dSHS+V670cdu
         Ga8IffZK7gcWlHYvIFEpqy1g3SKX3FY4UeVUVoVx+i6yoCxWy1ezaos2ZITy8HSsrnQV
         dFYyMKaHLkXPlOMEpugIUtll/jshF1GECRq0/JTT7L8RjQTT9jSqKR28N2fsHWe1DwnW
         ePScj1EahuyT8JBsYEcDaCMmKJhvHnSQlrWMnjHLhqaMZud6HV52VnzR1f7Ev0WI9G4N
         8BHw==
Received: by 10.112.44.167 with SMTP id f7mr6710492lbm.34.1347402877556; Tue,
 11 Sep 2012 15:34:37 -0700 (PDT)
Received: by 10.112.24.164 with HTTP; Tue, 11 Sep 2012 15:34:37 -0700 (PDT)
X-Google-Sender-Auth: DubxL8RiJFNGCYNk01JQFn5jBPk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205268>

Hi guys,

I'm looking for some feedback regarding an Android app I've released.
It's a simple idea of mine for a tool that may be useful to developers
when travelling or working on different locations.

So the idea was to combine the two (in my opinion) very complementary
paradigms - mobility and distribution. In particular - the mobility of
any Android device with the distribution that Git provides. The app is
called Gidder and it's a Git server implementation for Android on top
of a SSH server. It has user/repository management, dynamic DNS
support and basically automatically handles upload-pack and
receive-pack commands (so we may push and fetch/pull).

The app can be found on Google Play Store and it's free:
https://play.google.com/store/apps/details?id=net.antoniy.gidder.beta

Cheers,
Antoniy

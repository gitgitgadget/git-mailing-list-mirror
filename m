From: Kevin Wern <kevin.m.wern@gmail.com>
Subject: [PATCH 0/2] git-prime-clone
Date: Wed, 18 May 2016 22:07:28 -0700
Message-ID: <1463634450-28265-1-git-send-email-kevin.m.wern@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 07:08:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3GC5-0007ev-NP
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 07:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbcESFII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 01:08:08 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36241 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcESFIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 01:08:07 -0400
Received: by mail-pf0-f176.google.com with SMTP id c189so26836598pfb.3
        for <git@vger.kernel.org>; Wed, 18 May 2016 22:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=mZd16eyg0e68GNhPNBCLIlVckcMncbpro7tbDUOf1uM=;
        b=hqOs0kG41xcEinOT3ILRlOtZyRgZ7v5zgAWSgtma10nU81HZtzFmgJPLmNBurpwo1z
         5eY4iubZ39QmNeDQ5WR5jN5sZwtyfEjopsr8ZIxDdGjvJvJp0esUrjbWc1iaGMuOaW0e
         o4g5oro+6Y6pL2BYxpdK02h9/ogEbO2j3mCTLhbJ6IrxrGXt43KBtBKCyqFNRHz78zRF
         6vHInhirDAisuY0pTITEpUjcBmIzCSE69ubMPEXFJy65jj/VJsnFaVqTfmwxQMA2iHc1
         c3XI2iGHuLIY1KkSywCDoHApzQFfdiksd/EUQ4s0mQutJccU0Nn948JvI3gVhQc9NAMk
         OJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=mZd16eyg0e68GNhPNBCLIlVckcMncbpro7tbDUOf1uM=;
        b=Geqdbur0n4vR35SLtp2j8REv/BFvQbOiRcME2jXH5GQ2+1f00TurkeytfQSp6jdLdN
         Z1UCSBfuX21f89HQPiDAibrBSeYdY+cQBe+qr+W2q/5QckMJugeyqdlv2/zdJPZjlRpc
         8ZD1XFg15V29YHkPmGdpyCEyxHmJAgOJ1LsqzaNTtnnPn68i+xfbPfrknywKGZn0aCOc
         KkWYRteFsVcMWwqg5Qgjv3fxu6hcKsvbpbT+lFNex2sNBe30sYDt4izdh787LW5FhuWr
         l0aaUK1BkNu553CdRgLYUAUruqWcLfzEhloGGBwXytTaZIzsIDc8kSOs4lIRYWaM02Wp
         aqng==
X-Gm-Message-State: AOPr4FVsmxVibBWUr8uVaA7sLtB6E0ak2d29ondi/FSDCV43WZE+OYQxeNEevRhkOwuWrA==
X-Received: by 10.98.74.142 with SMTP id c14mr16431952pfj.63.1463634486649;
        Wed, 18 May 2016 22:08:06 -0700 (PDT)
Received: from localhost.localdomain (47-35-3-42.dhcp.snlo.ca.charter.com. [47.35.3.42])
        by smtp.gmail.com with ESMTPSA id to9sm16078985pab.27.2016.05.18.22.08.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 May 2016 22:08:06 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295040>

Hey, all,

I asked about writing a portion of resumable clone about two months ago,
and decided to write the prime-clone program. I got bogged down by work
in the time since and have just gotten started working on the feature maybe
a week or two ago.

Anyway, I sent along a very rough version of prime-clone, with endpoints added
for http-backend and daemon. My hope is to use this as a jumping-off point to
create the prime_clone method for the client transport for .pack files only,
but I wanted to get some feedback about the configuration as I move along, as
I'm sure there are a lot of design considerations I missed, and I want to keep
this as easily extensible to the other types as possible.

Apologies for not keeping everyone in the loop. I should be working on this
more actively from this point onwards.

-Kevin Wern

--

[PATCH 1/2] Resumable clone: create git-prime-clone (Draft)
[PATCH 2/2] Resumable clone: add endpoints for prime clone (Draft)

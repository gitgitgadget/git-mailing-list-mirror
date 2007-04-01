From: "Srijak Rijal" <srijak@gmail.com>
Subject: Gittorent .. avahi ?
Date: Sun, 1 Apr 2007 13:59:43 -0400
Message-ID: <9d916d5b0704011059g31394159kfdd5e01ba81915c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 01 20:00:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HY4LU-0000Ha-G3
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 20:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933701AbXDAR7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 13:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933751AbXDAR7q
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 13:59:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:30258 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933701AbXDAR7p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 13:59:45 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1337224uga
        for <git@vger.kernel.org>; Sun, 01 Apr 2007 10:59:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l1CUZhNMWHUdDWopcsD8dR5sSDEaqzah/drOhixVSaZGOYnGkWg5DhfPwsp4rLe/Lpl4eJGbhau1dJNvJy+6d5+lC8hw/URZyy+gT2R4sQkZK9Yskov0IL8nIYNW+RF08MX0D3kvdNn7tL3xniI9je6FQEqFeUfg7WY14DLz3hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nZqISQ2AByZItd5+rStErmo9uOtimjASjHqOySNb3sgfhYIvzkDFMDKhWiw6sMRHRvs9NEck0Q+AIalpqK4kRkM/WCO5LAA0Dq2TsIW0RjwCqLgMjTPm+BEqCTFPOZJdCibH/44SvRjfYjHcg3QjLM+mpdyEGsnyv5FlJytX+Ss=
Received: by 10.82.186.5 with SMTP id j5mr6797286buf.1175450383830;
        Sun, 01 Apr 2007 10:59:43 -0700 (PDT)
Received: by 10.82.188.20 with HTTP; Sun, 1 Apr 2007 10:59:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43591>

Hi all,
I hope this is the right forum for this :).
 I hope to be able to implement the gittorrent client/ tracker during
GoogleSoc (if chosen :) ). I have been reading up on various git docs
and listserv messages to figure out what features I want in it in
addition to the basics. I have been concentrating especially on how to
minimise tracker load.
I was thinking about enabling avahi in the clients so that they can
find peers without putting that much extra load on the tracker.
A small caveat is that avahi timeout is around 50ms, so this sort of
dynamic peer discovery would probably turn out to work effectively
only among clients in the same LAN. However, best case scenario is
clients in the same LAN would have only a couple of clients talking to
the tracker and spreading the data(as well as peer list etc) in their
LAN.

To me, this feature seems be worth implementing if enough git users
are in the same LAN trying to get at a certain git repository.
What do you guys think ?

-Srijak

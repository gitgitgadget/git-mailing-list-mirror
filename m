From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Document clone of clone loosing branches?
Date: Sat, 14 Jun 2008 16:44:55 +0200
Message-ID: <4853D967.5080903@gmail.com>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
X-From: git-owner@vger.kernel.org Sat Jun 14 16:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7X0Q-0005XP-Ne
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 16:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbYFNOoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 10:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754854AbYFNOoc
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 10:44:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:27722 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbYFNOob (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 10:44:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2981119fgg.17
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=uT2FRZ5KX6ZWAArt3CrlRiCpTQ1maRu++4fmCQnDg2Y=;
        b=GjLmHcf81msBu4v34sdUQzu1pxjIv6FH389XU0tNRJyLjudy2q51qzSl1ZZRiBfBQ+
         K1hXvqvvuvTiZZ4Zs+RROZ0KvTY0v5YAXvMpOJsCZF/R7Lxm1qs1uQnSrsaG2kobcKNu
         vsk8ShjsTqF67uqw0bDMAMqkqx190TDOotAvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=jxkJm3iYrr+wwSBscbyR7399MpeQqtutQxK3VntvSWjy/wpu8hK0e9PthZywqyCnYN
         vqcm1SPdvztpGqyzxkFMUInR7sXDPrDyZxbqEUGjpXQdbJt2ohjBOXWS1toI5GH0xtP+
         05cPMflIvX6EgSXCVpnEaD1UqpToi+EgJgJwA=
Received: by 10.86.89.1 with SMTP id m1mr5825464fgb.20.1213454669786;
        Sat, 14 Jun 2008 07:44:29 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.200.93])
        by mx.google.com with ESMTPS id d6sm6369279fga.2.2008.06.14.07.44.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 07:44:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85018>

Vaclav Hanzl wrote:
> with naive belief that clone is a 1:1 copy or something close,
> nasty surprise can happen:

I got bitten by that, too.  Perhaps the intro paragraph of git-clone.txt 
(man git-clone) could mention that remote branches are not cloned or so. 
  (I don't know git-clone well enough to be able to phrase it 
accurately, but perhaps someone else wants to send a documentation patch...)

-- Lea

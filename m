From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: orphan blob or what?
Date: Fri, 09 Nov 2012 01:08:07 +0000
Message-ID: <1352423287-ner-8337@calvin>
References: <87a9urlj23.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
To: bruce <bruce.e.robertson@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 02:10:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWd6q-0008M6-7g
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 02:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376Ab2KIBJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 20:09:58 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:51903 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab2KIBJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 20:09:58 -0500
Received: by mail-ea0-f174.google.com with SMTP id c13so1286801eaa.19
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 17:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:in-reply-to:mime-version:date:message-id
         :content-type;
        bh=oc2N+AgfCxQSnehJtYoBvteo9uhUyDe4TwsaAYXZ1cY=;
        b=doeuH6YV6mzNH4A726Afgaigzet7Da0FdQdQOLcnNYVfxjknGuXni8TwJ/BOx0B+t4
         p7f0m2Vn0eEwyUUkamolb1XOVnqHqZ5eUN0CXCP4U8+cbJ4HaQKy4kYa4Ce9lG0vYToE
         vkBFrofBpXvrhWoMqD82djRqF9sn6sC2X+qyl5hBCljWrOOvMX2ukKEJHrmu6807SGl/
         bZ4WQDPtEUgkDgcu4yzOcGChh+TW8CLphcEoCSnAcfVQ8yelwkJ0Hnp6hfej/k0RGaHX
         mGuna4U0b6zD7YQX1W+1dnkqkPvEhLJ1PgT5Mg6SYgyZtexreZZFQoj/NqTeYVNVShfN
         C+Kg==
Received: by 10.14.172.195 with SMTP id t43mr32732484eel.17.1352423397146;
        Thu, 08 Nov 2012 17:09:57 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id c6sm73512059eep.17.2012.11.08.17.09.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Nov 2012 17:09:56 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 83D9D1581EA; Fri,  9 Nov 2012 01:08:07 +0000 (UTC)
In-Reply-To: <87a9urlj23.fsf@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209198>

On Thu, 08 Nov 2012 16:24:36 -0800, bruce <bruce.e.robertson@intel.com> wrote:
> In today's and older clones of https://github.com/mirrors/linux.git I
> find this object, 6fa98ea0ae40f9a38256f11e5dc270363f785aee, that I can't
> figure out how to eliminate^h^h^h^h^h^h^h^h^hget rid of. I don't see it
> in 'git fsck', 'git gc --aggressive --prune' doesn't seem to prune it,
> can't see it via 'git log'. And yet
> 
> linux/.git/objects/pack$ git verify-pack -v *.idx | grep 6fa98ea0ae40f9a38256f11e5dc270363f785aee
> 6fa98ea0ae40f9a38256f11e5dc270363f785aee blob   1519697 124840 515299673
> 8231eaa31ce1107c1463deb6ec33f61618aedbb9 blob   67 63 515424513 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee
> f21a8c1b9d47736fa4e27def66f04b9fe2b4bc53 blob   90 83 515424576 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee

Commit dee0bb9 (ASoC: Mark WM8962 Additional Control 4 register as volatile,
2010-09-29) references this blob.

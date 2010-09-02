From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 14:23:07 -0400
Message-ID: <20100902182307.GC9955@fearengine.rdu.redhat.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <20100902155810.GB14508@sigill.intra.peff.net>
 <AANLkTi=kO9USQYoTLQZyCRrjCHWRtPtd4S5EuFk4-gPv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, gitzilla@gmail.com,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 20:23:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrERU-0007mE-KC
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 20:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab0IBSXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 14:23:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51619 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297Ab0IBSXO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 14:23:14 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o82INAk8003809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 2 Sep 2010 14:23:10 -0400
Received: from fearengine.rdu.redhat.com (dhcp243-150.rdu.redhat.com [10.11.243.150])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o82IN7hK025715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 2 Sep 2010 14:23:09 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=kO9USQYoTLQZyCRrjCHWRtPtd4S5EuFk4-gPv@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155155>

On Thu, Sep 02, 2010 at 07:07:07PM +0100, Luke Kenneth Casson Leighton wrote:
> On Thu, Sep 2, 2010 at 4:58 PM, Jeff King <peff@peff.net> wrote:
> i think.... i think i miiight be able, hmmm... i believe it would be
> possible to implement this last option by creating separate .torrents
> for packs (one each!).  by splitting things down, so that pack objects
> are named as {ref}-{objref}-{SHA-1}.torrent and by providing a "top
> level" torrent which contains the refs/heads/* and the associate
> rev-list(s)... each set of rev-lists would have the SHA-1 of the
> pack-object that happened to be created (and shared) at that
> particular time, from that particular client: you then genuinely don't
> give a stuff about who has what, it's all the same, and...
> 

You seem to have some misconceptions about refs too. refs are absolutely
not common between two machines. The branch "master" on my box might
match the branch "linux-2.6" on git.kernel.org. And it might be from two
days ago.

A ref is just an annotation in /one particular repository/ that a
particular commit is interesting to it for some reason.

--CJD

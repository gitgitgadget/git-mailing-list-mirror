From: Olaf Hering <olaf@aepfle.de>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Fri, 14 Nov 2014 11:30:13 +0100
Message-ID: <20141114103013.GC2549@aepfle.de>
References: <20141113111444.GA15503@aepfle.de>
 <20141113154457.GA31624@aepfle.de>
 <20141113160325.GA24351@paksenarrion.iveqy.com>
 <20141114101427.GA1548@aepfle.de>
 <20141114102423.GB24351@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 11:30:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpE91-00073a-2k
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 11:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029AbaKNKaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 05:30:17 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:22247 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbaKNKaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 05:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1415961014; l=755;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=yzBkjg78EtaWDiI+Mi6jOch6jTA=;
	b=o9EnS958ZRO052fGmHAHS31FvT7U+5j03d62cYZG1gUYcXJuc92ke9eq/nQPcmk8x69
	2pbW6uhFsLOlGH5M2cDhgHX7qsm0PMy84DhHz+2l5Lxklt8ATiSRCRIxeL0UkwVlaDdc5
	tDst+pWPosP0MwzuG2kU7IcZzIkAnDr1MZk=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIZST8ulOSUJqstS8YMAWN1YEmXTnspMxV9Qxw==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1088:9901:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.11 AUTH)
	with ESMTPSA id i0307aqAEAUE099
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Fri, 14 Nov 2014 11:30:14 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id BEEF450172; Fri, 14 Nov 2014 11:30:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141114102423.GB24351@paksenarrion.iveqy.com>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, Fredrik Gustafsson wrote:

> On Fri, Nov 14, 2014 at 11:14:27AM +0100, Olaf Hering wrote:
> > So my repo-master is now "bare". I pushed from repo-branchA into
> > repo-master and see my commits in both repos. But pushing from
> > repo-master to the remote fails because repo-master does not have
> > outstanding remote commits. However, git fetch doesnt do anything:
> 
> Are you mixing up your branches? So that you're updating one branch in
> your master repo but trying to push an other branch to your remote repo?

I dont think so. I have branchA in repo-branchA, and a 'git push origin
branchA' puts it into repo-master. 
How is a bare repo supposed to be updated? Is a simple 'git fetch --all'
supposed to work?

Olaf

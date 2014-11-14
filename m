From: Olaf Hering <olaf@aepfle.de>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Fri, 14 Nov 2014 11:54:18 +0100
Message-ID: <20141114105417.GA8954@aepfle.de>
References: <20141113111444.GA15503@aepfle.de>
 <20141113154457.GA31624@aepfle.de>
 <20141113160325.GA24351@paksenarrion.iveqy.com>
 <20141114101427.GA1548@aepfle.de>
 <20141114102423.GB24351@paksenarrion.iveqy.com>
 <20141114103013.GC2549@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 11:54:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpEWJ-0001RJ-FD
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 11:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965360AbaKNKyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 05:54:22 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:62663 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965194AbaKNKyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 05:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1415962458; l=993;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=BROkDWZLnUtfDRODS0Xznk3LjLk=;
	b=UUA5KSrQsMDn/EvJc6IsDPN86F+Dpk38Rw8iKQ/AAfW40fTqw/DL4qgnJiSl1EmVDj8
	GvzSQRxtl1V6LoCvXGzDV3E46QoKs4fSekiNptWIUqLxKKAiJkho085nmpggWlO3WBQM2
	gUh+Pshh3q0O69Gyg0h8w7HuomWh27xAAps=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIZST8ulOSUJqstS8YMAWN1YEmXTnspMxV9Qxw==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1088:9901:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.11 AUTH)
	with ESMTPSA id 604750qAEAsIwCR
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Fri, 14 Nov 2014 11:54:18 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 4804250172; Fri, 14 Nov 2014 11:54:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141114103013.GC2549@aepfle.de>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 14, Olaf Hering wrote:

> On Fri, Nov 14, Fredrik Gustafsson wrote:
> 
> > On Fri, Nov 14, 2014 at 11:14:27AM +0100, Olaf Hering wrote:
> > > So my repo-master is now "bare". I pushed from repo-branchA into
> > > repo-master and see my commits in both repos. But pushing from
> > > repo-master to the remote fails because repo-master does not have
> > > outstanding remote commits. However, git fetch doesnt do anything:
> > 
> > Are you mixing up your branches? So that you're updating one branch in
> > your master repo but trying to push an other branch to your remote repo?
> 
> I dont think so. I have branchA in repo-branchA, and a 'git push origin
> branchA' puts it into repo-master. 
> How is a bare repo supposed to be updated? Is a simple 'git fetch --all'
> supposed to work?

Is there s a slim chance that I have to fetch in repo-master before
doing a git push in repo-branchA? git remote show origin shows that some
branches are out of date.

Olaf

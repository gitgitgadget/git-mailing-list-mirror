From: Olaf Hering <olaf@aepfle.de>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Fri, 14 Nov 2014 12:24:28 +0100
Message-ID: <20141114112428.GA12702@aepfle.de>
References: <20141113111444.GA15503@aepfle.de>
 <20141113154457.GA31624@aepfle.de>
 <20141113160325.GA24351@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 12:24:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpEzT-0007rl-BI
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 12:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbaKNLYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 06:24:31 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:23740 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965074AbaKNLYa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 06:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1415964269; l=355;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=7X38VA7syJJbrY+d2tVrab3QC7Q=;
	b=vSPp12pyJz4fekU2yvmotwNH+HPs+Pea/jDxgig1FYn/uKnDNK6FFItKkFY40iRm22a
	G3FPCpT52zITQvc1IpYL79J8q82Zw52EMKiWyuMI3/K2IVkXblE/23mQfLAzXk8iDeUF0
	lideyyRefy96It1uzK7hDbyTIxk9W6hYlWI=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIZST8ulOSUJqstS8YMAWN1YEmXTnspMxV9Qxw==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1088:9901:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.11 AUTH)
	with ESMTPSA id R0409dqAEBOSzsa
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Fri, 14 Nov 2014 12:24:28 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 5E13750172; Fri, 14 Nov 2014 12:24:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141113160325.GA24351@paksenarrion.iveqy.com>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, Fredrik Gustafsson wrote:

> That's one of the reason it's not recommended to push into a non-bare
> repository. You should clone your repo-master with the --bare option to
> avoid having a work dir there.

Even if I do a fresh clone with --bare, the result can not be updated
anymore with git fetch. What I'm doing wrong?

Olaf

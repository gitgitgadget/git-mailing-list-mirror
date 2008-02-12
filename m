From: Tommy Thorn <tommy-git@thorn.ws>
Subject: Re: [PATCH 2/3] git-p4: support exclude paths
Date: Tue, 12 Feb 2008 07:53:38 -0800
Message-ID: <47B1C102.7020400@thorn.ws>
References: <48092.216.228.112.21.1199496008.squirrel@numba-tu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 16:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOxSq-0001r3-Vz
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 16:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbYBLPx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 10:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbYBLPx6
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 10:53:58 -0500
Received: from server204.webhostingpad.com ([69.65.0.218]:56009 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752748AbYBLPx5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 10:53:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=thorn.ws;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir;
	b=Da9r23SWMzUQoLqoMs4XEDlowddPuJniEnmhVrt3aoe95vfWLee6nfY4QSnamArn/5O1qaXSu6I5fXdB57lH+2lRAytbGe71rHj5A1w9bmCgu3SSTdbPRnY51iXI0CUo;
Received: from 208.65.183.75.static.etheric.net ([208.65.183.75] helo=silver.numba-tu.com)
	by server204.webhostingpad.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JOxS3-0002Qs-Li; Tue, 12 Feb 2008 09:53:43 -0600
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <48092.216.228.112.21.1199496008.squirrel@numba-tu.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73669>

On Sunday 03 February 2008 10:21:05 I wrote:
> Teach git-p4 about the -/ option which adds depot paths to the exclude
> list, used when cloning. The option is chosen such that the natural
> Perforce syntax works, eg:
>
>   git p4 clone //branch/path/... -//branch/path/{large,old}/...
>
> Trailing ... on exclude paths are optional.
>
> This is a generalization of a change by Dmitry Kakurin (thanks).
>
> Signed-off-by: Tommy Thorn <tommy-git@thorn.ws>

.. to which Simon replied:
> Acked-By: Simon Hausmann <simon@lst.de>
>
> I like it, Perforce'ish syntax. (Not that I like p4 though ;)

Alas, this change needs more work - the exclude paths needs to 
be maintained in the commit messages as otherwise we pull in new
files in the excluded path. I haven't done this yet.

However, the other patch (git-p4: no longer keep all file contents while cloning)
is IMO critical. You simply cannot clone a non-trivial Perforce repository 
without it. Why is this being ignored? Are there no users of git-p4?


Tommy

**

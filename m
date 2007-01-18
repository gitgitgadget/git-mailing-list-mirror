From: Jim Treadway <jim@stardot-tech.com>
Subject: Re: [PATCH 1/2] Document the master@{n} reflog query syntax.
Date: Wed, 17 Jan 2007 18:30:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701171829240.27034@elephant.stardot-tech.com>
References: <20070118020804.GA23488@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 03:44:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7NGd-0008AR-Iv
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 03:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXARCoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 21:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbXARCoU
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 21:44:20 -0500
Received: from elephant.stardot-tech.com ([65.60.123.67]:33113 "EHLO
	elephant.stardot-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXARCoT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 21:44:19 -0500
X-Greylist: delayed 849 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 21:44:19 EST
Received: from elephant.stardot-tech.com (localhost [127.0.0.1])
	by elephant.stardot-tech.com (8.13.8/8.13.8) with ESMTP id l0I2U5ON027424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jan 2007 18:30:05 -0800
Received: from localhost (jim@localhost)
	by elephant.stardot-tech.com (8.13.8/8.13.8/Submit) with ESMTP id l0I2U5Ps027421;
	Wed, 17 Jan 2007 18:30:05 -0800
X-Authentication-Warning: elephant.stardot-tech.com: jim owned process doing -bs
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070118020804.GA23488@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37059>

On Wed, 17 Jan 2007, Shawn O. Pearce wrote:

> In ab2a1a32 Junio improved the reflog query logic to support
> obtaining the n-th prior value of a ref, but this was never
> documented in git-rev-parse.  Now it is.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> Documentation/git-rev-parse.txt |   10 +++++++++-
> 1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 4eaf5a0..7bfbe1b 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -148,10 +148,18 @@ blobs contained in a commit.
>   enclosed in a brace
>   pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
>   second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
> -  of the ref at a prior point in time.  This suffix may only be
> +  of the ref at a prior point in time.This suffix may only be

I'm guessing that the above was unintentional?

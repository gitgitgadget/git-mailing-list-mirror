From: Tommy Thorn <tommy-git@thorn.ws>
Subject: Re: [PATCH] git-p4: Fix indentation from tab to spaces
Date: Mon, 04 Feb 2008 14:18:35 -0800
Message-ID: <47A78F3B.5090002@thorn.ws>
References: <87fxw8mp2w.fsf@nav-akl-pcn-343.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Toby Allsopp <Toby.Allsopp@navman.co.nz>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:19:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM9eh-0001iS-Vm
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 23:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbYBDWSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 17:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753792AbYBDWSf
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 17:18:35 -0500
Received: from server204.webhostingpad.com ([69.65.0.218]:58462 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753311AbYBDWSf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 17:18:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=thorn.ws;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir;
	b=uuFFk9QujBAu6yitvg11cbLDUYdYDqy1E2EwIKqPmv39BKYeS0KWJaKcAgp4fqXQ3JvUSqxajKMP5eX2d6O3SM9n2C2nlioQKY20JE/Ye7IIPM38jt4T46NAjkObVEd/;
Received: from 208.65.183.75.static.etheric.net ([208.65.183.75] helo=silver.local)
	by server204.webhostingpad.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JM9e3-00065s-EY; Mon, 04 Feb 2008 16:18:31 -0600
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <87fxw8mp2w.fsf@nav-akl-pcn-343.mitacad.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72579>

Toby Allsopp wrote:
> Signed-off-by: Toby Allsopp <toby.allsopp@navman.co.nz>
> ---
>  contrib/fast-import/git-p4 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index c17afae..781a0cb 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1646,7 +1646,7 @@ class P4Clone(P4Sync):
>          depotPath = args[0]
>          depotDir = re.sub("(@[^@]*)$", "", depotPath)
>          depotDir = re.sub("(#[^#]*)$", "", depotDir)
> -	depotDir = re.sub(r"\.\.\.$", "", depotDir)
> +        depotDir = re.sub(r"\.\.\.$", "", depotDir)
>          depotDir = re.sub(r"/$", "", depotDir)
>          return os.path.split(depotDir)[1]
>  
>   
Acked-by: Tommy Thorn <tommy-git@thorn.ws>

I'm not sure that happend, but I did have some issues sending the patch 
that should be fixed now.

Nobody commented on the most important one - the fix for git-p4 memory 
appetite.

Tommy

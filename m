From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] git-repack-script: Add option to repack all objects.
Date: Mon, 29 Aug 2005 14:29:40 -0400
Message-ID: <43135414.6080400@gmail.com>
References: <43102727.2050206@tuxrocks.com>	<7vbr3hlqjs.fsf@assigned-by-dhcp.cox.net>	<4312BC27.9010604@tuxrocks.com>	<7vvf1obsfc.fsf@assigned-by-dhcp.cox.net> <7vll2kbqa4.fsf_-_@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 20:32:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9oOH-0006Yt-7O
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 20:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVH2S3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 14:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVH2S3u
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 14:29:50 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:30748 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751276AbVH2S3t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 14:29:49 -0400
Received: by wproxy.gmail.com with SMTP id 57so690818wri
        for <git@vger.kernel.org>; Mon, 29 Aug 2005 11:29:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IuhzXKdI89HXwbVk7PO/k32a3XcVpBnAvd2pejW2EzEWJS/1UbRR13DPVTFD1ZqWSQnWezmkma9pTRy6lN3J7+YZLAlzC1EBXlI4MBiEsJd4n5eTRJWGSHe/EUM9j67Hd6BQ6Td9MJnsRra/ba7Gg90QjKFxBc8XHKNYxdgRGQ0=
Received: by 10.54.18.56 with SMTP id 56mr2472181wrr;
        Mon, 29 Aug 2005 11:29:49 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 26sm11316041wrl.2005.08.29.11.29.46;
        Mon, 29 Aug 2005 11:29:48 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Frank Sorenson <frank@tuxrocks.com>
In-Reply-To: <7vll2kbqa4.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7916>

Junio C Hamano wrote:
> This originally came from Frank Sorenson but with a bit of
> rework to allow future enhancement to the command without
> changing the external interface for removal part.
> 
> With the '-a' option, all objects in the current repository are
> packed into a single pack.  When the '-d' option is given at the
> same time, existing packs that were made redundant by this round
> of repacking are deleted.
> 
> Since we currently have only two repacking strategies, one '-a'
> (everything into one) and the other not '-a' (incrementally pack
> only the unpacked ones), '-d' is meaningful only used with '-a'
> and removes all the existing packs before repacking for now.
> 
[Rest of updated patch snipped]

Frank,

Can you produce a patch to update the git-repack-script documentation to 
reflect the new functionality?

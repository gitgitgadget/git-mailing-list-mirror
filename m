From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: Fix merge detecting with rewrite-root
Date: Sat, 13 Mar 2010 01:43:56 -0800
Message-ID: <20100313094355.GA10052@dcvr.yhbt.net>
References: <1267034942-31581-1-git-send-email-tuomas.suutari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Tuomas Suutari <tuomas.suutari@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 10:44:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqNt4-0005Co-KR
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 10:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448Ab0CMJn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 04:43:57 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36048 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480Ab0CMJn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 04:43:56 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0DA1F4ED;
	Sat, 13 Mar 2010 09:43:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1267034942-31581-1-git-send-email-tuomas.suutari@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142096>

Tuomas Suutari <tuomas.suutari@gmail.com> wrote:
> Detecting of merges from svn:mergeinfo or svk merge tickets failed
> with rewrite-root option. This fixes it.
> 
> Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>

> With this patch the merge detecting works also with rewrite-root
> option, but since there are no comments why the $self->rewrite_root
> was used in the first place, I have no idea, if this is the right
> thing to do.

Thanks Tuomas, and Sam for the clarification,

This series acked and pushed out to git://git.bogomips.org/git-svn

-- 
Eric Wong

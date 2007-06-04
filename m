From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT RFC PATCH 0/2] Fixing the rebase safeguard
Date: Mon, 4 Jun 2007 23:41:36 +0100
Message-ID: <b0943d9e0706041541i74f5dccct9f66a7dca1f1ffea@mail.gmail.com>
References: <20070603133006.1681.1742.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 00:41:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvLFC-0005PJ-Kd
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 00:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbXFDWli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 18:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756358AbXFDWli
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 18:41:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:62415 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbXFDWli (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 18:41:38 -0400
Received: by ug-out-1314.google.com with SMTP id j3so4365ugf
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 15:41:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uom1ASq+dj88LuJgVSM04hnW2nn/BkHFoW8Je8IHrGrMSI+hwIKiuVTJ06UIseB25ThngLZfyzsrxI7CoNBhoNy+24lHCxcdu5Oy7D324AG1MuUoXnCgI+6z9EMK22cXNq31FVadJtQaVrrz17RorH/L57nGRhaxIuvmLQppl9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T4EXR5sFm0GKPZPryp7CpTi2pRaUQmJH5CmzX/xMGO/FL1pfwMrt4TEj/D9OfnAC80aYa8F8NOXv8g9Qglb7YWpvWHofNvHqAHYKDTm+k/hE3504ZsOqqP1IRz4LUps0ZT0TawEtB7TX4dE/gL9J564dJB+TAI/Jo6TscWIBIZA=
Received: by 10.67.40.12 with SMTP id s12mr13651ugj.1180996896772;
        Mon, 04 Jun 2007 15:41:36 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Mon, 4 Jun 2007 15:41:36 -0700 (PDT)
In-Reply-To: <20070603133006.1681.1742.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49138>

On 03/06/07, Yann Dirson <ydirson@altern.org> wrote:
> This is an attempt at using a reachability test to replace the use of
> orig-base, to decide when it is safe to accept a rebase.
[...]
> - using ORIG_HEAD, but then, how do we decide when it is valid to do
>   so ?

I think using the ORIG_HEAD was the initial behaviour of StGIT. I
didn't have any problems as I am only following one tree (Linus'
mainline kernel) but other users might have different scenarios.

-- 
Catalin

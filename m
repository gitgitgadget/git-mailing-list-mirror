From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT munged path on refresh
Date: Mon, 4 Jun 2007 16:35:30 +0100
Message-ID: <b0943d9e0706040835u3224cd02x9c129871441a5480@mail.gmail.com>
References: <4663CC54.7090203@warmcat.com> <4663EB48.3020302@warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Green" <andy@warmcat.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 17:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvEav-0002t8-3z
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 17:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbXFDPfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 11:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbXFDPfh
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 11:35:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:57755 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbXFDPfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 11:35:36 -0400
Received: by ug-out-1314.google.com with SMTP id j3so790132ugf
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 08:35:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DsNSbPmuvc7a4wI59V1z442+vaIhJxMg7vTMKFK2KbblIWnEDXVRcEKw4AVwRcwovvu8w5S6G1siskKHrUrMbtxGN/ByrM6fXuC+ecIZN6Hry2kgJq5FzXnCACi1tQgvklhjRchwyJrzKxT1ORN35PoJKAz0k/AsOLtQsxdu7cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C07uk7iVbC5KU02cOHtGvGVy/vF/FLDcDGl9bihg/L3P2hGanj1cggWh9BTcjDqzU/4cF/btgCn+NoM5srJrZQNcIoetN6HUiivbsDMSZrG02fy1Ew7dRFFR4Fz7s2RANzptMyGGFUk0SsL6PQz+u3nUHvnsWLc4B1FtMHpMLEs=
Received: by 10.67.27.15 with SMTP id e15mr3182377ugj.1180971330829;
        Mon, 04 Jun 2007 08:35:30 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Mon, 4 Jun 2007 08:35:30 -0700 (PDT)
In-Reply-To: <4663EB48.3020302@warmcat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49107>

On 04/06/07, Andy Green <andy@warmcat.com> wrote:
> Andy Green wrote:
>
> > I have been using quilt with some success and now I am trying to migrate
> > to stgit.  I can get started okay with stg init and stg new "mypatch",
>
> Sorry for the noise -- I found this is a FAQ, you currently have to do
> the refresh at the top of the tree, unlike in quilt.

Fixing StGIT to run correctly in subdirectories is on my to-do list,
only that I haven't had time to look at it yet.

-- 
Catalin

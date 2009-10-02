From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/2] allow mangling short options which take integer
	arguments
Date: Fri, 2 Oct 2009 09:43:17 +0200
Message-ID: <20091002074317.GB9444@localhost>
References: <20090925233226.GC14660@spearce.org> <20091001201648.GA12175@localhost> <20091001202301.GB12175@localhost> <alpine.DEB.1.00.0910012354080.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 02 09:43:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtcnU-0001k8-3g
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 09:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbZJBHnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 03:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbZJBHnO
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 03:43:14 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:49268 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbZJBHnN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 03:43:13 -0400
Received: by fxm27 with SMTP id 27so761889fxm.17
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 00:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=euWFpDD94NX6tsNUw+UGnnpS6ODRF58B1W0AqDvX11I=;
        b=rkY4qlgFc8+uOhyZoza7nAeXnoUNFlmO7lXlBhFXzYNg+G5Dj6ussTgl9obLc/JWbB
         kvv6DwtnZIr8V5qkwLVkuPCsAFHxKGtiK28hVn4sTCl7JJXxndidZ9SQpBJzh2Z+sDAy
         gSiAkAuOCEDvmd8sdQ04Bacb0jWJk2D48KveY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Htum9siGMVi6OpLZll21va/SCAjzHtbK2O08QdzdBCEroaFA6MDMQ45JeoXUB+mFg0
         3a4ot7eQPpS1bhIKO3BX/oNS4K2kEnf1nNTCuIheXIOKKR8C9WFjZzFoSrbhbMrsjb4X
         nPfAOaPt4v+IZLUXizuh3XKpU/cJjSyPtfVJs=
Received: by 10.204.154.142 with SMTP id o14mr892656bkw.125.1254469396535;
        Fri, 02 Oct 2009 00:43:16 -0700 (PDT)
Received: from darc.lan (p549A5168.dip.t-dialin.net [84.154.81.104])
        by mx.google.com with ESMTPS id 20sm1119611bwz.42.2009.10.02.00.43.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 00:43:15 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MtcnN-0004J8-Ix; Fri, 02 Oct 2009 09:43:17 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0910012354080.4985@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129423>

On Thu, Oct 01, 2009 at 11:55:03PM +0200, Johannes Schindelin wrote:

> And this patch looks even more straight-forward than 1/2, _but_... what 
> about cases where there are short options that are digits?

Could you point me to one of those? I did not find any during my
non-exhaustive search. We should be able to handle them easily by adding
PARSE_OPT_MANY.

Clemens

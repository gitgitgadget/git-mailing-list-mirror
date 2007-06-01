From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make the installation target of git-gui a little less chatty
Date: Fri, 1 Jun 2007 09:36:08 +0200
Message-ID: <81b0412b0706010036i3f8295fbob3dda2e82e9ef207@mail.gmail.com>
References: <20070531222527.GB12204@steel.home>
	 <20070601030257.GX7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 09:36:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu1gV-0006B0-61
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 09:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbXFAHgN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 03:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756136AbXFAHgN
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 03:36:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:9069 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbXFAHgM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 03:36:12 -0400
Received: by wr-out-0506.google.com with SMTP id i21so403416wra
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 00:36:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D1RviwDtVjKzISK+9MBwQOeBKK9uD42l9VrN4O2G0pSA6yKathwyOZF8/WKq4w/3aWMeiLPOhQFnfv+b7TllAiUPF8OB06qFli1mL6zG8cX+1HAwEwifbhLc4m5TMlrTmBVBzc2x9xhCxquaziNtiUz9al+URVA+oSrlKCevG/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YBvzaa5MeyYKElVAWf2aCa8zCdQzt+5yQmBa62Vl6x+wmAxHGA1saC09C2tm5NYmFd8H01equM6TImm3BCEU2oo3g+ONb/KNnzLFHg3VXjx9gcmRx4WD4JV+cH6NjN+byCcDbFZkSXqDs6qdQlpbXxvs8TrWDsGkeMHe1wL28kc=
Received: by 10.78.193.19 with SMTP id q19mr996981huf.1180683368100;
        Fri, 01 Jun 2007 00:36:08 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Fri, 1 Jun 2007 00:36:08 -0700 (PDT)
In-Reply-To: <20070601030257.GX7044@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48848>

On 6/1/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > The patch is hand-tuned to start in git-gui, so that it can be applied
> > in git-gui repo.
>
> Hand-tuning the patch isn't necessary, just making the change its
> own patch is all that is required.  Git has these nifty flags for

Good to know

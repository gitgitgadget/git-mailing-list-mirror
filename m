From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Question about handling of heterogeneous repositories
Date: Thu, 1 Dec 2005 09:16:06 +0100
Message-ID: <81b0412b0512010016k202e3888ube5dae91c90cc5bb@mail.gmail.com>
References: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com>
	 <200511301540.34776.Josef.Weidendorfer@gmx.de>
	 <81b0412b0511300701w71da125am2dcc896b4693f37f@mail.gmail.com>
	 <200511301749.18073.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 01 09:17:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehjc6-0002pt-5h
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 09:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVLAIQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 03:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVLAIQJ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 03:16:09 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:1126 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751388AbVLAIQI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 03:16:08 -0500
Received: by nproxy.gmail.com with SMTP id x4so59148nfb
        for <git@vger.kernel.org>; Thu, 01 Dec 2005 00:16:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VXztmIyCTTjEoxt9xGbBkuYzGhYKnWWNT/xb4+H/nkgYgoC7vY6m4/RvsJolvql+dESs+2fSuNdxi+B3v0y9jgUzCe2EAlCg/XPMVAB+1Dp1dKyv7g2pbzEAV5FWM80HZuS/yNL9OTFjblqX8/lY2GTZIwse1raXOPXiDkZapyM=
Received: by 10.49.42.5 with SMTP id u5mr182372nfj;
        Thu, 01 Dec 2005 00:16:06 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 1 Dec 2005 00:16:06 -0800 (PST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511301749.18073.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13041>

On 11/30/05, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> git-mv would have to do exactly something like this to detect
> inter-repo renames at all ;-)
> But in general, this is really messy.

That's is what I'm most afraid of.

> See my suggestion in a previous thread with similar topic
>  http://www.gelato.unsw.edu.au/archives/git/0511/12028.html

Oh, thanks! Pity, I missed that discussion,
Pasky's subprojects is exactly what I am looking for.

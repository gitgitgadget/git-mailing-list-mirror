From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 08:06:08 -0500
Message-ID: <30e4a070801110506h19b77488sbfa6ae48701f30f9@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 11 14:06:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDJb0-0006uj-1k
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 14:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758100AbYAKNGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 08:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758055AbYAKNGK
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 08:06:10 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:59313 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757921AbYAKNGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 08:06:09 -0500
Received: by nz-out-0506.google.com with SMTP id s18so617041nze.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 05:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wi0sDv2U0etvEmazzHqXSU3MrbwCV4rxL5cINaNbHT8=;
        b=XAzl9LY1bNODNoogDJS6+2MWpRzw0HoKc36vLdi37SVrHBhr2geOJInAHBv1pGDZXcw043Dgu0u/HEA5WsNR+dCIh0jGxGK2T5U+AAR3Qljgw9DS/rruYueysgqisPPqZX3KF87Jokny9dGyqOvVYyEEhmkJmr4nHZOQ+rRKD+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KfYxLkKUSQ+aTuK5ftC2DcejIedl7eMwZ2It3H/p9whtA7tDyEvDPabsvzNm+1I7a+muKxuSLht3+br/4BIbd9ZIKScQAYP0RQ4nG0j02zCEsVcXK/FuPcXYnbUjQhq0dGCNT1RFC3euHs+vW/7ZF9uEPB6X/3KDCgzk4Iyju14=
Received: by 10.142.162.5 with SMTP id k5mr1579373wfe.171.1200056768195;
        Fri, 11 Jan 2008 05:06:08 -0800 (PST)
Received: by 10.143.159.5 with HTTP; Fri, 11 Jan 2008 05:06:08 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70156>

On Jan 11, 2008 7:03 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> IIUC your patch only replaces the term "origin" by something
> user-specifiable.  I fail to see the use of it; care to explain what
> workflow is easier with your patches than without?
>
> Ciao,
> Dscho

Consider a project with several servers, each of which is *supposed*
is host the same project but due to lags in mirroring across airgaps,
etc., are never quite in sync. Now, we get on a teleconference and
discuss issues, find differences, and everyone reports that "origin"
has x, but in fact "origin" means different servers to almost
everyone. Also consider that only a small subset of the group really
understands git, most just follow cook-book recipes to get their work
done and don't understand what is going on.

This is my problem: "origin" is an abstraction that hides the
different server names in use and makes communication difficult,
having everyone use nicknames related to their particular upstream
server reduces the confusion.

Mark

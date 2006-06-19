From: Matthias Hopf <mhopf@suse.de>
Subject: Re: git-rebase nukes multiline comments
Date: Mon, 19 Jun 2006 11:36:23 +0200
Message-ID: <20060619093623.GA15209@suse.de>
References: <20060616171251.GA29820@suse.de> <4492E8F9.4000106@shlrm.org> <4492F09F.9080906@shlrm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: xorg@lists.freedesktop.org
X-From: git-owner@vger.kernel.org Mon Jun 19 11:36:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsGBM-0006WR-OU
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 11:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWFSJga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 05:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWFSJga
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 05:36:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:5074 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932318AbWFSJg3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 05:36:29 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 833C41EBAA;
	Mon, 19 Jun 2006 11:36:24 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, xorg@lists.freedesktop.org
Content-Disposition: inline
In-Reply-To: <4492F09F.9080906@shlrm.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22124>

On Jun 16, 06 12:55:43 -0500, David Kowis wrote:
> > I'm new to git, but I tried what you said.
> > my git log:
> > commit c846bea8c61bec7cf0f7688c48abc42577b9ac7f
> > Author: David Kowis <dkowis@kain.org>
> > Date:   Fri Jun 16 12:20:08 2006 -0500
> > 
> >     this is a multi
> > 
> >     line comment
> >     with three lines
> > 
> > 
> > I'm using git 1.4.0. It added a blank line in there...

O-key. Did this work w/o a blank line as well? Then we can assume this
solved in 1.4.0. Now there's still the question whether the log messages
in the upstream archive can be restored...

> I'm going to note that the xorg ML cc doesn't work for anyone not
> subscribed... You may miss out on replies.

I'm subscribed here as well :-)
I just CC'ed xorg so people over there know about the issue as well.

CU

Matthias

-- 
Matthias Hopf <mhopf@suse.de>       __        __   __
Maxfeldstr. 5 / 90409 Nuernberg    (_   | |  (_   |__         mat@mshopf.de
Phone +49-911-74053-715            __)  |_|  __)  |__  labs   www.mshopf.de

From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: [PATCH] git-svn: try to read the dcommit url from the config file
Date: Sun, 22 Feb 2009 22:41:56 +0100
Message-ID: <200902222241.56223.kumbayo84@arcor.de>
References: <200902191930.10139.kumbayo84@arcor.de> <20090221120815.GA8145@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 22 22:45:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbM8G-0001wp-VD
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 22:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbZBVVne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 16:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbZBVVnd
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 16:43:33 -0500
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:37125 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752481AbZBVVnd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 16:43:33 -0500
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 42CA5E3E29;
	Sun, 22 Feb 2009 22:43:31 +0100 (CET)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 2943E724268;
	Sun, 22 Feb 2009 22:43:31 +0100 (CET)
Received: from oberndorfer.lan (91-114-178-83.adsl.highway.telekom.at [91.114.178.83])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-05.arcor-online.net (Postfix) with ESMTPSA id BADCC332C0F;
	Sun, 22 Feb 2009 22:43:30 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.6.0 mail-in-05.arcor-online.net BADCC332C0F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1235339010; bh=Bub8kFJ3EMWclhnRKYOa5lyHIDxAEk26+IlgKhOGpv8=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Message-Id:Content-Type:Content-Transfer-Encoding; b=p6csEXK/1g4xF
	l+dswfXJi8i4xnvXgKh2oPFrsotR+vnRvxPx2NlJx7ZKpAHVKbngzI3q5KWNcjjqgrr
	obOnWH2XFrFLypzlGhIzhM8fvQA+Lb5HP+E/FUQfIUrA4bEd8Pxx2ip7cYmQe3mK2w9
	Jhh4ACkTqqSosZO38osCm7dE=
User-Agent: KMail/1.9.7
In-Reply-To: <20090221120815.GA8145@dcvr.yhbt.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.94.2/9024/Sun Feb 22 22:05:07 2009 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111061>

On Samstag 21 Februar 2009, Eric Wong wrote:
> Peter Oberndorfer <kumbayo84@arcor.de> wrote:
> > The commit url is determined in the following order
> > --commit-url commandline
> 
> actually, it should look in the .git/config for this, too:
> 
>   svn.commiturl
> 

I did not see that the commandline options are also searched in the config.
Also this option does not seem to be documented.
Should i document svn.commiturl in dcommit or is that just a implementation detail.

> > svn-remote.<name>.dcommiturl
> 
> Of course, having a per-svn-remote commiturl can be useful, too.
> 
> Though I'd call it "commiturl" instead of "dcommiturl" to match the
> existing config setting.  The not-often-used "set-tree" command could
> probably be updated to use these config options, too...
> 

sorry, i do not understand enough of perl/git-svn to do this :-(

> I'll ack this patch with "dcommiturl" replaced with "commiturl".
> 

OK, will resend the patch once i know if i should document svn.commiturl.

> > svn-remote.<name>.url
> > 
> > Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
> > ---
> > 

Greetings Peter

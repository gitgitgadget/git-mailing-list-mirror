From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: Project Hosting with git ?
Date: Sat, 12 Jan 2008 11:45:35 -0500
Message-ID: <9b3e2dc20801120845n15d59fe6q178ba257c12a28e0@mail.gmail.com>
References: <912ec82a0801120553u3621c991u7c4cb4793960159c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Neshama Parhoti" <pneshama@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 17:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDjUj-0002Gm-Kc
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 17:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbYALQph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 11:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753848AbYALQph
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 11:45:37 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:53112 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbYALQpg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 11:45:36 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1265403rvb.1
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 08:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fBR/b8FfQDiLWpq/QJakrmsPJSCL2BotNudCZPuBS44=;
        b=ZYg7n1NatqnUABZbD5F38JV4AeZA5X2zIEDmhyAzYhsMjwIuYYGJbCaIFBxPsDIiClNu0qkpQP3RGPjMdq6MiSdGhX8QMMJdG/2YbT1yxsC5szIxpNwRj19KXLTOqpBUMWzNZSN/lefQlTrqfE2OvZuqGjWDf9DlhvIxrvNWfsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UqOlATuWJ8Ycp0PliQd4wL8Ep7+OZBqMJne3yBU7BhkInfMjmoasg6uBBF4mVlzH1RMQx2T+hqM2zKQOBwAjGHdBBiU8dUjg9VIw84jJ8+OpOw56pG8jBWIIONFDSSaBCKa8uEcgbzfc8U/DPUxUY2K/CfChu9i2mL2vPAbjJOE=
Received: by 10.141.62.15 with SMTP id p15mr2752793rvk.159.1200156335472;
        Sat, 12 Jan 2008 08:45:35 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Sat, 12 Jan 2008 08:45:35 -0800 (PST)
In-Reply-To: <912ec82a0801120553u3621c991u7c4cb4793960159c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70330>

> I mean, if I open a SourceForge project, I have to use cvs/subversion right ?
>
> Is there any way to use git ?

There is currently an open feature request on sourceforge for git support.
Please feel free to add a comment to the thread, hopefully if enough
people do so they'll do something about it.
(Though I wouldn't be surprised if they're working on it.)

https://sourceforge.net/tracker/?func=detail&atid=350001&aid=1828327&group_id=1

However, git works fine over http.  I have a project on SF which I was
using with subversion, but I recently switched the project over to
git.

I simply posted a bare git repo on the project website, and bang it's
"hosted" on sourceforge.  In order to automate things a bit, I set up
a local repo which, when I push to it, runs git-update-server-info and
then uses rsync to upload the repo changes to the SF web server.

It seems to work fine.  I do occasionally git-clone the http-hosted
repo just to make sure things are still working, and so far no
problems.

The downside is that SF will not collect statistics on the git repo.
However, I've been using ohloh.net to track it instead, which works
wonderfully.

Steve

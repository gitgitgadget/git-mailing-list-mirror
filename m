From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: how to git a read only directory
Date: Wed, 21 Jan 2009 14:34:19 +0200
Message-ID: <4977164B.4020706@panasas.com>
References: <20090121083354.GG6970@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 13:36:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPcJD-0008K1-Mu
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 13:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758920AbZAUMe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 07:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757943AbZAUMe0
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 07:34:26 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:45126 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758920AbZAUMeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 07:34:25 -0500
Received: by ewy13 with SMTP id 13so1441484ewy.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 04:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=3oSIjqNrn3RSd4esreIKCy3dD71cGAozRBklPv0Tgws=;
        b=jU2vRNKw+h0K3Pm2OKZyEBARogAwgit40uh1scCgi/4oh+FRa4t1X4A+PGRzvqM9Be
         nyLMUzqTjPtPk2vLwYCYbCUy9YarJV7E8Ke38GRSQXG5xAdsc0vE/RaIxuXNUgpkiXQ5
         CG3T4c4NxmAmjoxg4midc8wWmwHsCmwgSi/U8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=aGM4gaKi0gxVUSi4aHvReXjQ2apmjk6PwvrBQ0ln2AMBGRSkjZjGu0IdVmtwLw/021
         VOkwPgQXciAcaJXJZsERf0P1O/yU4yJ0LRgHi5dkWmUSz6OtzoUk9cwuS0zmEVGzwWuk
         0pcN/v/4RiEiROqKWdSLjiJSwf4A1eIVT/Ppo=
Received: by 10.210.10.1 with SMTP id 1mr2265494ebj.43.1232541263938;
        Wed, 21 Jan 2009 04:34:23 -0800 (PST)
Received: from bh-buildlin2.bhalevy.com (DSL212-235-53-3.bb.netvision.net.il [212.235.53.3])
        by mx.google.com with ESMTPS id 10sm7869830eyz.49.2009.01.21.04.34.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jan 2009 04:34:22 -0800 (PST)
User-Agent: Thunderbird/3.0a2 (X11; 2008072418)
In-Reply-To: <20090121083354.GG6970@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106601>

bill lam wrote:
> I want to use git to keep track of files inside /etc but do not want
> to do it as a super user. Is that possible to put GIT_DIR under my
> home directory and add public-read files inside /etc? Or that it could
> be done in some other ways.
> 
> Thanks.
> 
I did the really easy hack (on my /etc BTW) and it worked fine for me.

I created a master project folder under ~home, init a new git repo,
then symlink /etc/ onto an etc/ in the project dir, added all etc/
files. I like the extra a/etc/fstab in the patch files better then
a/fstab.

And it is a life saver, payed it's effortless in gold. Some shining
new distro should come up with a git based management system
and it will leave all the other distros in the dust.

Cheers
Boaz

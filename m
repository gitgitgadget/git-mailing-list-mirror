From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [msysGit] Re: Using VC build git (split patch)
Date: Sun, 30 Aug 2009 16:36:20 -0300
Message-ID: <a4c8a6d00908301236l4394a471vb83ed2befda3a91@mail.gmail.com>
References: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com>
	 <4A899FDB.8080308@gmail.com>
	 <1976ea660908171807x22f4b755r2e522a15ff462917@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marius Storm-Olsen <marius@storm-olsen.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 21:42:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhqHt-000681-PF
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 21:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbZH3Tl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 15:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbZH3Tl7
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 15:41:59 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:3128 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbZH3Tl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 15:41:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so4357768and.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 12:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=w61bNlo2AZ57FotlgMhc55jZaxzhZnJvt2Gq7LFHovo=;
        b=dsaqmmZ83ulAGuwaVhkN3kxXxgI6VOMfIgCBtDoHaG54/6IiRpQtR1RjwG8lMVKhhs
         M9E7sqUw+0T4wqLbIjl2QGrJX7p1yjVgzmYtiB6fvrbaC/x8dRrramhTQ/gD4B4Xh1zm
         2cb7aKeqL5BDPrxfzqThDYAd1q4n51gGcyonY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gVPdLjQgCN/69iosMsGvaC9bPgAQpmspa1WPxWkp4j8lnxwtwUt7fY/Xg3/04C417m
         fO0GrF5vCo6vAlRLl9RcJRGghsWrWGyQDihJNQQEC0rUmWQo8KhyHq80YJDrVhwjjaAA
         c6orV78oQEzz0TGp8fIfz/6yT7+Rc1LD9M+fw=
Received: by 10.101.95.6 with SMTP id x6mr4361551anl.108.1251660980886; Sun, 
	30 Aug 2009 12:36:20 -0700 (PDT)
In-Reply-To: <1976ea660908171807x22f4b755r2e522a15ff462917@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127422>

Hi

In line 999 of imap-send.c there is a call to the function socketpair,
but apparently it isn't defined anywhere, because the compiler is
returning this following error:

Error	2635	error LNK2019: unresolved external symbol _socketpair
referenced in function _imap_open_store	imap-send.obj	imap-send

Anyone faced this problem before?

Thanks!

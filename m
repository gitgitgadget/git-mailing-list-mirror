From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to manage multiple repos using submodules?
Date: Sun, 17 Apr 2011 01:48:19 -0500
Message-ID: <20110417064818.GA25344@elie>
References: <4DA9C7A7.4010503@sohovfx.com>
 <20110416182053.GA11017@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 08:48:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBLmc-00038j-K8
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 08:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353Ab1DQGsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 02:48:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50658 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab1DQGs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 02:48:29 -0400
Received: by iyb14 with SMTP id 14so3121678iyb.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 23:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1TUsJ/ZIZQJIzkSZETMNybunbY0tCZnWwXImrHiG1lA=;
        b=b5qn3+qFNwKBsP67qSQiQb+d7oSkWHwujOsD2bJJA9P0b10wYt8GgfKfDKzMxC5g8w
         iODpAIoDK9K75zAEtm60qIU4uYEjt4FuzN83+KosANa/PjKn0/BlWeKdayUS/L0ngZDW
         bGkZwMIeIb60C6e5C+eJhyg3+ynIhfYqKNVIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XIIAoRFVloQYgVZLzTxFXfCTRp43DTcupxdpoXyvQbRyzhto8uh9aYp9EKkmk9VmQM
         dl7ayY/DKM/kW8L1ZTZ4Sb49ME2hvNxEV4ZZn35raKHAKpRg43ZqIecg71We+AKf4EwP
         uEsnTjC7bERWBKHaxubkaRqDLojal8E9vR354=
Received: by 10.42.163.68 with SMTP id b4mr4562068icy.120.1303022908253;
        Sat, 16 Apr 2011 23:48:28 -0700 (PDT)
Received: from elie (adsl-69-209-51-5.dsl.chcgil.ameritech.net [69.209.51.5])
        by mx.google.com with ESMTPS id i3sm2339180iby.23.2011.04.16.23.48.25
        (version=SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 23:48:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110416182053.GA11017@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171716>

Hi,

Jonathan Nieder wrote:

> Yep, if you want to keep track of the state of a bunch of repos over
> time, submodules are not so bad[*].

A kind person pointed out that I left out a footnote.  I think all I
had been planning to say is that, roughly speaking, submodules are
about[1] saying that a specific commit is known to work well with the
rest of the code.  A supermodule like the one discussed in [2] is only
likely to be useful if you are interested in what historical
combinations of repositories were published and meant to work well
together.

Ciao,
Jonathan

[1] e.g., http://thread.gmane.org/gmane.comp.version-control.git/27803/focus=27830
[2] http://lists.x.org/archives/xorg-devel/2009-September/001966.html

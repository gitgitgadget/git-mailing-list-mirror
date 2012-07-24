From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 17:02:08 -0500
Message-ID: <20120724220207.GA15969@burratino>
References: <500F17A3.60307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 00:02:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StnBP-0003db-79
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 00:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394Ab2GXWCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 18:02:18 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:49786 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619Ab2GXWCR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 18:02:17 -0400
Received: by ghrr11 with SMTP id r11so77211ghr.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CM2UPDLuiLyiN5BIQATCUvEw8mTUkiBDpYaY3Eoz04E=;
        b=k2nie1IoBjhGENss8vfWfuzwK9oJkMd9vt01zq2kASrEGjQj2osKKjZbxgojQe97xP
         BnKFWwz8ACI7WYm5wnSA4rlDLUB0/Ny+kB3olLHPKqdO0AYgKgCOazU14XUn/+ys8klQ
         MdY+cMMBqZzUvVNB/VeGZhNlTILOXqAV8sUfDNM1DX4pnNulfcWvLO53DZyUP/HiiQkv
         EfaJ4G9YaB7wADE8dxODDMqBn34zcKhTPcjB1rjhvToFvKbe1QhVTDTrgNWIxgctXZBE
         NaDAXJL5Xz7xePGJBDOOaFn58LM6amjVvB6flAT9vUcCTlybhpQiKMAU0rmpXyhU9sfV
         eiQA==
Received: by 10.42.197.197 with SMTP id el5mr18908602icb.35.1343167336333;
        Tue, 24 Jul 2012 15:02:16 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id y5sm6086242igb.11.2012.07.24.15.02.15
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 15:02:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500F17A3.60307@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202076>

Hi,

Michael G Schwern wrote:

> I'm trying to bust it up into easier to digest pieces.

I have a crazy idea.  You might not like it, but maybe it's worth giving
it a try.

[...]
> The Git::SVN extraction is more complicated than the rest, so I'll probably do
> that separately and bust it up into a few commits.

All of these changes are supposed to have zero functional effect,
right?

Could you send the first five patches that *are* supposed to have a
functional effect?  I know that they will not apply cleanly to git-svn
from git "master" or on top of each other; that's fine with me.  If
the approach looks right, interested people (read: probably Ben or I :))
can make the corresponding change in the code layout from "master".
Afterwards, we can look into all that refactoring to make later
changes easier.

What do you think?

Thanks,
Jonathan

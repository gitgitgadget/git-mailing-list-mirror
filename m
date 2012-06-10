From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] git-svn: use YAML format for mergeinfo cache when
 possible
Date: Sun, 10 Jun 2012 05:04:47 -0500
Message-ID: <20120610100447.GE30151@burratino>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net>
 <20120609222039.GD28412@burratino>
 <20120610090039.GA12868@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 12:05:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdf1C-00069w-6z
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 12:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab2FJKEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 06:04:53 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38850 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab2FJKEw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 06:04:52 -0400
Received: by yhmm54 with SMTP id m54so2024612yhm.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 03:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HPiBS//u1HVhIRascOcdEB/t7rSl5v1Vd1O+QhMDmpg=;
        b=i3dtD63wLSaVvS/INGsu21/j7Gqhm8aiOfnqvdj+ZxxQBHNAY41UWGYM+70KmnTMz2
         KhU4IWBe/xG0UH4g6gejPTJVtK7Diz3BEXq8Ggq9Or57D9crIKAhcoTJOvv/pe9nvJKI
         ZACO4brHX7m8dtflHH2RANsbMgtpXDfqF+gR0uWUat2rwkJJhwsPTJmN1jcFd7VUc3y8
         7BahVIst3uZt3p04FIKy2ZHRiKtfd0hTPR0P4C6G9xLgD5wPVXBqRGXnl7/LLxiofauJ
         mStZIi7RC6swdC9Tt2FxjfR7nYojrqS0pu0vCK5HyiAfAT67BTp8v2VMwyl42qMalsKu
         uPRA==
Received: by 10.236.182.161 with SMTP id o21mr15750201yhm.43.1339322691633;
        Sun, 10 Jun 2012 03:04:51 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id p29sm42899289yhl.19.2012.06.10.03.04.50
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 03:04:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120610090039.GA12868@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199582>

Eric Wong wrote:

> 2/3 had a conflict with commit c26ddce86d7215b4d9687bd4c6b5dd43a3fabf31
> which I resolved by hand

That was fast. :)  Checked by glancing through the output of

	git diff 9f7ad147^:git-svn.perl 9f7ad147:perl/Git/SVN/Ra.pm

Looks good.

Good night,
Jonathan

From: Kevin <compufreak@gmail.com>
Subject: Re: How to get status-like short format for old commits?
Date: Mon, 26 Mar 2012 14:07:03 +0200
Message-ID: <20120326120703.GA5454@ikke-laptop.buyways.nl>
References: <CAA01CsqM_cmf8A5OjdkX4i-ituCWK95ygEoK_Y0-2LkKo1D7kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 14:08:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC8iO-0008FH-86
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 14:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472Ab2CZMHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 08:07:39 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40813 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458Ab2CZMHH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 08:07:07 -0400
Received: by eekc41 with SMTP id c41so1538490eek.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 05:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6VJlKMp0tbHe4XF1yvDK4El3X98EB13Lt4T6gxaV3d4=;
        b=XFyeOb7FW+PU3CvGJ+/0YW+u3v3NYTPdZ1rov5SDBsL8zA20eEtxd3UsH/wIr9JGaU
         E1P0UqZF+cK29JgeulgVyqXEZBJhEkQ3qtlZ7HW2JTlq16gCgKc3onrj/7j8DzDry/gH
         7CPc5ZlnHI6T+/fHG7qpnNnvh/Qi4iTbANOHFAyqs2OxvIty4W/BrV94q/kipy0zqlPO
         zhy4bIVhkrBcdsGdAqQHBX0sRr003lMzeqQ33HvliysnYnJ0leTx4T3ganoZgussKPRP
         H+i0aHQUL5yLvzUQHxUw1nvV2WspUJ0wpdlSqIVHwY0fn+vSn9CZZR+sGW+/up4CYzad
         MKxg==
Received: by 10.213.22.132 with SMTP id n4mr1511858ebb.131.1332763625673;
        Mon, 26 Mar 2012 05:07:05 -0700 (PDT)
Received: from localhost (D4B2749A.static.ziggozakelijk.nl. [212.178.116.154])
        by mx.google.com with ESMTPS id n56sm57746842eeb.4.2012.03.26.05.07.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 05:07:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAA01CsqM_cmf8A5OjdkX4i-ituCWK95ygEoK_Y0-2LkKo1D7kA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193907>

You might want git log --name-status. It will show something similar as
git status -s. (so with A,M,D etc. as status).



On Mon, Mar 26, 2012 at 01:24:24PM +0200, Piotr Krukowiecki wrote:
> Hi,
> 
> I there a way to get a clear status of some past commits, like 'git
> status' shows for current index/HEAD? I.e. something like
> 
> git status HEAD^
> #	modified:   Makefile
> #	deleted:    t/t0080-vcs-svn.sh
> #	new file:   t/t9011-svn-da.sh
> #	renamed:   xxx -> yyy
> 
> 
> Thanks,
> -- 
> Piotr Krukowiecki
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

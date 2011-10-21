From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Tracking cherry picks
Date: Fri, 21 Oct 2011 04:52:34 -0500
Message-ID: <20111021095234.GA17219@elie.hsd1.il.comcast.net>
References: <4EA02E6C.2040608@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kirill Likhodedov <klikh.list@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Fri Oct 21 11:53:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHBml-0005rY-TB
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 11:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab1JUJwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 05:52:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64273 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab1JUJwo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 05:52:44 -0400
Received: by iaek3 with SMTP id k3so4523987iae.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 02:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Zz3IGLQ8p+I+eKPLvmIDKXw+tnbx2eqiWo2uBYUxrEw=;
        b=gFalmVZDRR25Jahi9iV0F/BtftTwNfXGD2/yUnCLnkQEeF6m0YBQTp5kbggdKIYReY
         WAw1DWMPkap4UDxBAgx+7CF4B2q3MstEMC1+k+/pC8vjBH5lahZNzreb827w+G0l14qo
         9np1aR5/Ag+LHt58DjrbANprdyaBcsvD8FVxk=
Received: by 10.231.84.8 with SMTP id h8mr5772703ibl.47.1319190763672;
        Fri, 21 Oct 2011 02:52:43 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id e2sm31713785ibe.0.2011.10.21.02.52.42
        (version=SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 02:52:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4EA02E6C.2040608@cfl.rr.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184053>

Hi,

Phillip Susi wrote:

> Sometimes a bug is found and the fix needs applied to multiple
> branches.  I would like to be able to list what branches the fix has been
> applied to to validate that it went in everywhere it was needed, but after
> cherry-picking the fix from master to the stable branches, the SHA1 of the
> commit is different, and so git branch --contains does not think the commit
> was applied to each of the stable branches.

If you base the fix on the oldest commit you think you might ever want to
apply it to, then you can reuse the same bugfix commit in all branches.
See gitworkflows(7) for more on this.

Hope that helps, and good luck,
Jonathan

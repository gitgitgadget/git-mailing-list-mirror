From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Handling large files with GIT
Date: Thu, 9 Feb 2006 18:38:26 +1300
Message-ID: <46a038f90602082138x5ce072e9kff69e3d677bd0162@mail.gmail.com>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
	 <87slqty2c8.fsf@mid.deneb.enyo.de> <20060209045420.GB15924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 06:39:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F74WS-00071S-0A
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 06:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWBIFie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 00:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030621AbWBIFie
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 00:38:34 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:40287 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030248AbWBIFid convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 00:38:33 -0500
Received: by wproxy.gmail.com with SMTP id 71so36802wri
        for <git@vger.kernel.org>; Wed, 08 Feb 2006 21:38:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k/N+Katdky3RXxitMDXarHsanZpMO8FvlOTFguIfW24l+uJnqrAGcV2+JvUGwQnr4stAM3YGVVQX5ycvvUiWY3y1bzvSobMzXvqIH37aE+/cdixBEu7CW6KSqlxxeDwciCxl+5R44CzEDrU41uOkPFwnkU3Y95USiLRHfnHrBOA=
Received: by 10.54.72.17 with SMTP id u17mr361648wra;
        Wed, 08 Feb 2006 21:38:26 -0800 (PST)
Received: by 10.54.71.8 with HTTP; Wed, 8 Feb 2006 21:38:26 -0800 (PST)
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060209045420.GB15924@kroah.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15789>

On 2/9/06, Greg KH <greg@kroah.com> wrote:
> Is there anyway to not repack everything if it's not
> need?

I often cg-clone large projects over stupid protocols (http/rsync) and
then hand-edit the branches/origin or remotes/origin file to say
"git://" instead.

It's called cheating but it works great ;-)



m

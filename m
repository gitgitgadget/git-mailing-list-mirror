From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: use result of open(2) to check for presence
Date: Thu, 5 Jan 2006 16:12:22 +0100
Message-ID: <81b0412b0601050712q4c2123f7i8e9190c3b75b6fda@mail.gmail.com>
References: <81b0412b0601050343w4c00ac86y30569c3babbf6728@mail.gmail.com>
	 <118833cc0601050648t17f68bcch8fd7c541585e965c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 16:12:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuWmx-0001eS-No
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 16:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWAEPMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 10:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWAEPMZ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 10:12:25 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:17633 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750724AbWAEPMY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 10:12:24 -0500
Received: by nproxy.gmail.com with SMTP id x37so128437nfc
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 07:12:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GT4UD5R4e0iqXjjQQDjw+yWoiC3a2B3zDY4vI+aLTGPy0sTAkWZ+MzN1nLRIk4TQl9iMcCs3rZjRw39QXD5d8znbfwkRhvyvIkhTCcWHkAngDvJZprSNi8pgJIQCkcCM20qMCagTiv9y7d19B5YwMhUpd+IXuDZGVnz4ip7lkHY=
Received: by 10.49.42.7 with SMTP id u7mr695529nfj;
        Thu, 05 Jan 2006 07:12:22 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 07:12:22 -0800 (PST)
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0601050648t17f68bcch8fd7c541585e965c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14199>

On 1/5/06, Morten Welinder <mwelinder@gmail.com> wrote:
> Neat, but perhaps you should check the fstat return code.
> It actually can fail, for example if the filesize cannot be represented in the
> structure because it is too big.

Yes, of course. It will be added along with the missing test for mmap
returning MAP_FAILED. Sometime.

Sarcasm aside, how do you get such a situation?

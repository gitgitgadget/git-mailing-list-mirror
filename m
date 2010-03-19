From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Error building installing on Redhat Linux Server release 5.3
 (Tikanga)
Date: Fri, 19 Mar 2010 17:59:23 -0500
Message-ID: <20100319225923.GB17058@progeny.tock>
References: <d557014b1003191436r4d141825p6c5b8e1b3bee4fc8@mail.gmail.com>
 <20100319225703.GA17058@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Cox <mhcox@bluezoosoftware.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 23:58:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsl9M-0007mO-TW
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 23:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab0CSW6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 18:58:36 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:45613 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab0CSW6f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 18:58:35 -0400
Received: by ywh2 with SMTP id 2so835593ywh.33
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3d+q50fFSOySvMpA9Xk5iCKoui36lf/5B91LJMp4mM8=;
        b=T1n1v57DA0DcoIzJkNbr1LIoFCYfzFM89e+1u4+XVasGSEv7gop4GeI1+dFXKwRd0v
         hlZlbG+ISGm9qsS9qgBKepLamatUHVsyhYwUizLGJRmR6pOhpZdZGSn7IQBVZ4YYWPPk
         QPYutzIXlQnbHymZ1uh+bNqHrsM6LtQlDH1aA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CeW2UKAad0qhkMm26Dxc6w6PKtCQClMZmUiwoqoIlbUQR//0gb+dQk4/aHnYp8jCSy
         eJVLyAQObskxB9Rb2AavQivolRzStXTS0xXqeWWeL92LnUNWNs1+WPDz1NTxyzA7YPun
         WoUus3Z2GOkFGUnVcsGHgpC4fJQZAFNYhsM6k=
Received: by 10.151.18.22 with SMTP id v22mr6420173ybi.262.1269039514580;
        Fri, 19 Mar 2010 15:58:34 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm815813iwn.5.2010.03.19.15.58.33
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 15:58:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100319225703.GA17058@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142659>

Jonathan Nieder wrote:

> In the mean time, you can use git without installing it by adding
> /home/e477610/exptool/share/git-core/bin-wrappers to your $PATH. :)

Or rather $(pwd)/bin-wrappers, where $(pwd) is the directory git was
built in.  I read your message a little too quickly, sorry.

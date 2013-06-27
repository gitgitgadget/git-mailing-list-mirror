From: Woody Wu <narkewoody@gmail.com>
Subject: Re: Off-line deverloper workflow?
Date: Thu, 27 Jun 2013 21:41:56 +0800
Message-ID: <20130627134156.GB5047@zuhnb712>
References: <20130627124656.GA2620@zuhnb712>
 <CALKQrgdiRg--A4-cp7Y0c3-rc-gDX+QVgPxKDpmW5Exx_HeWHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 15:41:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsCST-0001MU-Pr
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 15:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab3F0Nly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 09:41:54 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:42846 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab3F0Nlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 09:41:53 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so397773pdj.8
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3t7z609DQ5E/S/DyZ05BLOHrHqGGsTJ0jGcjqrXQS3s=;
        b=jrPHkjNfxguathP+AE9Ww2OKs07kn+/rlqkfaenYfYBUTLGww7VpnGOvb9Hp7gXzML
         kLEk7cVNFExfHwxIhJYRrxOAa0gNCwSxHXuRh48x797BYy/8tdZTHSpxF6mz1oxdKumK
         Fydc89t3PdGreaRhN5G6yFS8wl9T4dBo/HUuLYcK7A2vp4lvyywqP/GVCadqEWvwhmJa
         74LWBKgcqQh4elL9xC1SrvtXiaCT+OXCOC/uFG42++TxMATW7teigkST0O2Vz4r+e3xK
         4UZiIxxCLcMq73pQBP2f1459+hqUgnKpwj3Re9f/A8mKBG233wBCNzmyIYKcqNNXmqj1
         V3gg==
X-Received: by 10.66.121.195 with SMTP id lm3mr6190793pab.116.1372340513015;
        Thu, 27 Jun 2013 06:41:53 -0700 (PDT)
Received: from localhost ([119.120.31.222])
        by mx.google.com with ESMTPSA id dc3sm3250668pbc.9.2013.06.27.06.41.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 06:41:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALKQrgdiRg--A4-cp7Y0c3-rc-gDX+QVgPxKDpmW5Exx_HeWHg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229103>

On Thu, Jun 27, 2013 at 03:14:05PM +0200, Johan Herland wrote:
> On Thu, Jun 27, 2013 at 2:46 PM, Woody Wu <narkewoody@gmail.com> wrote:
> > I have a colleague who has to left our office for three month, but still
> > need to work on the project which is hosted on our in-office git
> > repository. Problem is that our company has firewall, it's not possible
> > or not allowed to access the company LAN outside the building.  So I
> > want to ask you expert, can you suggest a best practice of git workflow
> > that suitable to my situation?
> 
> If he can set up an SSH server on his machine (outside the company
> network), then he can set up a mirror repo on his machine, where you
> can push changes from the office to him, and pull changes from him
> back into the office. Of course, you will probably need to synchronize
> this with him, especially if he's travelling and frequently offline or
> changing IP addresses. Also you need to be able to make outbound SSH
> connections through the company firewall, but AFAICS that is usually
> allowed.

Outbound ssh to me is not a problem, but inbound ssh to him may be a big
problem. You know hotel firewall or some home ADSL don't allow that.

> 
> His work repo is then a local clone of the mirror repo, and when he's
> ready to publish some work to you, he pushes it to the mirror repo,
> and asks you to pull from the mirror repo.

> 
> If the source code is not secret, you could even synchronize through
> GitHub or some other repo hosting service, which would be even easier
> to set up.
> 
> 
> Hope this helps,
> 
> ...Johan
> 
> > Thanks in advance.
> >
> > -woody
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Johan Herland, <johan@herland.net>
> www.herland.net

-- 
I can't go back to yesterday - because I was a different person then

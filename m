From: Ben Hoskings <ben@hoskings.net>
Subject: Re: [RFC] teamGIT bonjour support
Date: Fri, 28 Aug 2009 20:06:24 +1000
Message-ID: <47ECFDB7-4189-4573-BC27-685603780F27@hoskings.net>
References: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, teamgit@googlegroups.com
To: Abhijit Bhopatkar <bain@devslashzero.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 12:06:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgyLu-0005i2-WB
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 12:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbZH1KG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 06:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbZH1KG2
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 06:06:28 -0400
Received: from mail-pz0-f178.google.com ([209.85.222.178]:40821 "EHLO
	mail-pz0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZH1KG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 06:06:27 -0400
Received: by pzk8 with SMTP id 8so1887776pzk.22
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 03:06:29 -0700 (PDT)
Received: by 10.114.163.26 with SMTP id l26mr1334263wae.173.1251453989765;
        Fri, 28 Aug 2009 03:06:29 -0700 (PDT)
Received: from ?10.0.1.12? (ppp194-249.static.internode.on.net [59.167.194.249])
        by mx.google.com with ESMTPS id n40sm2606925wag.56.2009.08.28.03.06.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 03:06:29 -0700 (PDT)
In-Reply-To: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com>
X-Mailer: Apple Mail (2.1075.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127283>

On 28/08/2009, at 5:02 PM, Abhijit Bhopatkar wrote:

> I plan to do this on LAN using bonjour service discovery, and rest
> completely being handled inside teamGIT running as a daemon(may be in
> widely abused systray?). (Git will handle actual fetch/conflict
> checking etc.)
> On a side note i also plan to generate daily reports and configurable
> notifications.
>
> So I ask you people, is there a solution already cooking someplace?
> may be something i can integrate with teamGIT? (e.g. bonjour plugin
> for git dameon)

You should check out bananajour, it sounds like it might fight the  
bill quite nicely:

http://github.com/toolmantim/bananajour

Written by Tim Lucas, and hacked on by a bunch of us at the Gold  
Coast, Australia Railscamp in May:
http://railscamps.com/

The idea is that for each repo you want to publish, bananajour creates  
and looks after a locally stored remote, that you push to ("git push  
banana master") to publish your work over bonjour.

There's also a web interface at your-machine.local:9331 which shows  
the other bananas that were found (via bonjour) on the network.  
['9331' is for 'peel' :) ]

I'm not sure what the state of Linux support is, since most of us run  
OS X, but I'm pretty sure someone was working on Linux/zeroconf support.

Cheers
Ben Hoskings

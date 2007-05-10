From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 19:38:23 +0200
Message-ID: <81b0412b0705101038p59aeef04qae1322adc788e336@mail.gmail.com>
References: <20070506195230.GA30339@mellanox.co.il>
	 <7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
	 <20070510095156.GC13655@mellanox.co.il>
	 <81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
	 <alpine.LFD.0.98.0705100901320.3986@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 10 19:38:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmCb1-0005EM-JY
	for gcvg-git@gmane.org; Thu, 10 May 2007 19:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbXEJRiZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 13:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756420AbXEJRiZ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 13:38:25 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:16367 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992AbXEJRiY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 13:38:24 -0400
Received: by an-out-0708.google.com with SMTP id d18so163561and
        for <git@vger.kernel.org>; Thu, 10 May 2007 10:38:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tsYnzI12g0Y1gTjTVKIv/orlp8Bn3LTj9k0B9/vz1Et++X24mB9cyX6SEEihtZtkDsaX58zWSQR4FXTwMqGAKprP0Mb0o/OJfOkHFyW6bqCguCPFJBP1zQlEz3TnqN7l4YX761aSe8YBhNMZdSBVhW7id4yOzMSTf+EA6EPSgwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NXY3pbzMBIgnSMhq30dHGnZ2LDpQzttyKgkHNstUnCf8+3/oqnSuXpaM0jgrgl0WBSy/17tsUL7QG8YcvDskDNpQKMsQPlGMiekHKymYU7u6QKtnUhmYnajENPIhkAz78VXo0sJQz2O+bKWIheViNsf4JVEWJ4p6RdbeUZtIJro=
Received: by 10.100.93.5 with SMTP id q5mr1527255anb.1178818703296;
        Thu, 10 May 2007 10:38:23 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Thu, 10 May 2007 10:38:23 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0705100901320.3986@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46881>

On 5/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > What addresses were tried by connect?
>
> That would be _really_ verbose. Maybe a CONNECT_EXTRA_VERBOSE?
>

It's nice to have. That's how I discovered which one of kernel.org
addresses is more stable.

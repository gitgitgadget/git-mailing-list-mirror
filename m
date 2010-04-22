From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 'git notes merge' implementation questions
Date: Wed, 21 Apr 2010 19:26:41 -0500
Message-ID: <20100422002641.GA29452@progeny.tock>
References: <201004210957.48138.johan@herland.net>
 <20100421171227.GA23794@progeny.tock>
 <201004220155.12747.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 02:26:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4kFo-0008RJ-Ba
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 02:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684Ab0DVA0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 20:26:37 -0400
Received: from mail-gx0-f224.google.com ([209.85.217.224]:46475 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab0DVA0g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 20:26:36 -0400
Received: by gxk24 with SMTP id 24so4325839gxk.18
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 17:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CP5rqsmNwRp+/h8O6IfxVRG6DOaY8LfY1D/ZNyJSAX4=;
        b=LlouH6e+3wslYr29rqJCJHD+S879gqM/ChYgI/0RRk0l2MCr9WHl0Wq8Urgv7HFr4C
         r0YlC2DY0fvzIbBH6F6yoRq4J4FRvlEdVqVQaRwRsy8L5YdYjV/cXU9cYVrQz09+gsAa
         cVy5ABWM/ViPI1RPdbDeMno5gZq8RG4egxAxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mFhDrMUflghLI0xTKrgQ4KrDgUTJ042QxcXN5MQQbbl9tCziwJbxEsiLapP0yWaVuR
         plVVx3uaM3BWMiCxYH91mM/byKuUUY8Ufyp4qPMCN60EZ0ZxMpnNDgcD2/uD1fpa7vY7
         Koetv4EsYnvyoMnA05TK+tkfU7fBSngVuWMiA=
Received: by 10.101.10.34 with SMTP id n34mr5678488ani.175.1271895993901;
        Wed, 21 Apr 2010 17:26:33 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm6943616iwn.6.2010.04.21.17.26.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 17:26:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201004220155.12747.johan@herland.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145485>

Johan Herland wrote:

> Thanks, I'm definitely coming around to the idea that having the user freely 
> resolve conflicts in a temporary worktree (that preferably contains only the 
> conflicting notes) is better than trying to resolve conflicts _without_ a 
> worktree.

Junio did a good job of making both interfaces --- no-resolution and
resolution-in-a-worktree --- sound very appealing.

Thanks for the hard work,
Jonathan

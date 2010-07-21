From: Daniel Shahaf <d.s@daniel.shahaf.name>
Subject: Re: [PATCH v2] Add svnrdump
Date: Wed, 21 Jul 2010 16:29:29 +0300
Message-ID: <20100721132929.GA508@daniel3.local>
References: <20100709142910.GB20383@debian> <20100713201105.GN13310@ted.stsp.name> <20100715190220.GI22574@debian> <20100715192321.GA722@ted.stsp.name> <20100721114610.GC15903@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Sperling <stsp@elego.de>,
	"dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 15:30:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObZNf-0004qd-HK
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 15:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924Ab0GUNab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 09:30:31 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35992 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753405Ab0GUNaa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 09:30:30 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 572AB16EE26;
	Wed, 21 Jul 2010 09:30:30 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 21 Jul 2010 09:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=smtpout; bh=HBMOQfkn9wngHo0yucZgz33FIj4=; b=OwcGn6xvuk93DF6F2GwLb3mxaNEDDAOn0qjMofW4+HRKaFmn/htzI0TFqbQixlFCGxYLOOo9tc7BVDf600Ecjtfu5uT+3ybu4zQzWPYAz5sQrN8ADld8CNwzgm6eNep1DsqpeRrLg6j+3wl/4dGoCPS/B6O9yjKhjfSYZ+baCJk=
X-Sasl-enc: oEBPY0yNkrZ6vhzI8NW+mKOuVIDegX7EMAg6V2UcyTA68RNwIthNSmj4+EjzZQ 1279719029
Received: from daniel3.local (bzq-79-179-3-226.red.bezeqint.net [79.179.3.226])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E9879488BA;
	Wed, 21 Jul 2010 09:30:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20100721114610.GC15903@kytes>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151396>

Ramkumar Ramachandra wrote on Wed, Jul 21, 2010 at 17:16:10 +0530:
> I'm still writing a unittest in Python, although I'm still trying to figure
> out how to test it without using that ugly awk query to compare it against
> the `svnadmin dump` output.

Have a look at svnsync_tests.py and svntest/verify.py.

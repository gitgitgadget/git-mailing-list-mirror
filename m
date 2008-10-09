From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: Git newbie question: permissions
Date: Thu, 9 Oct 2008 23:29:25 +0200
Message-ID: <20081009212925.GA7891@gmx.de>
References: <1b5a37350810091320l72ae0a86m39db4258c9f4827e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 23:30:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko35n-0007oe-Pr
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 23:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259AbYJIV3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 17:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756173AbYJIV3a
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 17:29:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:45922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755938AbYJIV33 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 17:29:29 -0400
Received: (qmail invoked by alias); 09 Oct 2008 21:29:26 -0000
Received: from pD9E0BB44.dip.t-dialin.net (EHLO nixos) [217.224.187.68]
  by mail.gmx.net (mp045) with SMTP; 09 Oct 2008 23:29:26 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX19ma2ssjXNmy2bUbSlU6MSmNnYaHNMK5HEMy+9vRA
	9mc0hTvxNkyZJB
Received: by nixos (sSMTP sendmail emulation); Thu, 09 Oct 2008 23:29:25 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1b5a37350810091320l72ae0a86m39db4258c9f4827e@mail.gmail.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97888>

> The last question I have is how to ensure that git creates object
> files etc. with the right permissions when users push in future.
Have a look at the config file. It should contain

[core]
        sharedrepository = 1
now.

I've never used that option before but I think this option should be
enough to ensure that it works in the future if it did for other repos
in the past..

Marc Weber

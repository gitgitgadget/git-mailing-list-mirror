From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: StGIT and repo-config
Date: Fri, 26 Jan 2007 00:58:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701260052590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070125225512.GF4083@nan92-1-81-57-214-146.fbx.proxad.net>
 <b0943d9e0701251545w1b34a0dcg545eeab08d767e38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Yann Dirson <ydirson@altern.org>, GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 00:58:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAEUW-00031C-Lw
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 00:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030657AbXAYX6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 18:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030659AbXAYX6k
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 18:58:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:49280 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030657AbXAYX6j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 18:58:39 -0500
Received: (qmail invoked by alias); 25 Jan 2007 23:58:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 26 Jan 2007 00:58:38 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <b0943d9e0701251545w1b34a0dcg545eeab08d767e38@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37784>

Hi,

On Thu, 25 Jan 2007, Catalin Marinas wrote:

> What I'd like it to have is a single initial call to git-repo-config 
> --list (in config_setup) and all the options cached in a dictionary (so 
> that .git/config options would override the global ~/.gitconfig ones). 
> The dictionary should also be pre-populated with the default values 
> (only in memory, not going to the config file on disk).

There was another thread, a few days ago, where Jakub proposed an 
alternative config parser in Perl. Eric Wong even wrote a rather large 
patch to automatically generate _source_ code for Perl, Python and Ruby.

I then proposed to have a simple --dump option to repo-config, which 
outputs NUL separated key/value pairs (substituting "true" for keys 
without -- not with empty! -- values). But somehow the discussion petered 
out before anything came out of it.

The most important point (to me) which came out of the discussion: It is 
not at all easy, or straight-forward, to handle multi-vars, i.e. multiple 
values for the same key.

Ciao,
Dscho

From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: [PATCH] Fix typos in git-remote.txt and git-symbolic-ref.txt
Date: Tue, 11 Aug 2009 18:26:10 -0600
Organization: icecavern.net
Message-ID: <200908111826.12338.wjl@icecavern.net>
References: <20090811005207.GE24183@headley> <200908110909.33904.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?=C5=A0t=C4=9Bp=C3=A1n_N=C4=9Bmec?= 
	<stepan.nemec@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 12 02:26:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb1fl-0001pa-Ds
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 02:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbZHLA0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 20:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbZHLA0U
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 20:26:20 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:52688 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753360AbZHLA0T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 20:26:19 -0400
Received: from chocobo.localnet (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 6D96335A2B;
	Wed, 12 Aug 2009 02:26:16 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-15-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <200908110909.33904.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125631>

On Tuesday 11 August 2009 01:09:32 Thomas Rast wrote:
> So until we know for certain that they're not needed, I'd rather not
> actively remove them.  Admittedly, there are lots of instances of `--
> in the docs too, so making sure which way is "right" and then
> replacing _all_ of them would probably be a nice cleanup.

I'm not fully sure of the current situation, but if it, for instance, turns 
out that "--" gives an em-dash and "\--" gives two hyphens in a row, we'd only 
want to change the "--"'s to "\--" for things like command-line options, where 
an em-dash is totally inappropriate. If it's a sentence that is actually using 
an em-dash for another purpose, it is probably intentional and desirable to 
actually get an em-dash.

Obviously we want consistency, but--as this sentence shows--there is a 
difference between an em-dash and a command-line option like --version.

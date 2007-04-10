From: arjen@yaph.org (Arjen Laarhoven)
Subject: Re: [RFC/PATCH] Optimized PowerPC SHA1 generation for Darwin (OS X)
Date: Tue, 10 Apr 2007 13:45:07 +0200
Message-ID: <20070410114507.GA28728@regex.yaph.org>
References: <20070406234826.GG3854@regex.yaph.org> <Pine.LNX.4.64.0704061830350.6730@woody.linux-foundation.org> <20070408200939.GL3854@regex.yaph.org> <20070410094801.GA6148@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Karl Hasselstr?m <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 16:07:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbEmn-0005IB-Vx
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 13:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbXDJLpR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 07:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbXDJLpR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 07:45:17 -0400
Received: from regex.yaph.org ([193.202.115.201]:44207 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964780AbXDJLpP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 07:45:15 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id DB5D05B7D2; Tue, 10 Apr 2007 13:45:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070410094801.GA6148@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44123>

Hi,

On Tue, Apr 10, 2007 at 11:48:01AM +0200, Karl Hasselstr?m wrote:
> On 2007-04-08 22:09:39 +0200, Arjen Laarhoven wrote:
> 
> >  ppc/{sha1ppc.S => sha1ppc.in.S} |  110 +++++++++++++++++++-------------------
> 
> Wouldn't it be prettier if this filename was .S.in instead of .in.S?
> Additional file suffixes are usually added at the end (e.g. .tar.gz),
> and it makes more sense too.

Using the .S suffix makes gcc automatically do the right thing. .S.in
requires an extra '-x assembler-with-cpp' option to gcc.  Of course,
it's trivial fix.

Arjen

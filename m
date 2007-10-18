From: Mike Hommey <mh@glandium.org>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 07:42:46 +0200
Organization: glandium.org
Message-ID: <20071018054246.GA9423@glandium.org>
References: <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu> <k5pll7rb.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiOB7-0006cu-4Y
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbXJRFoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbXJRFoF
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:44:05 -0400
Received: from vawad.err.no ([85.19.200.177]:59317 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbXJRFoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:44:04 -0400
Received: from aputeaux-153-1-29-122.w82-124.abo.wanadoo.fr ([82.124.191.122] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IiOAX-00050s-Gr; Thu, 18 Oct 2007 07:43:41 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IiO9e-0002Zf-VG; Thu, 18 Oct 2007 07:42:46 +0200
Content-Disposition: inline
In-Reply-To: <k5pll7rb.fsf@blue.sea.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61483>

On Thu, Oct 18, 2007 at 01:02:32AM +0300, Jari Aalto wrote:
> * Wed 2007-10-17 Michael Witten <mfwitten@MIT.EDU>
> * Message-Id: E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu
> > On 17 Oct 2007, at 3:17:08 AM, Luke Lu wrote:
> >
> >> But I still haven't seen any compelling arguments against the "all
> >> space" case
> >
> > Overhead!
> >
> > If you use 8 spaces instead of one tab,
> > that's using up 7x more space!
> 
> Software is the right place to worry about optimization. We should trust
> SCM to make proper and efficient deltas. If not, algorithms need
> improvemnts.
> 
> Any cross platform development or electronic exchange is guaranteed to
> be interpreted correctly when policy enforces "only spaces"
> 
> As we have already seen in numerous times in this thread, using tabs
> will - eventually - be interpreted in some editor, in some display, in
> some encironment using some tools ... incorrectly or different than the
> author intended. Simply because editors are configurable and we cannot
> know what settings they may have when they load the file in.
> 
> There is no such problem with spaces. 

There is such problem with spaces. A lot of editors will just insert
tabs to indent a new line when the previous you were typing begins with
enough spaces, in which case you end up with spaces and tabs mixed all
the way. It ends up being worse than all tabs.

Mike

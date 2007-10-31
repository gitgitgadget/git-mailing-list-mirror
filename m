From: Mike Hommey <mh@glandium.org>
Subject: Re: cpio command not found
Date: Wed, 31 Oct 2007 20:48:21 +0100
Organization: glandium.org
Message-ID: <20071031194821.GA16215@glandium.org>
References: <18216.31314.990545.518458@lisa.zopyra.com> <20071031133039.GA29065@diana.vm.bytemark.co.uk> <20071031140655.GA8802@gateway.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl Hasselstr?m <kha@treskal.com>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Erik Mouw <mouw@nl.linux.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 20:50:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InJa0-0005BA-3c
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 20:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbXJaTuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 15:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbXJaTuD
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 15:50:03 -0400
Received: from vawad.err.no ([85.19.200.177]:44920 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589AbXJaTuB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 15:50:01 -0400
Received: from aputeaux-153-1-44-162.w82-124.abo.wanadoo.fr ([82.124.8.162] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1InJZU-0001fd-PU; Wed, 31 Oct 2007 20:49:51 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1InJY5-0004su-5Q; Wed, 31 Oct 2007 20:48:21 +0100
Content-Disposition: inline
In-Reply-To: <20071031140655.GA8802@gateway.home>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62856>

On Wed, Oct 31, 2007 at 03:06:55PM +0100, Erik Mouw wrote:
> On Wed, Oct 31, 2007 at 02:30:39PM +0100, Karl Hasselstr?m wrote:
> > On 2007-10-31 06:51:30 -0600, Bill Lear wrote:
> > 
> > > I don't remember this dependence from earlier versions of git. I
> > > have been running git 1.4.xx on this machine for a while...
> > 
> > When you clone with -l, git uses cpio to hardlink to the original
> > repository. What has changed is that -l is now used by default when
> > cloning a repository that's accessed via the file system (as opposed
> > to over some network protocol).
> 
> Why cpio? What is wrong with ln(1) (every Unix should have one) or
> link(2) ?

Since git-clone is not yet a builtin, and is actually a shell script, it
makes more sense to use cpio than ln.

Mike

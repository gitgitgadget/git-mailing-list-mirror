From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 16:30:00 +0200
Message-ID: <20070619143000.GA15352@fiberbit.xs4all.nl>
References: <18039.52754.563688.907038@lisa.zopyra.com> <Pine.LNX.4.64.0706191359160.4059@racer.site> <20070619132456.GA15023@fiberbit.xs4all.nl> <18039.57099.57602.28299@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 16:30:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0eid-00053e-VJ
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 16:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbXFSOaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 10:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbXFSOaG
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 10:30:06 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:56342 "EHLO
	fiberbit.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbXFSOaF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 10:30:05 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1I0eiW-00041K-Ue; Tue, 19 Jun 2007 16:30:00 +0200
Content-Disposition: inline
In-Reply-To: <18039.57099.57602.28299@lisa.zopyra.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50485>

On Tuesday June 19th 2007 at 08:50 Bill Lear wrote:

> Well, I'll try that, but this is a fresh install of Centos 5, not a
> custom-hacked OS, and I would think that git should build out of the
> box on it.

Yes it should, but your error messages do suggest there is a mismatch
between headers and libraries for the iconv functions. And as on Linux
those are in libc, which is always linked in, it suggests there is a roque
header perhaps!
> 
> I checked and there is no iconv package (rpm).  I really don't want
> to have to temporarily rename a header.  I can't hand this out to
> the rest of the company, some of whom do not have root access to
> be able to rename header files.

You might at least investigate if there is somehow another iconv.h
header besides the system one under /usr/include, that might have been
used by the compiler instead of the standard one from GNU libc.
-- 
Marco Roeland

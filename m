From: Mike Hommey <mh@glandium.org>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 10:16:35 +0100
Message-ID: <20100212091635.GA22942@glandium.org>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
 <20100212080620.GA31719@dcvr.yhbt.net>
 <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de>
 <fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 10:16:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfrdv-0001YK-Bh
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 10:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082Ab0BLJQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 04:16:49 -0500
Received: from vuizook.err.no ([85.19.221.46]:36923 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab0BLJQs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 04:16:48 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Nfrdc-00056N-J6; Fri, 12 Feb 2010 10:16:39 +0100
Received: from mh by jigen with local (Exim 4.71)
	(envelope-from <mh@jigen>)
	id 1Nfrdb-0005yV-Hr; Fri, 12 Feb 2010 10:16:35 +0100
Content-Disposition: inline
In-Reply-To: <fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139667>

On Fri, Feb 12, 2010 at 10:03:43AM +0100, Sverre Rabbelier wrote:
> Heya,
> 
> On Fri, Feb 12, 2010 at 10:02, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Would it not make sense to implement git-remote-svn as a C program? That
> > should help matters especially on Windows, where git-svn is very slow due
> > to its using MSys (which is a stripped-down Cygwin, as you know, jumping
> > through hoops to bring some POSIX-iness to Windows).
> 
> It would very much be sense to do so, perhaps we should update the
> wiki to say that implementing it in C is strongly preferred?

It is already mentioned on the wiki that this would probably be a
problem, license-wise. (the svn library is Apache license, which is
incompatible with GPLv2)

Mike

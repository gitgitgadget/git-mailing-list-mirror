From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] sha1_file.c: Avoid multiple calls to find_pack_entry().
Date: Mon, 22 Jan 2007 16:07:19 -0500
Message-ID: <20070122210719.GA29975@spearce.org>
References: <20070122202945.GA29297@bohr.gbar.dtu.dk> <45B524E1.5060205@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 22:09:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H96O1-0003xO-RN
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 22:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbXAVVH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 16:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbXAVVH0
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 16:07:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39955 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbXAVVH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 16:07:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H96Nk-0006ID-VK; Mon, 22 Jan 2007 16:07:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A1BB720FBAE; Mon, 22 Jan 2007 16:07:19 -0500 (EST)
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Content-Disposition: inline
In-Reply-To: <45B524E1.5060205@fs.ei.tum.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37456>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> Peter Eriksen wrote:
> >We used to call find_pack_entry() twice from read_sha1_file() in order
> >to avoid printing an error message, when the object did not exist.  This
> >is fixed by moving the call to error() to the only place it really
> >could be called.
> >
> >Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
> 
> I noticed this originally, Peter was so kind to come up with a patch.  
> Reviewed and found +1, so:
> 
> Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>

Wow.  That's ugly.  Thanks for finding and patching it.

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/2] Correct Javadoc comment for TransportLocal
	about forking
Date: Mon, 4 May 2009 06:57:38 -0700
Message-ID: <20090504135738.GR23604@spearce.org>
References: <1241296230-19342-1-git-send-email-spearce@spearce.org> <1241296230-19342-2-git-send-email-spearce@spearce.org> <200905030952.46075.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 04 15:57:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0yfz-0003rK-8P
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 15:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbZEDN5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 09:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbZEDN5i
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 09:57:38 -0400
Received: from george.spearce.org ([209.20.77.23]:45712 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbZEDN5i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 09:57:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7C60E38195; Mon,  4 May 2009 13:57:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200905030952.46075.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118239>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> l?rdag 02 maj 2009 22:30:30 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > + * However, during {@link #openFetch()}, if the Transport has configured
> > + * {@link Transport#getOptionUploadPack()} to be anything other than
> > + * <code>"git-upload-pack"</code> or <code>"git upload-pack"</code>, this
> > + * implementation will fork and execute the external process, using an operating
> > + * system pipe to transfer data.
> > + * <p>
> > + * However, during {@link #openPush()}, if the Transport has configured
> > + * {@link Transport#getOptionReceivePack()} to be anything other than
> > + * <code>"git-receive-pack"</code> or <code>"git receive-pack"</code>, this
> > + * implementation will fork and execute the external process, using an operating
> > + * system pipe to transfer data.
> > 
> 
> I'll change the second However to Similarly. I think it reads better, even though I'm not a native English speaker.

Yea, you're right, it does read better that way.  Thanks!

-- 
Shawn.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Hosting from Windows XP.
Date: Mon, 26 Jan 2009 09:46:56 -0800
Message-ID: <20090126174656.GD31810@spearce.org>
References: <c115fd3c0901260827ge5e4b29w871b345da2373f6b@mail.gmail.com> <alpine.DEB.1.00.0901261744240.25749@intel-tinevez-2-302> <be6fef0d0901260944l7e128588xc560810515e5f941@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tim Visher <tim.visher@gmail.com>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 18:49:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRVZW-0003L4-Ra
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 18:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbZAZRq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 12:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbZAZRq5
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 12:46:57 -0500
Received: from george.spearce.org ([209.20.77.23]:51050 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbZAZRq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 12:46:56 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 36EC238210; Mon, 26 Jan 2009 17:46:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <be6fef0d0901260944l7e128588xc560810515e5f941@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107239>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Tue, Jan 27, 2009 at 12:45 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Use a net share.  Use the native permission system to restrict/open up the
> > repository for certain people to read from/write to.
> 
> hmm, does this entail git daemon usage too?

No, developers would be accessing the repository directly over SMB.

Its slower than if you used git daemon.  Access over SMB is
tolerable, especially if your network is fast, but there's still a
lot more data transfer then if the native git protocol could be used.

-- 
Shawn.

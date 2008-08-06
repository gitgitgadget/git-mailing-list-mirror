From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git problem: pack has bad object at offset 77100841: inflate
	returned -3
Date: Wed, 6 Aug 2008 07:33:10 -0700
Message-ID: <20080806143310.GB28231@spearce.org>
References: <ace3f33d0808060015t25d9c21epc31e48e3c1d041b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 16:34:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQk5d-0000K1-O3
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 16:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600AbYHFOdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 10:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbYHFOdL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 10:33:11 -0400
Received: from george.spearce.org ([209.20.77.23]:37344 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbYHFOdL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 10:33:11 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7C0DB38438; Wed,  6 Aug 2008 14:33:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ace3f33d0808060015t25d9c21epc31e48e3c1d041b1@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91516>

srinivas naga vutukuri <srinivas.vutukuri@gmail.com> wrote:
> remote: Counting objects: 879862, done.
> remote: Compressing objects: 100% (156686/156686), done.
> fatal: pack has bad object at offset 77100841: inflate returned -3
> fatal: index-pack failed
> 
> while doing "git clone" of linux kernel of latest 2.6.27-rc2.
> But am able to do the latest stable successfully.
...
> I am using cygwin, git 1.5.6.4

Where are you cloning from?

This is an indication that the data sent to your system from the
remote side is corrupt.  Possibly a bad network link?

Remote side corruption should have been detected by the remote
server as it was writing the data out.  The message above however
came from your client, so the server seems to be OK.

-- 
Shawn.

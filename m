From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-mv: Keep moved index entries inact
Date: Mon, 21 Jul 2008 09:18:18 +0200
Message-ID: <20080721071818.GL10151@machine.or.cz>
References: <20080717130651.GU32184@machine.or.cz> <20080717223036.20680.9672.stgit@localhost> <7vej5pwhub.fsf@gitster.siamese.dyndns.org> <20080721002354.GK10151@machine.or.cz> <alpine.DEB.1.00.0807210319410.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 09:19:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKpg1-0001xC-I3
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 09:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbYGUHSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 03:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbYGUHSV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 03:18:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42221 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbYGUHSV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 03:18:21 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id BB936393B300; Mon, 21 Jul 2008 09:18:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807210319410.3305@eeepc-johanness>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89314>

  Hi,

On Mon, Jul 21, 2008 at 03:20:46AM +0200, Johannes Schindelin wrote:
> On Mon, 21 Jul 2008, Petr Baudis wrote:
> > I want to make sure the whole index entry is intact, not just the sha1.
> 
> "rev-parse :dirty" will have to read the index to get at the object name 
> of "dirty".  So there you have your index validation for you.

  it will test if the entry stays _valid_, but not whether it stays the
_same_.

				Petr "Pasky" Baudis

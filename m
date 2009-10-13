From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v2 05/16] Add multi_ack_2 capability to
	fetch-pack/upload-pack
Date: Tue, 13 Oct 2009 14:36:32 -0700
Message-ID: <20091013213632.GF9261@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-6-git-send-email-spearce@spearce.org> <m3ocobf067.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxp9J-0004He-U0
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 23:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761183AbZJMVhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 17:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761366AbZJMVhJ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 17:37:09 -0400
Received: from george.spearce.org ([209.20.77.23]:44483 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669AbZJMVhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 17:37:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B7647381FE; Tue, 13 Oct 2009 21:36:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m3ocobf067.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130219>

Jakub Narebski <jnareb@gmail.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > When multi_ack_2 is enabled the ACK continue messages returned by the
> > remote upload-pack are broken out to describe the different states
> > within the peer.  This permits the client to better understand the
> > server's in-memory state.
> 
> Errr... can't you find better name than multi_ack_2?  Perhaps
> multi_ack_detailed or something...

Uh... yes.  Good idea.  Thanks.  :-)
 
-- 
Shawn.

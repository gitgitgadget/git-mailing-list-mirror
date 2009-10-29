From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 03/26] pkt-line: Make packet_read_line easier to
	debug
Date: Thu, 29 Oct 2009 14:58:29 -0700
Message-ID: <20091029215829.GD10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-4-git-send-email-spearce@spearce.org> <7vhbtidgmp.fsf@alter.siamese.dyndns.org> <20091029151152.GX10505@spearce.org> <7v1vkm6id9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 22:58:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3d0v-0002hH-33
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 22:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113AbZJ2V6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 17:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755633AbZJ2V6Z
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 17:58:25 -0400
Received: from george.spearce.org ([209.20.77.23]:58342 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbZJ2V6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 17:58:25 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 12228381FF; Thu, 29 Oct 2009 21:58:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v1vkm6id9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131657>

Junio C Hamano <gitster@pobox.com> wrote:
> > The NUL assignment isn't about safe_read(), its about making the
> > block of 4 bytes read a proper C-style string so we can safely pass
> > it down into the snprintf that is within die().
> 
> I knew and understood all of what you just said.  static linelen[] is not
> about stack allocation.  It's about letting the compiler initialize it to
> five NULs so that you do not have to assign NUL to its fifth place before
> you die.  This removes one added line from your patch.

Thanks, I get it now.  Patch amended.

-- 
Shawn.

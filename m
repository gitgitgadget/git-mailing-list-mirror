From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 26/26] test smart http fetch and push
Date: Fri, 30 Oct 2009 15:59:11 -0700
Message-ID: <20091030225910.GG10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-27-git-send-email-spearce@spearce.org> <7vpr86dgyj.fsf@alter.siamese.dyndns.org> <20091029143702.GU10505@spearce.org> <7vljish69m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:59:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N40RD-0001lh-Fd
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 23:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933037AbZJ3W7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 18:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933028AbZJ3W7H
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:59:07 -0400
Received: from george.spearce.org ([209.20.77.23]:55927 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933027AbZJ3W7G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 18:59:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 60C41381D3; Fri, 30 Oct 2009 22:59:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vljish69m.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131773>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >> 
> >> > +	sed -e "
> >> > +		s/
> >> > //
> >> 
> >> This chomped line is so unlike you---what happened?
> 
> What I meant was the patch corruption.  I couldn't tell what you were
> trying to filter with the first substitution you are giving to sed.

Oh, that.  Its a literal CR on the search side, nothing on the
replace side.

-- 
Shawn.

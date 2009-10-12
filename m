From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC 3/4] git check-ref-format --print
Date: Mon, 12 Oct 2009 16:26:54 -0700
Message-ID: <20091012232653.GQ9261@spearce.org>
References: <4AD0C93C.6050306@web.de> <7vws327wbp.fsf@alter.siamese.dyndns.org> <20091012052536.GA11106@progeny.tock> <20091012053141.GD11106@progeny.tock> <20091012143922.GL9261@spearce.org> <7veip8e302.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 01:33:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxUOQ-0004UC-Tm
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 01:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723AbZJLX1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 19:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757701AbZJLX1a
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 19:27:30 -0400
Received: from george.spearce.org ([209.20.77.23]:51955 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925AbZJLX1a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 19:27:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1A79C381FE; Mon, 12 Oct 2009 23:26:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7veip8e302.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130092>

Junio C Hamano <gitster@pobox.com> wrote:
> I understand that you prefer the latter between "there is no tool; the
> caller is responsibile to make sure it feeds us canonical representation"
> and "there is a tool that makes a slightly malformed string into canonical
> form for the callers to use before calling us."  And that would be my
> preference between these two as well.
...
> But now I have spelled this out, I do not see much upside for rejecting,
> and more importantly, I think it would be an independent issue.  We can
> reject or just keep normalizing silently, and a tool to show the
> normalized name would be useful and necessary regardless of that.

I agree with the last paragraph here, we shouldn't reject, but
instead keep the current state but encourage tools to use the new
canonical print tool to clean up a name if they want to hang onto the
string the user entered and it needs to exactly match for-each-ref
sort of output.

-- 
Shawn.

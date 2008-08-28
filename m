From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 10:46:42 -0700
Message-ID: <20080828174642.GG21072@spearce.org>
References: <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <48B6DABD.7090800@zytor.com> <20080828171052.GC21072@spearce.org> <48B6DE7A.1020207@zytor.com> <20080828172623.GD21072@spearce.org> <48B6E3F3.1070903@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:49:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlbj-0006qX-FM
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbYH1RrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756303AbYH1RrA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:47:00 -0400
Received: from george.spearce.org ([209.20.77.23]:45781 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbYH1Rqo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:46:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D5F9E38375; Thu, 28 Aug 2008 17:46:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B6E3F3.1070903@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94104>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>>
>> Should I change the HTTP protocol then to use the same format,
>> so they have a better chance at sharing code between them?
>>
>
> I leave that up to you and Junio.  My feel would that it's not worth  
> optimizing the HTTP protocol separately.

Yea, I'm leaning towards just keeping them the same.  I may be
able to reuse a lot of code in JGit that way.  In C Git its going
to take some refactoring to disentagle the IO parts of fetch-pack
from the protocol, but I should be able to reuse a lot there too.

-- 
Shawn.

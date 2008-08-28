From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 10:26:23 -0700
Message-ID: <20080828172623.GD21072@spearce.org>
References: <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <48B6DABD.7090800@zytor.com> <20080828171052.GC21072@spearce.org> <48B6DE7A.1020207@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:27:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlHS-0007sO-Ux
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbYH1R0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbYH1R0Y
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:26:24 -0400
Received: from george.spearce.org ([209.20.77.23]:60245 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYH1R0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:26:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D02B638375; Thu, 28 Aug 2008 17:26:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48B6DE7A.1020207@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94096>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>> "H. Peter Anvin" <hpa@zytor.com> wrote:
>>>
>>> I *think* the "native" git protocol uses binary here.  It makes sense 
>>> to  be consistent, to allow them to share code?
>>
>> No, the native protocol is horribly verbose here:
>>
>> 	0032want ac3abe10ed54d512fbbaeb7cef19972eedd8e4a8
>> 	...
>>
>> so its doing it in hex, and its using 10 bytes of "framing" for
>> every SHA-1 it sends as each is sent in its own pkt-line with the
>> have/want header.
>
> Hm.  It's probably not enough data to worry significantly about.

Should I change the HTTP protocol then to use the same format,
so they have a better chance at sharing code between them?

-- 
Shawn.

From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/4] Makefile: add NEEDS_RESOLV to optionally add	-lresolv
 to compile arguments
Date: Thu, 28 May 2009 14:32:20 -0500
Message-ID: <vVyKoW1VAw2ieNPkJ-SGMNqgFzp_toRpDdk-ZeAp3qzdczSzN4yckg@cipher.nrlssc.navy.mil>
References: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil> <8D9Pn2N3FZLQcyxrPABrG3rdrFXFL1OddmlhE77V4q-K8NSzkS8xbqdJw0C0CnqkCcLEUU_UEIs@cipher.nrlssc.navy.mil> <20090528191051.GE13499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 21:32:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9lL5-0004db-RW
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 21:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677AbZE1TcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 15:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbZE1TcW
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 15:32:22 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51097 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbZE1TcW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 15:32:22 -0400
Received: by mail.nrlssc.navy.mil id n4SJWLVQ017777; Thu, 28 May 2009 14:32:21 -0500
In-Reply-To: <20090528191051.GE13499@coredump.intra.peff.net>
X-OriginalArrivalTime: 28 May 2009 19:32:21.0032 (UTC) FILETIME=[04E63280:01C9DFCB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120214>

Jeff King wrote:
> On Wed, May 27, 2009 at 09:17:06PM -0500, Brandon Casey wrote:
> 
>> This library is required on Solaris since hstrerror resides in libresolv.
>> Additionally, on Solaris 7, inet_ntop and inet_pton reside there too.
> 
> Patch works for me on Solaris 8, though it is largely a non-issue:
> hstrerror is only used at all if NO_IPV6 is set, and I don't set that
> for my build.

Ah, in that case I guess NEED_RESOLV should only go in the 5.7 specific
configuration section.

-brandon

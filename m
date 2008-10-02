From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Solaris: Use OLD_ICONV to avoid compile warnings
Date: Thu, 02 Oct 2008 10:25:16 -0500
Message-ID: <5A1KxlhmUIHe8iXPxnXYuNXsq0Yjlbwkz2eBin3z7ELuL9nK-4tSpw@cipher.nrlssc.navy.mil>
References: <1222906127-16900-1-git-send-email-sn_@gmx.net> <20081002010816.GA27415@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Soria Parra <sn_@gmx.net>, git@vger.kernel.org,
	David Soria Parra <dsp@php.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 17:27:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlQ5K-0008Kq-69
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 17:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbYJBP0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 11:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbYJBP0M
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 11:26:12 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55495 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbYJBP0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 11:26:11 -0400
Received: by mail.nrlssc.navy.mil id m92FPGdR018056; Thu, 2 Oct 2008 10:25:16 -0500
In-Reply-To: <20081002010816.GA27415@coredump.intra.peff.net>
X-OriginalArrivalTime: 02 Oct 2008 15:25:16.0541 (UTC) FILETIME=[127FE2D0:01C924A3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97356>

Jeff King wrote:
> On Thu, Oct 02, 2008 at 02:08:47AM +0200, David Soria Parra wrote:
> 
>> Solaris systems use the old styled iconv(3) call and therefore
>> the OLD_ICONV variable should be set. Otherwise we get annoying compile
>> warnings.
> 
> Acked-by: Jeff King <peff@peff.net>
> 
> I set OLD_ICONV on my Solaris build.

Ditto here on 7.

> 
> Do you also unset NEEDS_LIBICONV (and which version of Solaris are you
> running)?

I do not set NEEDS_LIBICONV.

-brandon
